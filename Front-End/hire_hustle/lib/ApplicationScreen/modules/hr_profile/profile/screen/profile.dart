import 'package:flutter/material.dart';
import '../../../../../global/theme/app_color/app_color_light.dart';
import '../design/profile_container.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height/12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Image
            const Padding(
              padding: EdgeInsets.only(top: 40, left: 20),
              child: CircleAvatar(
                backgroundColor: AppColorLight.borderImageColor,
                radius: 50.0,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 49.0,
                ),
              ),
            ),
            // Name & Role
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20, top: 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Ahmed Mohamed",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColorLight.textColor,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'Software Engineering',
                          style: TextStyle(
                            color: AppColorLight.subTextColor,
                          ),
                        ),
                      ],
                    )),
                const Padding(padding: EdgeInsets.only(bottom: 40))
              ],
            ),
          ],
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ProfileContainer(
                icon: Icons.task_outlined,
                text: '7',
                description: 'Job Requests',
                gradient: LinearGradient(
                  colors: [
                    Colors.blue[800]!, // dark blue
                    Colors.blue[500]!, // blue
                    Colors.blue[100]!, // light blue
                  ],
                ),
              ),
              ProfileContainer(
                icon: Icons.thumb_up_alt_outlined,
                text: '90%',
                description: 'Power Work',
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple[600]!, // dark blue
                    Colors.purple[500]!, // blue
                    Colors.purple[100]!, // light blue
                  ],
                ),
              ),
              ProfileContainer(
                icon: Icons.record_voice_over_outlined,
                text: '7',
                description: 'Interviews',
                gradient: LinearGradient(
                  colors: [
                    Colors.deepOrange[600]!, // dark blue
                    Colors.orange[500]!, // blue
                    Colors.orange[100]!, // light blue
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 40,
          color: AppColorLight.contactUsTextFieldColor,
          child: Row(
            children: const [
              SizedBox(
                width: 20,
              ),
              Text(
                'PERSONAL INFO',
                style: TextStyle(color: AppColorLight.subTextColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
