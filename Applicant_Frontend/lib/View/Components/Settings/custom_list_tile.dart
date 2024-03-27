import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../ThemeData/app_theme.dart';

Widget customListTile({
  required context,
  leadingIcon,
  required title,
  required onPressed,
}) =>
    MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsetsDirectional.zero,
      highlightColor: Colors.transparent,
      child: ListTile(
        leading: Icon(
          leadingIcon,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        trailing: Icon(
          Icons.chevron_right,
          size: 30.sp,
          color: AppColorLight.trailIconColor,
        ),
      ),
    );
