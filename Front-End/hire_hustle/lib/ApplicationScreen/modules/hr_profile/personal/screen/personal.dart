import 'package:flutter/material.dart';

import '../design/personal_container.dart';


class Personal extends StatelessWidget {
  const Personal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: const [
            PersonalContainer(
              title: 'Name',
              text: 'Ahmed Mohamed',
            ),
            PersonalContainer(
              title: 'Role',
              text: 'Software Engineering',
            ),
            PersonalContainer(
              title: 'Phone',
              text: '01140161798',
            ),
            PersonalContainer(
              title: 'Email',
              text: 'ahmedmagition22@gmail.com',
            ),
            PersonalContainer(
              title: 'Birthday Date',
              text: '5/7/2001',
            ),
          ],
        ),
      ),
    );
  }
}