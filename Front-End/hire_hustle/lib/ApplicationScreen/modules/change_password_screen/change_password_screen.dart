import 'package:flutter/material.dart';
import 'package:hire_hustle/ApplicationScreen/modules/settings_screen/setting_screen.dart';

import '../../../global/theme/app_color/app_color_light.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
            'Change Password'
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
        child: SafeArea(
          child: Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
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
                    SizedBox(height: MediaQuery.of(context).size.height/20,),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        style: Theme.of(context).textTheme.displayMedium,
                        decoration: InputDecoration(
                          labelText: 'Current Password',
                          prefix: const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(Icons.lock_outline),
                          ),
                          labelStyle: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        style: Theme.of(context).textTheme.displayMedium,
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          prefix: const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(Icons.lock_outline),
                          ),
                          labelStyle: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        style: Theme.of(context).textTheme.displayMedium,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefix: const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(Icons.lock_outline),
                          ),
                          labelStyle: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/20,),
                    ElevatedButton(
                        onPressed: (){
                          //TODO: Implement change password function with validation
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Submit',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
