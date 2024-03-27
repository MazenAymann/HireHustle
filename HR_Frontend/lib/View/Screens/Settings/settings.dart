import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hirehustle/Helpers/CacheHelper.dart';
import '../../../ThemeData/app_theme.dart';
import '../../../ViewModel/StateManagement/Settings/settings_screen_cubit.dart';
import '../../Components/Settings/custom_list_tile.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final cacheHelper = Provider.of<CacheHelper>(context);
    var hr = jsonDecode(cacheHelper.getCachedData(key: 'hr'));
    return BlocProvider<SettingsScreenCubit>(
      create: (context) => SettingsScreenCubit()..initializeAll(hr),
      child: BlocConsumer<SettingsScreenCubit, SettingsScreenState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          SettingsScreenCubit settingsScreenCubit = BlocProvider.of(context);
          var imageLink = settingsScreenCubit.imageLink;
          var username = settingsScreenCubit.username;
          return Container(
            color: Colors.transparent,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: MediaQuery.of(context).size.height * 0.1,
                      backgroundImage: imageLink == '' || imageLink == null
                          ? AssetImage(
                          'assets/images/main_profile_image.png')
                          : NetworkImage(imageLink)
                      as ImageProvider,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    username,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) => customListTile(
                      context: context,
                      leadingIcon: settingsScreenCubit.settingsTiles[index]
                          ['leadingIcon'],
                      title: settingsScreenCubit.settingsTiles[index]['title'],
                      onPressed: settingsScreenCubit.settingsListNavigation(
                        context: context,
                        title: settingsScreenCubit.settingsTiles[index]
                            ['title'],
                          hr: hr
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10.h,
                    ),
                    itemCount: settingsScreenCubit.settingsTiles.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
