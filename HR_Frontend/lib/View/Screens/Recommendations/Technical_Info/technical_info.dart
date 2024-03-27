import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirehustle/ThemeData/app_theme.dart';
import 'package:hirehustle/View/Components/Technical%20Info/custom_container.dart';

import '../../../../Helpers/NavigationHelper.dart';
import '../../../../ViewModel/StateManagement/Technical Info/technical_info_cubit.dart';
import '../../../../constants.dart';

class TechnicalInfo extends StatelessWidget {
  TechnicalInfo({Key? key, this.cvLink}) : super(key: key);

  var cvLink;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TechnicalInfoCubit()..getTechnicalData(cvLink: cvLink),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/main_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: BlocConsumer<TechnicalInfoCubit, TechnicalInfoState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            TechnicalInfoCubit technicalInfoCubit = BlocProvider.of(context);
            var technicalData = technicalInfoCubit.technicalData;
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
              body: technicalInfoCubit.technicalData == null
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 175, 83, 125),
                    ))
                  : Container(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Text(
                              technicalData['Industry Name'][0] == "N/A"
                                  ? "No Industry Name Found"
                                  : technicalData['Industry Name'][0],
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (technicalData['LinkedIN Profile']
                                        .startsWith("https://")) {
                                      technicalInfoCubit.launchURL(
                                          '${technicalData['LinkedIN Profile']}');
                                    } else {
                                      technicalInfoCubit.launchURL(
                                          'https://${technicalData['LinkedIN Profile']}');
                                    }
                                  },
                                  child: Image.asset(
                                    'assets/images/linkedin.png',
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height:
                                        MediaQuery.of(context).size.width / 4,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (technicalData['GitHub Profile']
                                        .startsWith("https://")) {
                                      technicalInfoCubit.launchURL(
                                          '${technicalData['GitHub Profile']}');
                                    } else {
                                      technicalInfoCubit.launchURL(
                                          'https://${technicalData['GitHub Profile']}');
                                    }
                                  },
                                  child: Image.asset(
                                    'assets/images/github.png',
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    height:
                                        MediaQuery.of(context).size.width / 5,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              'Certificates',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 18.sp),
                            ),
                            customContainer(
                              stringData: technicalInfoCubit
                                  .certificates(technicalData['Certificates']),
                              context: context,
                              height: MediaQuery.of(context).size.width / 2,
                              width: MediaQuery.of(context).size.width / 1.1,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              'Experience',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 18.sp),
                            ),
                            customContainer(
                              stringData: technicalInfoCubit
                                  .experience(technicalData['Experience']),
                              context: context,
                              height: MediaQuery.of(context).size.width / 2,
                              width: MediaQuery.of(context).size.width / 1.1,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              'Education',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 18.sp),
                            ),
                            customContainer(
                              stringData: technicalInfoCubit
                                  .educations(technicalData['Education']),
                              context: context,
                              height: MediaQuery.of(context).size.width / 3,
                              width: MediaQuery.of(context).size.width / 1.1,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              'Programming Languages',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 18.sp),
                            ),
                            customContainer(
                              stringData:
                                  technicalInfoCubit.programmingLanguages(
                                      technicalData['Programming Languages']),
                              context: context,
                              height: MediaQuery.of(context).size.width / 2,
                              width: MediaQuery.of(context).size.width / 1.3,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              'Spoken Languages',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 18.sp),
                            ),
                            customContainer(
                              stringData: technicalInfoCubit.spokenLanguages(
                                  technicalData['Spoken Languages']),
                              context: context,
                              height: MediaQuery.of(context).size.width / 4,
                              width: MediaQuery.of(context).size.width / 2,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
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
