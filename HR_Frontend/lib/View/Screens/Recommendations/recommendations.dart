import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Helpers/NavigationHelper.dart';
import '../../../ThemeData/app_theme.dart';
import '../../../ViewModel/StateManagement/Recommendations/recommendations_cubit.dart';
import '../../../constants.dart';
import '../../Components/Recommendations/recommendation_card.dart';

class RecommendationsScreen extends StatelessWidget {
  RecommendationsScreen({super.key, this.jobPostId, this.appliedApplicants, required this.semantic});

  var jobPostId;
  var appliedApplicants;
  bool semantic;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/main_background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: BlocProvider<RecommendationsCubit>(
        create: (context) {
          if (semantic) {
            return RecommendationsCubit()
              ..makeRecommendationsBySemanticSimilarity(
                jobPostId,
                appliedApplicants,
              );
          } else {
            return RecommendationsCubit()
              ..makeRecommendationsByTextSimilarity(
                jobPostId,
                appliedApplicants,
              );
          }
        },
        child: BlocConsumer<RecommendationsCubit, RecommendationsState>(
          listener: (context, state) {},
          builder: (context, state) {
            RecommendationsCubit recommendationsCubit =
                BlocProvider.of(context);
            var applicants = recommendationsCubit.sortedApplicants;
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Statics.isDarkMode? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      NavigationHelper.navigateBack(context);
                    }
                ),
              ),
              body: applicants == null
                  ? Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(207, 97, 161, 1),
                        ),
                      )
                  : Column(
                      children: [
                        Container(
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height / 200,
                                color: AppColorLight.separationLineColor,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              var rate = recommendationsCubit.recommendationsResult['${applicants[index]['id']}'];
                              return RecommendationListCard(
                                  context: context,
                                  username: applicants[index]['username'],
                                  applicantIndex: index,
                                  rate: rate,
                                sortedApplicants: applicants,
                                  faceIcon: recommendationsCubit.faceIcon(rate),
                                faceColor: recommendationsCubit.faceColor(rate),
                              );
                            },
                            itemCount: applicants.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
