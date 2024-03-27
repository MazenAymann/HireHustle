import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirehustle/Helpers/NavigationHelper.dart';
import 'package:hirehustle/ViewModel/StateManagement/Applied%20Applicants/applied_applicants_cubit.dart';
import 'package:hirehustle/ViewModel/StateManagement/Applied%20Applicants/applied_applicants_cubit.dart';
import '../../../constants.dart';
import '../View CV/cv_viewer.dart';
import 'applied_applicants.dart';

class ApplicantView extends StatelessWidget {
  ApplicantView({super.key, required this.applicantIndex, this.applicant});

  int applicantIndex;
  var applicant;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'jobCard$applicantIndex',
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/main_background.png',
              ),
              fit: BoxFit.fill),
        ),
        child: BlocBuilder<AppliedApplicantsCubit, AppliedApplicantsState>(
          builder: (context, state) {
            var restData = ['email', 'mobileNumber', 'nationalId'];
            var restDataLabels = ['Email', 'Mobile Number', 'National Id'];
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Statics.isDarkMode? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      NavigationHelper.navigateBack(context);
                    }
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.03),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.1,
                        backgroundImage: applicant['profileImage'] == null || applicant['profileImage'] == ''
                            ? AssetImage(
                            'assets/images/main_profile_image.png')
                            : NetworkImage(applicant['profileImage']) as ImageProvider<Object>,
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
                                    applicant['username'],
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
                                    Icons.location_on_outlined,
                                    color: Color.fromRGBO(177, 83, 126, 1.0),
                                  ),
                                  Text(
                                    applicant['addressLine'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.04,
                                  ),
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: Color.fromRGBO(177, 83, 126, 1.0),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                    '${applicant['age']} years old',
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
                                          Icons.first_page,
                                          color:
                                              Color.fromRGBO(177, 83, 126, 1.0),
                                        ),
                                        Text(
                                          applicant['firstName'],
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
                                          Icons.last_page,
                                          color:
                                              Color.fromRGBO(177, 83, 126, 1.0),
                                        ),
                                        Text(
                                          applicant['lastName'],
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
                                      restDataLabels[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                    Text(
                                      applicant[restData[index]],
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
                                itemCount: restDataLabels.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
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
                                      onPressed: () => NavigationHelper.navigateToWithAnimation(context, PdfViewerPage(username: applicant['username'],pdfUrl: applicant['cvPlaceholder'],)),
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      child: Text(
                                        'Show CV',
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
    );
  }
}
