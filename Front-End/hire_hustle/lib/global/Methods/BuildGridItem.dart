import 'package:flutter/material.dart';
import 'package:hire_hustle/global/theme/app_color/app_color_light.dart';

class BuildGridItem extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback onTap;

  const BuildGridItem({
    required this.iconData,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 70,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}