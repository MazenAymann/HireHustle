import 'package:flutter/material.dart';

import '../../../global/theme/app_color/app_color_light.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _isNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
            'Notifications'
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppColorLight.darkModeImage),
              fit: BoxFit.cover),
        ),
        child: ListView(
          children: [
            SwitchListTile(
              activeColor: AppColorLight.buttonColor,
              title: Text(
                  'Enable notifications',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              value: _isNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _isNotificationsEnabled = value;
                });
              },
            ),
            ListTile(
              title: Text(
                  'Notification sound',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              subtitle: Text(
                  'Default',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              onTap: () {
                // TODO: Implement notification sound selection
              },
            ),
            ListTile(
              title: Text(
                  'Vibrate',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              subtitle: Text(
                  'On',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              onTap: () {
                // TODO: Implement vibrate setting
              },
            ),
          ],
        ),
      ),
    );
  }
}