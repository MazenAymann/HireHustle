import 'package:flutter/material.dart';
import 'package:hire_hustle/global/Cards/ApplicantCard.dart';

import '../../../global/theme/app_color/app_color_light.dart';

class ApplicantListScreen extends StatelessWidget {
  const ApplicantListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
            'Applicants'
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppColorLight.darkModeImage),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: 15,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                  height: MediaQuery.of(context).size.height/200,
                  color: AppColorLight.separationLineColor
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return ApplicantCard('Mazen Ayman Mohamed', '10/7/2023', 90, 'pending');
              },
          ),
        ),
      ),
    );
  }
}
