import 'package:flutter/material.dart';

import '../../../../../global/theme/app_color/app_color_light.dart';

class PersonalContainer extends StatelessWidget {
  final String title;
  final String text;

  const PersonalContainer({super.key,
    required this.title,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 61,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: Theme.of(context).textTheme.displayMedium
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: AppColorLight.separationLineColor),
        ],
      ),
    );
  }
}