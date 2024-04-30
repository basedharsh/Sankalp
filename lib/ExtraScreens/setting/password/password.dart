import 'package:flutter/material.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key});

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isLoading = false; // Flag to track loading state
  String errorMessage = ''; // Error message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 65,
        centerTitle: true,
        title: const Text(
          "Reset Password",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 22,
            letterSpacing: 1.5,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: currentPasswordController,
              decoration: InputDecoration(
                hintText: "Current Password",
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
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
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                hintText: "New Password",
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
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
              obscureText: true,
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
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
              obscureText: true,
            ),
            const SizedBox(
              height: 32.0,
            ),
            SizedBox(
              width: 250,
              height: 60,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        // Check if the current password is empty
                        if (currentPasswordController.text.isEmpty) {
                          setState(() {
                            errorMessage = "Please fill the correct password.";
                          });
                          return; // Exit the function early
                        }

                        // Clear any previous error message
                        setState(() {
                          errorMessage = "";
                        });

                        // Validate and process the password change here
                        final newPassword = newPasswordController.text;
                        final confirmPassword = confirmPasswordController.text;

                        // Perform validation and password change logic
                        if (newPassword == confirmPassword) {
                          // Passwords match, show loading indicator
                          setState(() {
                            isLoading = true;
                          });

                          // Simulate a 5-second delay
                          Future.delayed(const Duration(seconds: 5), () {
                            // After the delay, navigate back
                            Navigator.pop(context);
                          });
                        } else {
                          // Passwords do not match, show an error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords do not match."),
                            ),
                          );
                          // Clear text fields
                          currentPasswordController.clear();
                          newPasswordController.clear();
                          confirmPasswordController.clear();
                        }
                      },
                style: buildButtonStyle(),
                child: buildButtonContent(),
              ),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  Widget buildButtonContent() {
    if (isLoading) {
      return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(
          Colors.black,
        ),
      );
    } else {
      return Text(
        "Reset",
        style: TextStyle(
          color: isLoading ? Colors.grey : Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
      );
    }
  }

  ButtonStyle buildButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(
        isLoading ? Colors.grey[400] : Colors.black,
      ),
    );
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
