import 'package:flutter/material.dart';
import 'package:hire_hustle/global/theme/app_color/app_color_light.dart';

ThemeData ThemeDataLight() => ThemeData(
  unselectedWidgetColor: AppColorLight.radioButtonUnactiveColor,
  appBarTheme: const AppBarTheme(
    elevation: 1,
    titleTextStyle: TextStyle(
      color: AppColorLight.appBarTitleColor,
      fontSize: 25
    ),
    backgroundColor: AppColorLight.appBarBackgroundColor,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 23,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
        fontSize: 15,
        color: AppColorLight.textColor,
        fontWeight: FontWeight.bold
    ),
    displaySmall: TextStyle(
      fontSize: 10,
      color: AppColorLight.subTextColor,
    ),
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: AppColorLight.iconColor,
  ),
  iconTheme: const IconThemeData(
    color: AppColorLight.iconColor
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(
          side: BorderSide(width: 1, color: AppColorLight.iconColor)
        ),
        backgroundColor: const Color.fromARGB(255, 107, 97, 201)
    )
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColorLight.iconColor
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColorLight.textFormFieldFilledColor,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(
            color: Colors.transparent
        )
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(
            color: AppColorLight.iconColor
        )
    ),
  )
);