import 'package:dotslash/Authorization/Signup/signupAuth.dart';
import 'package:dotslash/Widgets/authTile.dart';
import 'package:dotslash/colorScheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String userType = "";

  // bool changeButton = false;

  bool passwordObsured = true;

  @override
  Widget build(BuildContext context) {
    SignupAuthorization signupAuth = Provider.of<SignupAuthorization>(context);
    UpdateTileColor updateColorLogin = Provider.of<UpdateTileColor>(context);
    return Scaffold(
      backgroundColor: AppStyle.bgColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                ),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        color: AppStyle.bgColor,
                        width: 200,
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape
                                .circle, // This makes the container circular
                            border: Border.all(
                              color: Colors.white, // Border color
                              width: 2.0, // Border width
                            ),
                          ),
                          child: ClipOval(
                            // ClipOval is used to clip the image into a circular shape
                            child: Image(
                              image: AssetImage("assets/logo/mainlogo.png"),
                              fit: BoxFit
                                  .cover, // Ensure the image covers the circle area
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        "Get ready to do some good",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Column(children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Choose your',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                ' Role',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppStyle.HighlightColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updateColorLogin.role = "Volunteer";
                                updateColorLogin.updateColor(index: 1);
                                userType = "Volunteer";
                                print("AAAAAAAAAAAAAA");
                              },
                              child: AuthTile(
                                myColor: updateColorLogin.VolunteerTile,
                                img: 'assets/login/volunteer.png',
                                text: "Volunteer",
                                textColor: updateColorLogin.TextColorVolunteer,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                updateColorLogin.role = "Ngo";
                                userType = "Ngo";
                                updateColorLogin.updateColor(index: 2);
                              },
                              child: AuthTile(
                                myColor: updateColorLogin.NgoTile,
                                img: 'assets/login/volunteer.png',
                                text: "NGO",
                                textColor: updateColorLogin.TextColorNgo,
                              ),
                            ),
                          ],
                        ),
                      ])
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(height: 00),
              Container(
                width: 280,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          color: Colors.black,
                          padding: const EdgeInsets.only(right: 15),
                          splashRadius: 120,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              passwordObsured = !passwordObsured;
                            });
                          },
                          icon: Icon(
                            passwordObsured
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: passwordObsured,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: 280,
                      height: 50,
                      child: (signupAuth.loading == false)
                          ? ElevatedButton(
                              onPressed: () {
                                signupAuth.signupValidation(
                                    username: _nameController,
                                    emailAddress: _emailController,
                                    password: _passwordController,
                                    context: context,
                                    userType: userType);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppStyle.HighlightColor),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 51.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_back_rounded,
                            color: AppStyle.HighlightColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(
                                  color: AppStyle.HighlightColor,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
