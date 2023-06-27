import 'package:flutter/material.dart';
import 'package:hire_hustle/ApplicationScreen/modules/applicant_profile_screen/applicant_profile_screen.dart';
import 'package:hire_hustle/global/Methods/MyRatingBar.dart';
import 'package:hire_hustle/global/theme/app_color/app_color_light.dart';

class ApplicantCard extends StatelessWidget {
  String name, date, status;
  int rate;
  ApplicantCard(this.name, this.date, this.rate, this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    bool isShow = false;
    IconData icon;
    Color color;
    switch (status) {
      case 'accepted':
        icon = Icons.check_circle;
        color = Colors.green;
        isShow = false;
        break;
      case 'rejected':
        icon = Icons.cancel;
        color = Colors.red;
        isShow = false;
        break;
      case 'pending':
        icon = Icons.watch_later;
        color = Colors.grey;
        isShow = true;
        break;
      default:
        icon = Icons.watch_later;
        color = Colors.grey;
        break;
    }
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ApplicantProfileScreen()),
        );
      },
      padding: EdgeInsets.zero,
      child: Container(
        margin: const EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height/12,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(bottom: 10, right: 5),
          leading: const CircleAvatar(
            radius: 30,
            backgroundColor: AppColorLight.borderImageColor,
            child: CircleAvatar(
              radius: 27,
              backgroundColor: Colors.black,
            ),
        ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  name,
                  style: Theme.of(context).textTheme.displayMedium
              ),
              Text(
                  'Applied on $date',
                  style: Theme.of(context).textTheme.displaySmall
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyRatingBar(rating: rate.toDouble()),
                  Text(
                      '$rate%',
                      style: Theme.of(context).textTheme.displaySmall
                  )
                ],
              ),
              const SizedBox(
                width: 10.0,
              ),
              Icon(
                icon,
                color: color,
              )
            ],
          ),
        ),
      ),
    );
  }
}