import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotslash/Authorization/Login/loginAuth.dart';
import 'package:dotslash/Authorization/Login/loginScreen.dart';
import 'package:dotslash/Authorization/Signup/signupAuth.dart';
import 'package:dotslash/ExtraScreens/drawer/my_projects/my_projects.dart';
import 'package:dotslash/ExtraScreens/volunteer_home_screen.dart';
import 'package:dotslash/Widgets/authTile.dart';
import 'package:dotslash/ngoScreens/inivite_upoad.dart';

import 'package:dotslash/ngoScreens/ngoBottomNavbar.dart';
import 'package:dotslash/ngoScreens/ngoHomeScreen.dart';

import 'package:dotslash/ngoScreens/ngoNotApproved.dart';
import 'package:dotslash/ExtraScreens/category_list/category_tabs/category_tab.dart';
import 'package:dotslash/ExtraScreens/drawer/calendar/calendar.dart';
import 'package:dotslash/ExtraScreens/drawer/my_account/my_account.dart';

import 'package:dotslash/ExtraScreens/setting/setting.dart' as setting;
import 'package:dotslash/volunteerScreen/volunteeerBottomNav.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignupAuthorization()),
        ChangeNotifierProvider(create: (context) => LoginAuthorization()),
        ChangeNotifierProvider(
          create: (context) => UpdateTileColor(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        title: "Sankalp",
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/category_tabs': (context) => const CategoryTabs(),
          '/my_account': (context) => const MyAccount(),
          '/hire_volunteer': (context) => const UploadProject(),
          '/my_projects': (context) => const MyProjects(),
          '/calendar': (context) => const CalendarScreen(),
          '/settings': (context) => setting.Settings(),
        },
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, userSnp) {
              if (userSnp.hasData) {
                return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Scaffold(
                            body: SizedBox(height: 0, width: 0));
                      }
                      if (userSnapshot.hasError) {
                        return const Scaffold(
                            body: SizedBox(height: 0, width: 0));
                      }
                      Map<String, dynamic>? userData =
                          userSnapshot.data?.data() as Map<String, dynamic>?;
                      if (userData!["userType"] == "Volunteer") {
                        return VolunteerBottomNav();
                      } else {
                        if (userData["status"] == "Approved") {
                          return NgoBottomNavbar();
                        } else {
                          return const NgoNotApproved();
                        }
                      }
                    });
              } else {
                return const LoginScreen();
              }
            }),
      ),
    );
  }
}
