import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Helpers/NavigationHelper.dart';
import '../../../../constants.dart';


class TermsPrivacyScreen extends StatelessWidget {
  final String termsOfUseText = """

Welcome to our Applicant Tracking System HireHustle with AI-powered screening and matching capabilities to help streamline the job application process. By using our ATS, you agree to these Terms of Use, which govern your access and use of our ATS.

1. Use of ATS

Our ATS is designed to help job seekers apply to job openings and help employers and HR representatives manage and screen job applications. HireHustle uses AI-powered screening and matching capabilities to provide each applicant with a similarity rate between their CV and the job application CV. The similarity rate is provided for informational purposes only and should not be construed as an endorsement or guarantee of employment.

2. User Information

As part of the application process, job seekers may be required to provide personal information, such as their name, email address, phone number, and CV. Employers and HR representatives may also provide personal information, such as job descriptions and requirements. We will use this information solely for the purpose of facilitating the job application process and will not share or sell this information to third parties for marketing purposes.

3. Changes to Terms of Use

We reserve the right to modify these Terms of Use at any time by posting the modified terms. Your continued use HireHustle after any such changes constitutes your acceptance of the new Terms of Use.
  """;

  final String privacyPolicyText = """

We respect your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and disclose personal information in connection with HireHustle.

1. Information We Collect

We collect personal information, such as your name, email address, phone number, and CV, when you use HireHustle to apply to job openings or when you create an account on our application. Employers and HR representatives may also provide personal information, such as job descriptions and requirements.

2. How We Use Information

We use personal information solely for the purpose of facilitating the job application process. For example, we use personal information to match job seekers with job openings and to provide job seekers with a similarity rate between their CV and the job application CV. We also use personal information to help employers and HR representatives manage and screen job applications.

3. How We Disclose Information

We do not share or sell personal information to third parties for marketing purposes. We may disclose personal information to employers and HR representatives to facilitate the job application process. We may also disclose personal information to third-party service providers who assist us in providing our application, such as hosting providers and email service providers.

4. Security

We take reasonable measures to protect personal information from unauthorized access, use, or disclosure. However, no method of transmission over the Internet or method of electronic storage is completely secure.

5. Changes to Privacy Policy

We reserve the right to modify this Privacy Policy at any time by posting the modified. Your continued use of our ATS after any such changes constitutes your acceptance of the new Privacy Policy.
  """;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Statics.background()),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Statics.isDarkMode? Colors.white : Colors.black,
              ),
              onPressed: () {
                NavigationHelper.navigateBack(context);
              }
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title:  Text('Terms & Privacy', style: Theme.of(context).textTheme.displayLarge,),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Terms of Use',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                 SizedBox(height: 8.h),
                Text(
                  termsOfUseText,
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.justify,
                ),
                 SizedBox(height: 16.h),
                Text(
                  'Privacy Policy',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                 SizedBox(height: 8.h),
                Text(
                  privacyPolicyText,
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
