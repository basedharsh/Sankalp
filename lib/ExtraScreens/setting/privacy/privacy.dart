import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 65,
        centerTitle: true,
        title: const Text(
          "Privacy",
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
          child: Text("""**Privacy Policy for Volunteer Application**
      
      This Privacy Policy applies to all users of our volunteer application platform ("Platform"). At [Your Organization], we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, disclose, and safeguard your personal data in connection with your use of the Platform.
      
      **Information We Collect:**
      
      When you use our Platform to apply for volunteer opportunities, we may collect the following types of information:
      
      - **Personal Information:** This includes your name, contact information (such as email address, phone number, and address), date of birth, gender, nationality, and identification documents (e.g., passport or driver's license). We may also collect emergency contact information.
      
      - **Resume/CV:** We may collect information from your resume or curriculum vitae (CV), including details about your employment history, educational background, skills, qualifications, and references.
      
      - **Volunteering Preferences:** We may ask for your preferred volunteer roles, availability, and motivations for volunteering.
      
      - **Other Information:** Any additional information you voluntarily provide through the Platform.
      
      **How We Use Your Information:**
      
      We may use the information we collect for the following purposes:
      
      - **Volunteer Recruitment and Placement:** We use your personal information to assess your qualifications and match you with suitable volunteer opportunities.
      
      - **Communication:** We may use your contact information to communicate with you regarding your volunteer application, volunteer assignments, and updates related to our organization.
      
      - **Compliance:** We may use your information to comply with legal obligations and regulations.
      
      **Information Sharing:**
      
      We do not sell, rent, or trade your personal information to third parties. However, we may share your information under certain circumstances:
      
      - **Partner Organizations:** If you apply for volunteer opportunities with partner organizations through our Platform, we may share your application information with them for placement purposes.
      
      - **Legal Compliance:** We may disclose your information to comply with legal requirements, such as responding to subpoenas or government requests.
      
      - **Data Processors:** We may use third-party service providers to process your information for specific purposes, such as data storage and application management. These processors are bound by confidentiality and data protection agreements.
      
      **Data Security:**
      
      We take appropriate measures to protect your personal information from unauthorized access, disclosure, alteration, and destruction. These measures include the use of encryption, access controls, and regular security assessments.
      
      **Your Rights:**
      
      You have certain rights regarding your personal information, including the right to access, correct, delete, or restrict its processing. If you wish to exercise these rights or have any questions about your data, please contact us using the contact information provided below.
      
      **Changes to this Privacy Policy:**
      
      We may update this Privacy Policy to reflect changes in our practices or legal requirements. Any updates will be posted on our website, and the revised policy will be effective immediately.
      
      **Contact Us:**
      
      If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at [Your Contact Information].
      
      **Effective Date:** [Date]
      
      By using our volunteer application platform, you consent to the terms of this Privacy Policy and the collection and use of your personal information as described herein."""),
        ),
      ),
    );
  }
}
