import 'package:flutter/material.dart';
import 'package:hire_hustle/ApplicationScreen/modules/hr_profile/personal/screen/personal.dart';
import 'package:hire_hustle/ApplicationScreen/modules/hr_profile/profile/screen/profile.dart';
import '../../../global/theme/app_color/app_color_light.dart';
import 'edit_profile_screen.dart';

class HrProfileScreen extends StatelessWidget {
  const HrProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
            'Profile'
        ),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                );
              },
              child: const Text(
                  'Edit',
                style: TextStyle(
                  color: AppColorLight.appBarTitleColor
                ),
              )
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppColorLight.darkModeImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: const [
            ProfileScreen(),
            Personal(),
          ],
        ),
      ),
    );
  }
}
