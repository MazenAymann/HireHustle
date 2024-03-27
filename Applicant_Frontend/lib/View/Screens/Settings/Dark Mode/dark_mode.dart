import 'package:Applicant_HireHustle/ViewModel/StateManagement/HomeNavigation/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../../../ViewModel/StateManagement/Settings/DarkMode/dark_mode_cubit.dart';
import '../../../../constants.dart';

class DarkMode extends StatelessWidget {
  const DarkMode({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationCubit, NavigationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        NavigationCubit navigationCubit = BlocProvider.of(context);
        return GestureDetector(
            onTap: () => navigationCubit.triggerDarkMode(),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              color: Colors.transparent,
              child: Center(
                child: navigationCubit.riveArtBoard == null
                    ? SizedBox.shrink()
                    : Rive(
                  artboard: navigationCubit.riveArtBoard!,
                ),
              ),
            ),
          );
      },
    );
  }
}
