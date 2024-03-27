import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirehustle/Helpers/NavigationHelper.dart';
import 'package:hirehustle/View/Screens/HomeNavigation/home_navigation.dart';
import 'package:hirehustle/ViewModel/StateManagement/JobList/job_list_cubit.dart';
import 'package:hirehustle/ViewModel/StateManagement/JobList/job_list_cubit.dart';
import '../../../ThemeData/app_theme.dart';
import '../../../constants.dart';
import '../../Components/Registration/secondary_button.dart';
import '../../Components/snack_bar.dart';
import 'applied_applicants.dart';
import 'edit_job.dart';

class JobViewScreen extends StatelessWidget {
  JobViewScreen({
    super.key,
    required this.jobPostIndex,
    required this.jobPostId,
    required this.jobPost,
  });

  int jobPostIndex;
  int jobPostId;
  var jobPost;

  @override
  Widget build(BuildContext context) {
    var jobListCubit = JobListCubit.get(context);
    return Hero(
      tag: 'jobCard$jobPostIndex',
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/main_background.png',
              ),
              fit: BoxFit.fill),
        ),
        child: BlocProvider(
  create: (context) => JobListCubit(),
  child: BlocConsumer<JobListCubit, JobListState>(
          listener: (context, state) {
            if(state is JobPostDeleted){
              NavigationHelper.navigateToAndRemoveUntil(context, HomeNavigation());
            }
            else if(state is ApiRequestFailed){
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(
                  icon: Icons.mood_bad_outlined,
                  text: state.apiRequestErrorMessage,
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            JobListCubit jobListCubit = BlocProvider.of(context);
            // var validJobPosts = jobListCubit.jobList;
            var jobDetails = [
              'jobDescription',
              'jobRequirements',
              'overtime',
              'benefits',
              'additionalRequirements',
              'expirationPeriod',
              'creationTime'
            ];
            var jobDetailsLabel = [
              'Job Description',
              'Job Requirements',
              'Overtime',
              'Benefits',
              'Additional Requirements',
              'Expiration Period',
              'Creation Time'
            ];
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Statics.isDarkMode? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      NavigationHelper.navigateBack(context);
                    }
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.03),
                    child: PopupMenuButton(
                      splashRadius: 0,
                      color: AppColorLight.contactUsTextFieldColor,
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        // PopupMenuItem<String>(
                        //   onTap: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) =>
                        //               EditJob(jobPost: jobPost),
                        //         ),
                        //       );
                        //     },
                        //   value: 'update',
                        //   child: Text(
                        //     'Edit Job Post',
                        //     style: Theme.of(context).textTheme.displayMedium,
                        //   ),
                        // ),
                        PopupMenuItem<String>(
                          onTap: () {
                            jobListCubit.deleteJobPost(jobPostId: jobPost['id']);
                            // NavigationHelper.navigateBack(context);
                          },
                          value: 'end',
                          child: Text(
                            'Delete Job Post',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ],
                      child: Icon(
                        Icons.delete_sweep_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.03),
                      child: Image.asset(
                        'assets/images/${jobPost['jobCategory']}.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(43, 42, 57, 1.0),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    jobPost['jobTitle'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.category_outlined,
                                    color: Color.fromRGBO(177, 83, 126, 1.0),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                    jobPost['jobCategory'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.04,
                                  ),
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Color.fromRGBO(177, 83, 126, 1.0),
                                  ),
                                  Text(
                                    jobPost['jobLocation'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Color.fromRGBO(97, 165, 207, 1.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.work_history_outlined,
                                          color:
                                              Color.fromRGBO(177, 83, 126, 1.0),
                                        ),
                                        Text(
                                          jobPost['workingHours'] + ' hours',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      color: Color.fromRGBO(97, 165, 207, 1.0),
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.003,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.attach_money_outlined,
                                          color:
                                              Color.fromRGBO(177, 83, 126, 1.0),
                                        ),
                                        Text(
                                          jobPost['salary'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              ListView.separated(
                                itemBuilder: (context, index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      jobDetailsLabel[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                    Text(
                                      jobDetailsLabel[index] ==
                                                  'Expiration Period' ||
                                              jobDetailsLabel[index] ==
                                                  'Creation Time'
                                          ? jobListCubit.convertDateTimeFormat(
                                              jobPost[jobDetails[index]])
                                          : jobPost[jobDetails[index]],
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ],
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                                itemCount: jobDetailsLabel.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color.fromRGBO(
                                              177, 83, 126, 1.0),
                                          const Color(0xFF00CCFF)
                                        ],
                                        begin: Alignment.center,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: MaterialButton(
                                      onPressed: () =>
                                          NavigationHelper.navigateTo(
                                              context,
                                              ApplicantListScreen(
                                                jobPostId: jobPostId,
                                              )),
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      child: Text(
                                        'Show Applicants',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color.fromRGBO(
                                              177, 83, 126, 1.0),
                                          const Color(0xFF00CCFF)
                                        ],
                                        begin: Alignment.center,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: MaterialButton(
                                      onPressed: () =>
                                          NavigationHelper.navigateTo(
                                              context,
                                              EditJob(
                                                jobPost: jobPost,
                                              )),
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      child: Text(
                                        'Edit Job',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
),
      ),
    );
  }
}
