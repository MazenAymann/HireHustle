import 'package:flutter/material.dart';

Widget OvalPhotoPlaceholder({
  required context,
  required file,
}) =>
    ClipOval(
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.width / 3,
        color: Colors.transparent,
        child: file == null
            ? Image.asset(
                'assets/images/main_profile_image.png',
                fit: BoxFit.cover,
              )
            : Image.file(
                file,
                fit: BoxFit.cover,
              ),
      ),
    );
