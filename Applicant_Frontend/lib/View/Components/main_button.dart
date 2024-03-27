import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget MainButton({
  required context,
  required buttonLabel,
  required onPressed,
}) =>
    Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 6,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          buttonLabel,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        style: TextButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: Color.fromRGBO(207, 97, 161, 1),
        ),
      ),
    );