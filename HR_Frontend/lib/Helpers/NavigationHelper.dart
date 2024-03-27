import 'package:flutter/material.dart';

class NavigationHelper {
  static void navigateTo(
    BuildContext context,
    Widget page,
  ) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => page,
        ));
  }

  static void navigateToReplacement(
    BuildContext context,
    Widget page,
  ) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  static void navigateToAndRemoveUntil(
    BuildContext context,
    Widget page,
  ) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
      (route) => false,
    );
  }

  static void navigateBack(BuildContext context) {
    Navigator.pop(
      context,
    );
  }

  // You cant use it without using hero widget in screens.
  static void navigateToWithAnimation(BuildContext context, Widget page){
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return page;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = 0.0;
          var end = 1.0;
          var curve = Curves.ease; // Adjust the curve as needed
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return ScaleTransition(
            scale: animation.drive(tween),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 1500), // Adjust the duration as needed
      ),
    );
  }
}
