import 'package:flutter/material.dart';

import '../../../global/theme/app_color/app_color_light.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
            'Contact Us'
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppColorLight.darkModeImage),
              fit: BoxFit.cover),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('images/logo.png'),
                  height: 60,
                  width: 60,
                ),
                Text(
                  'HireHustle',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
            Text(
              'App Version: 1.0.0',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(height: MediaQuery.of(context).size.height/40,),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'E-mail',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/100,),
                  Container(
                    height: MediaQuery.of(context).size.height/15,
                    decoration: BoxDecoration(
                        color: AppColorLight.contactUsTextFieldColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children:  [
                        SizedBox(width: MediaQuery.of(context).size.height/100,),
                        const Icon(
                          Icons.email_outlined
                        ),
                        SizedBox(width: MediaQuery.of(context).size.height/100,),
                        Text(
                            'hire1hustle@gmail.com',
                          style: Theme.of(context).textTheme.displayMedium,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'General Management',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/100,),
                  Container(
                    height: MediaQuery.of(context).size.height/15,
                    decoration: BoxDecoration(
                      color: AppColorLight.contactUsTextFieldColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children:  [
                        SizedBox(width: MediaQuery.of(context).size.height/100,),
                        const Icon(
                            Icons.location_on_outlined,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.height/100,),
                        Text(
                          'Cairo, Egypt',
                          style: Theme.of(context).textTheme.displayMedium,
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
    );
  }
}
