import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

import '../Helpers/NavigationHelper.dart';
import '../View/Screens/main_screen.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoard();
}

class _OnBoard extends State<OnBoard> {
  late Material materialButton;
  late int index;
  final onboardingPagesList = [
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            width: 0.0,
            color: background,
          ),
        ),
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45.0,
                    vertical: 90.0,
                  ),
                  child: Image.asset('assets/images/vector6.png',
                      color: pageImageColor),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome to HireHustle',
                      style: pageTitleStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'HireHustle is Intelligent Applicant Tracking System, its developed to achieve applicants rights beside that it will facilitate HR processes.',
                      style: pageInfoStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            width: 0.0,
            color: Colors.transparent,
          ),
        ),
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45.0,
                    vertical: 90.0,
                  ),
                  child: Image.asset('assets/images/vector5.png',
                      color: pageImageColor),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Easy & Fast Hiring',
                      style: pageTitleStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Applicants Can Apply For a Job And HR Can Accept The Applicant In Only Few Steps Without Any Effort',
                      style: pageInfoStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            width: 0.0,
            color: Colors.transparent,
          ),
        ),
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45.0,
                    vertical: 90.0,
                  ),
                  child: Image.asset('assets/images/vector3.png',
                      color: pageImageColor),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Smart Recommendation',
                      style: pageTitleStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Artificial Intelligence Plays Role In Making Recommendations And Sorting Best Qualified Applicants By Using Semantic Similarity.',
                      style: pageInfoStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: defaultSkipButtonColor,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 2;
            setIndex(2);
          }
        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Skip',
            style: defaultSkipButtonTextStyle,
          ),
        ),
      ),
    );
  }

  Material get _finishButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: defaultProceedButtonColor,
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {
          NavigationHelper.navigateToReplacement(
            context,
            MainScreen(),
          );
        },
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Finish',
            style: defaultProceedButtonTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/main_background_saturated.png'),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Onboarding(
          pages: onboardingPagesList,
          onPageChange: (int pageIndex) {
            index = pageIndex;
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  width: 0.0,
                  color: Colors.transparent,
                ),
              ),
              child: ColoredBox(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIndicator(
                          netDragPercent: dragDistance,
                          pagesLength: pagesLength,
                          indicator: Indicator(
                            indicatorDesign: IndicatorDesign.line(
                              lineDesign: LineDesign(
                                lineType: DesignType.line_nonuniform,
                              ),
                            ),
                          )),
                      index == pagesLength - 1
                          ? _finishButton
                          : _skipButton(setIndex: setIndex)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
