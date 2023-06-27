import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyRatingBar extends StatelessWidget {
  final double rating;
  final int maxRating;

  const MyRatingBar({
    Key? key,
    required this.rating,
    this.maxRating = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.red;
    int choice = 0;
    if (rating >= 0 && rating<= 25) {
      choice = 0;
      color = Colors.red;
    }
    if (rating >= 25 && rating<= 50) {
      choice = 1;
      color = Colors.redAccent;
    }
    if (rating >= 50 && rating<= 75) {
      choice = 2;
      color = Colors.amber;
    }
    if (rating >= 75 && rating<= 85) {
      choice = 3;
      color = Colors.lightGreen;
    }
    if (rating >= 85 && rating<= 100) {
      choice = 4;
      color = Colors.green;
    }
    return RatingBar.builder(
      unratedColor: color,
      onRatingUpdate: (_) {},
      initialRating: rating,
      itemCount: maxRating,
      itemBuilder: (context, index) {
        switch (choice) {
          case 0:
            return const Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 1:
            return const Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.redAccent,
            );
          case 2:
            return const Icon(
              Icons.sentiment_neutral,
              color: Colors.amber,
            );
          case 3:
            return const Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          case 4:
            return const Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}