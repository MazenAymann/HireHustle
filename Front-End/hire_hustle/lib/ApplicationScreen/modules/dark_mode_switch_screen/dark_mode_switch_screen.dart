import 'package:flutter/material.dart';

import '../../../global/theme/app_color/app_color_light.dart';

class DarkModeToggleScreen extends StatefulWidget {
  const DarkModeToggleScreen({Key? key}) : super(key: key);

  @override
  _DarkModeToggleScreen createState() => _DarkModeToggleScreen();
}

class _DarkModeToggleScreen extends State<DarkModeToggleScreen> {
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Dark Mode'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppColorLight.darkModeImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 90.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Text(
                    'On',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Radio(
                  activeColor: AppColorLight.radioButtonActiveColor,
                  value: true,
                  groupValue: _isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      _isDarkMode = value!;
                      // Apply dark mode changes here
                    });
                  },
                ),
              ),
              ListTile(
                leading: Text(
                    'Off',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                trailing: Radio(
                  activeColor: AppColorLight.radioButtonActiveColor,
                  value: false,
                  groupValue: _isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      _isDarkMode = value!;
                      // Apply light mode changes here
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}