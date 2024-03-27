import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../ThemeData/app_theme.dart';

Future<TimeOfDay?> showCustomTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) async {
  return showDialog<TimeOfDay>(
    context: context,
    builder: (context) {
      return Theme(
        data: ThemeData.dark().copyWith(
          dialogBackgroundColor: Color.fromRGBO(36, 36, 61, 1.0),
        ),
        child: AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0.w), // Set circular borders
            side: BorderSide(color: Colors.transparent), // Set violet borders
          ),
          content: Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width,
            child: TimePickerDialog(
              initialTime: initialTime,
            ),
          ),
        ),
      );
    },
  );
}
