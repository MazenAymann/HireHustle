import 'package:flutter/material.dart';

Widget customListTile({
  required context,
  required title,
  required subTitle,
  required onTap,
}) =>
    ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      onTap: onTap,
    );
