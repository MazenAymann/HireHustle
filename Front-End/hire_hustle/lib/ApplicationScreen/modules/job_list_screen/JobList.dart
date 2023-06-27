import 'package:flutter/material.dart';
import '../../../global/Cards/JobListCard.dart';
import '../../../global/theme/app_color/app_color_light.dart';

class JobList extends StatelessWidget {
  const JobList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppColorLight.darkModeImage),
              fit: BoxFit.cover),
        ),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return Container(
                height: MediaQuery.of(context).size.height/200,
                color: AppColorLight.separationLineColor
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return JobListCard(
                'Senior Node.js Developer',
                '9/7/2023',
                4,
                6,
                8,
                true
            );},
          itemCount: 15,
        ),
      ),
    );
  }
}
