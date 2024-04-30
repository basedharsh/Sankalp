import 'package:flutter/material.dart';
import 'otp_screen/otp_screen.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  static String verify = "";

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  TextEditingController forgotID = TextEditingController();
  TextEditingController countrycode = TextEditingController();
  var phoneNumber = '';

  @override
  void initState() {
    countrycode.text = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 180,
                ),
                child: Container(
                  child: const Column(
                    children: [
                      Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "No problem ! Just enter the mobile\nnumber to reset your password.",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                width: 280,
                child: TextFormField(
                  controller: forgotID,
                  decoration: InputDecoration(
                    prefixText: " +91  ",
                    prefixStyle: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    hintText: "Mobile number",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
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
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 280,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OTPScreen(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
