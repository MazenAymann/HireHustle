import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hire_hustle/global/theme/app_color/app_color_light.dart';
import 'cubit/navigation_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppColorLight.darkModeImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BlocProvider<NavigationCubit>(
            create: (context) => NavigationCubit(),
            child: BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
                NavigationCubit navigationCubit = BlocProvider.of(context);
                return Column(
                  children: [
                    Expanded(
                        child: navigationCubit.screens[navigationCubit.index]),
                    CurvedNavigationBar(
                      height: 50,
                      backgroundColor: AppColorLight.selectedNavigationBarColor,
                      color: AppColorLight.navigationBarColor,
                      animationDuration: const Duration(milliseconds: 300),
                      onTap: (index) => navigationCubit.navigateBar(index),
                      items: const [
                        Icon(
                          Icons.work_history_outlined,
                          color: AppColorLight.navigationBarIconColor,
                        ),
                        Icon(
                          Icons.add_outlined,
                          color: AppColorLight.navigationBarIconColor,
                        ),
                        Icon(
                          Icons.settings_outlined,
                          color: AppColorLight.navigationBarIconColor,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}