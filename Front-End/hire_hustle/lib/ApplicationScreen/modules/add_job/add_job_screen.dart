import 'package:flutter/material.dart';
import 'package:hire_hustle/ApplicationScreen/modules/add_job/add_job_done.dart';
import 'package:hire_hustle/ApplicationScreen/modules/add_job/job_description_screen.dart';
import 'package:hire_hustle/ApplicationScreen/modules/add_job/job_requirements_screen.dart';
import 'package:hire_hustle/ApplicationScreen/modules/add_job/job_type_screen.dart';
import 'package:hire_hustle/ApplicationScreen/modules/job_list_screen/JobList.dart';
import 'package:hire_hustle/ApplicationScreen/modules/settings_screen/setting_screen.dart';
import 'package:hire_hustle/global/theme/app_color/app_color_light.dart';

import 'job_optional_requirements.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});

  @override
  _AddJobScreen createState() => _AddJobScreen();
}

class _AddJobScreen extends State<AddJobScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List _onboardingData = [
    const JobTypeSelectionScreen(),
    const JobDescriptionScreen(),
    const JobRequirementsScreen(),
    const JobOptionalReqruiements(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (BuildContext context, int index) {
                  return _onboardingData[index];
                },
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height/50,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                          (index) => buildDot(index),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _onboardingData.length - 1) {
                        _currentPage = 0;
                        _pageController.animateToPage(
                          _currentPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddJobDone()),
                        );
                      } else {
                        _pageController.animateToPage(
                          _currentPage + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(_currentPage == _onboardingData.length - 1
                        ? 'Finish'
                        : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: AppColorLight.statusBarColor,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}