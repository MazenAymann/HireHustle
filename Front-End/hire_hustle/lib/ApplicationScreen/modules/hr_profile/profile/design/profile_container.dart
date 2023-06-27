import 'package:flutter/material.dart';

import '../../../../../global/theme/app_color/app_color_light.dart';

class ProfileContainer extends StatelessWidget {
  final IconData icon;
  final String text;
  final String description;
  final LinearGradient gradient;

  const ProfileContainer({super.key,
    required this.icon,
    required this.text,
    required this.description,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 30),
      height: 135,
      width: 135,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
        gradient: gradient,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                shape: BoxShape.rectangle,
                color: AppColorLight.separationLineColor,
              ),
              child: Icon(
                icon,
                color: AppColorLight.textColor,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}