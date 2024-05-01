// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names
import 'package:dotslash/Authorization/Login/loginAuth.dart';
import 'package:dotslash/Authorization/Signup/signUpScreen.dart';
import 'package:dotslash/Widgets/authTile.dart';
import 'package:dotslash/colorScheme.dart';
import 'package:dotslash/forgot_pass_screen/forgot_pass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool passwordObsured = true;
  bool showError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginAuthorization loginAuth = Provider.of<LoginAuthorization>(context);
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
                    // Text(
                    //   "Sankalp",
                    //   style: TextStyle(
                    //       letterSpacing: 2.0,
                    //       fontSize: 60,
                    //       fontWeight: FontWeight.bold,
                    //       color: AppStyle.HighlightColor),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Login to your account",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppStyle.secondaryColor),
                    ),
                    Column(children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Choose your',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppStyle.secondaryColor),
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
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              updateColorLogin.role = "Volunteer";
                              updateColorLogin.updateColor(index: 1);
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
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                width: 280,
                child: Column(
                  children: [
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
                      autocorrect: true,
                      autovalidateMode: AutovalidateMode.disabled,
                      decoration: InputDecoration(
                        hintText: "Password",
                        errorText: showError ? 'Please enter valid text' : null,
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          color: Colors.black,
                          padding: EdgeInsets.only(right: 15),
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
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: passwordObsured,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassScreen(),
                              ),
                            );
                          },
                          // thsiofasidfhasldfl;kahs
                          // testing
                          child: Text(
                            "Forgot password ?",
                            style: TextStyle(
                              color: AppStyle.HighlightColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  SizedBox(
                    width: 280,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // validateEmail();
                          // showError = _passwordController.text.isEmpty;
                          loginAuth.loginValidation(
                              emailAddress: _emailController,
                              password: _passwordController,
                              context: context);
                        });
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(AppStyle.HighlightColor),
                      ),
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
