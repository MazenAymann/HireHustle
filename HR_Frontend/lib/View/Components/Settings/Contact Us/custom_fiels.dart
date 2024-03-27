import 'package:flutter/material.dart';

import '../../../../ThemeData/app_theme.dart';

Widget customField({
  required context,
  required title,
  required fieldLeadingIcon,
  required fieldContent,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 100,
        ),
        Container(
          height: MediaQuery.of(context).size.height / 15,
          decoration: BoxDecoration(
              color: AppColorLight.contactUsTextFieldColor,
              borderRadius: BorderRadius.circular(10),),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.height / 100,
              ),
              Icon(fieldLeadingIcon),
              SizedBox(
                width: MediaQuery.of(context).size.height / 100,
              ),
              Text(
                fieldContent,
                style: Theme.of(context).textTheme.displayMedium,
              )
            ],
          ),
        ),
      ],
    );
