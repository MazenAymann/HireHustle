import 'package:flutter/material.dart';
import 'package:hire_hustle/ApplicationScreen/modules/job_view_screen/job_view_screen.dart';
import 'package:hire_hustle/global/theme/app_color/app_color_light.dart';

import '../../ApplicationScreen/modules/applicant_list_screen/applicant_list_screen.dart';

class JobListCard extends StatelessWidget {
  String jobName,remainingTime;
  int numAccepted, numPending, numApplicants;
  bool isNew;
  JobListCard(this.jobName, this.remainingTime, this.numAccepted, this.numPending, this.numApplicants, this.isNew, {super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: What if there is less than 3 clients applied? (Circle Avatar)
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: (){
        //TODO: Go to job_view_screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const JobViewScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height/12,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                        jobName,
                        style: Theme.of(context).textTheme.displayMedium
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/40,
                    ),
                    Container(
                      width: 30.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                          color: isNew ? AppColorLight.contactUsTextFieldColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Visibility(
                        visible: isNew,
                        child: Center(
                          child: Text(
                              'New',
                              style: Theme.of(context).textTheme.displaySmall
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/4,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/60,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50.0,
                      child: Stack(
                          children: [
                            const CircleAvatar(
                              maxRadius: 10.0,
                              backgroundColor: AppColorLight.borderImageColor,
                              child: CircleAvatar(
                                radius: 9.0,
                                backgroundColor: Colors.black,
                              ),
                            ),
                            const Positioned(
                              left: 10.0,
                              child: CircleAvatar(
                                maxRadius: 10.0,
                                backgroundColor: AppColorLight.borderImageColor,
                                child: CircleAvatar(
                                  radius: 9.0,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                            const Positioned(
                              left: 20.0,
                              child: CircleAvatar(
                                maxRadius: 10.0,
                                backgroundColor: AppColorLight.borderImageColor,
                                child: CircleAvatar(
                                  radius: 9.0,
                                  backgroundColor: Colors.yellow,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 30.0,
                              child: CircleAvatar(
                                maxRadius: 10.0,
                                backgroundColor: AppColorLight.borderImageColor,
                                child: CircleAvatar(
                                  radius: 9.0,
                                  backgroundColor: Colors.grey,
                                  child: Text(
                                    '+$numApplicants',
                                    style: const TextStyle(
                                        fontSize: 8.0,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    const CircleAvatar(
                      radius: 1.0,
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                        '$numAccepted Accepted',
                        style: Theme.of(context).textTheme.displaySmall
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const CircleAvatar(
                      radius: 1.0,
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                        '$numPending Pending',
                        style: Theme.of(context).textTheme.displaySmall
                    ),
                    const SizedBox(
                      width: 90.0,
                    ),
                    Container(
                      width: 60.0,
                      decoration: BoxDecoration(
                          color: AppColorLight.contactUsTextFieldColor,
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 13.0,
                            color: AppColorLight.subTextColor,
                          ),
                          const SizedBox(
                            width: 2.0,
                          ),
                          Text(
                              remainingTime,
                              style: Theme.of(context).textTheme.displaySmall
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
        ),
      ),
    );
  }
}