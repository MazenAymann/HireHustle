import 'package:flutter/material.dart';

import '../../Helpers/NavigationHelper.dart';
import '../../ThemeData/app_theme.dart';
import '../../constants.dart';
import '../Components/main_button.dart';
import 'Login_Registration/login_screen.dart';
import 'Login_Registration/register_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(Statics.background()),
          fit: BoxFit.fill,
        )),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Center(
                  child: Image(
                    image: AssetImage(AppColorLight.darkModeImage),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainButton(
                      context: context,
                      buttonLabel: 'Login',
                      onPressed: () => NavigationHelper.navigateTo(
                        context,
                        LoginScreen(),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/30,
                    ),
                    MainButton(
                      context: context,
                      buttonLabel: 'Register',
                      onPressed: () => NavigationHelper.navigateTo(context, RegistrationScreen()),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
