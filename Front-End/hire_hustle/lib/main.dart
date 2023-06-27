import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hire_hustle/global/theme/app_color/app_color_light.dart';
import 'package:hire_hustle/navigation_bar/home_screen.dart';
import 'global/theme/theme_data/theme_data_light.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColorLight.navigationBarColor,
    ));
    return MaterialApp(
      theme: ThemeDataLight(),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen()
    );
  }
}
