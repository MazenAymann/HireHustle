import 'package:flutter/material.dart';
import 'package:hire_hustle/ApplicationScreen/modules/contact_us_screen/contact_us_screen.dart';
import 'package:hire_hustle/ApplicationScreen/modules/dark_mode_switch_screen/dark_mode_switch_screen.dart';
import 'package:hire_hustle/ApplicationScreen/modules/hr_profile/all_page.dart';
import 'package:hire_hustle/ApplicationScreen/modules/notification_screen/notification_screen.dart';
import 'package:hire_hustle/ApplicationScreen/modules/terms_and_privacy_screen/terms_and_privacy_screen.dart';
import 'package:hire_hustle/global/theme/app_color/app_color_light.dart';

import '../change_password_screen/change_password_screen.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppColorLight.darkModeImage),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/6,
              padding: const EdgeInsetsDirectional.only(top: 50.0, start: 0.0, end: 0.0),
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  MaterialButton(
                    padding: EdgeInsetsDirectional.zero,
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HrProfileScreen()),
                      );
                    },
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: AppColorLight.borderImageColor,
                        radius: 30.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 27.0,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account Information',
                            style: Theme.of(context).textTheme.displayMedium
                          ),
                          Text(
                            'Mazen Ayman',
                            style: Theme.of(context).textTheme.displaySmall
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColorLight.trailIconColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/200,
              color: AppColorLight.separationLineColor,
            ),
            Column(
              children: [
                MaterialButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ContactUsScreen()),
                    );
                  },
                  padding: EdgeInsetsDirectional.zero,
                  child: ListTile(
                    leading: const Icon(
                      Icons.chat_bubble_outline,
                    ),
                    title: Text('Contact Us',
                      style: Theme.of(context).textTheme.displayMedium
                    ),
                    trailing: const Icon(Icons.chevron_right,
                      size: 30,
                      color: AppColorLight.trailIconColor,
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: AppColorLight.separationLineColor,
                  margin: const EdgeInsetsDirectional.only(start: 17, end: 25),
                ),
                MaterialButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationSettingsScreen()),
                    );
                  },
                  padding: EdgeInsetsDirectional.zero,
                  child: ListTile(
                    leading: const Icon(
                      Icons.notifications_none_outlined,
                    ),
                    title: Text('Notifications',
                      style: Theme.of(context).textTheme.displayMedium
                    ),
                    trailing: const Icon(Icons.chevron_right,
                      size: 30,
                      color: AppColorLight.trailIconColor,
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: AppColorLight.separationLineColor,
                  margin: const EdgeInsetsDirectional.only(start: 17, end: 25),
                ),
                MaterialButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DarkModeToggleScreen()),
                    );
                  },
                  padding: EdgeInsetsDirectional.zero,
                  child: ListTile(
                    leading: const Icon(
                      Icons.dark_mode_outlined,
                    ),
                    title: Text('Dark Mode',
                        style: Theme.of(context).textTheme.displayMedium
                    ),
                    trailing: const Icon(Icons.chevron_right,
                      size: 30,
                      color: AppColorLight.trailIconColor,
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: AppColorLight.separationLineColor,
                  margin: const EdgeInsetsDirectional.only(start: 17, end: 25),
                ),
                MaterialButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
                    );
                  },
                  padding: EdgeInsetsDirectional.zero,
                  child: ListTile(
                    leading: const Icon(
                      Icons.lock_outline,
                    ),
                    title: Text('Change Password',
                      style: Theme.of(context).textTheme.displayMedium
                    ),
                    trailing: const Icon(Icons.chevron_right,
                      size: 30,
                      color: AppColorLight.trailIconColor,
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: AppColorLight.separationLineColor,
                  margin: const EdgeInsetsDirectional.only(start: 17, end: 25),
                ),
                MaterialButton(
                  onPressed: (){
                    //TODO: Implement LogOut function and return to login screen
                  },
                  padding: EdgeInsetsDirectional.zero,
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout,
                    ),
                    title: Text('Log Out',
                      style: Theme.of(context).textTheme.displayMedium
                    ),
                    trailing: const Icon(Icons.chevron_right,
                      size: 30,
                      color: AppColorLight.trailIconColor,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height/200,
              color: AppColorLight.separationLineColor,
            ),
            MaterialButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TermsPrivacyScreen()),
                );
              },
              padding: EdgeInsetsDirectional.zero,
              child: ListTile(
                leading: Text('Terms Of Use & Privacy Policy',
                  style: Theme.of(context).textTheme.displayMedium
                ),
                trailing: const Icon(Icons.chevron_right,
                  size: 30,
                  color: AppColorLight.trailIconColor,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/200,
              color: AppColorLight.separationLineColor,
            ),
          ],
        ),
      ),
    );
  }
}
