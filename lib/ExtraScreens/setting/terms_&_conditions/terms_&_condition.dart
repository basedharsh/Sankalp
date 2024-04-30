import 'package:flutter/material.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 65,
        centerTitle: true,
        title: const Text(
          "Terms & Conditions",
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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Text(
            """**Terms and Conditions for Volunteer Application**

These Terms and Conditions govern your use of our volunteer application platform ("Platform") provided by [Your Organization]. By accessing and using the Platform, you agree to comply with these Terms and Conditions. Please read them carefully.

**1. Eligibility:**

You must be at least [age] years old to use the Platform. By using the Platform, you represent and warrant that you meet this age requirement and have the legal capacity to enter into these Terms and Conditions.

**2. Volunteer Application Process:**

- The Platform serves as a means for you to apply for volunteer opportunities offered by [Your Organization] and, if applicable, partner organizations.

- You agree to provide accurate, truthful, and complete information in your volunteer application, including your personal information, qualifications, and preferences.

- [Your Organization] reserves the right to accept or reject volunteer applications at its discretion, based on the qualifications and criteria set by [Your Organization] and, if applicable, partner organizations.

**3. Account Creation:**

- To use certain features of the Platform, you may need to create an account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.

- You agree to notify [Your Organization] immediately of any unauthorized use of your account or any other breach of security.

**4. User Conduct:**

- You agree to use the Platform in compliance with all applicable laws and regulations.

- You will not use the Platform to submit false or misleading information, engage in fraudulent activities, or impersonate any person or entity.

- You will not use the Platform to transmit any viruses, malware, or other harmful code, or engage in any activity that may disrupt or interfere with the functioning of the Platform or the servers and networks connected to it.

**5. Intellectual Property:**

- All content and materials on the Platform, including text, graphics, logos, images, software, and any other intellectual property, are the property of [Your Organization] or its licensors and are protected by intellectual property laws. You may not use, reproduce, modify, or distribute any content from the Platform without the express written consent of [Your Organization].

**6. Privacy:**

- Your use of the Platform is also governed by our Privacy Policy, which explains how we collect, use, and protect your personal information. By using the Platform, you consent to the practices described in the Privacy Policy.

**7. Termination:**

- [Your Organization] reserves the right to suspend or terminate your access to the Platform at its discretion, without notice, if you violate these Terms and Conditions or engage in any activity that may harm the Platform or its users.

**8. Changes to Terms and Conditions:**

- [Your Organization] may update these Terms and Conditions from time to time. Any changes will be posted on the Platform, and the revised Terms and Conditions will become effective immediately upon posting.

**9. Governing Law:**

- These Terms and Conditions are governed by and construed in accordance with the laws of [Your Jurisdiction]. Any disputes arising from these Terms and Conditions will be subject to the exclusive jurisdiction of the courts located in [Your Jurisdiction].

**10. Contact Us:**

If you have any questions or concerns about these Terms and Conditions or your use of the Platform, please contact us at [Your Contact Information].

These Terms and Conditions constitute the entire agreement between you and [Your Organization] regarding your use of the Platform and supersede any prior agreements or understandings. Your continued use of the Platform signifies your acceptance of these Terms and Conditions.""",
          ),
        ),
      ),
    );
  }
}
