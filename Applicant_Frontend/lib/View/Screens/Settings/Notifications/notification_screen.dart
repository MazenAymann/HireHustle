import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ThemeData/app_theme.dart';
import '../../../../ViewModel/StateManagement/Settings/Notification/notification_screen_cubit.dart';
import '../../../../constants.dart';
import '../../../Components/Settings/Notification/custom_list_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Statics.background()),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
        ),
        body: BlocConsumer<NotificationScreenCubit, NotificationScreenState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            NotificationScreenCubit notificationCubit = BlocProvider.of(context);
            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SwitchListTile(
                  activeColor: AppColorLight.buttonColor,
                  title: Text(
                    'Enable notifications',
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayMedium,
                  ),
                  value: NotificationScreenCubit.isNotificationsEnabled,
                  onChanged: (_) => notificationCubit.triggerNotifications(),
                ),
                customListTile(
                  context: context,
                  title: 'Notification sound',
                  subTitle: 'Default',
                  onTap: () {},
                ),
                customListTile(
                  context: context,
                  title: 'Vibrate',
                  subTitle: 'On',
                  onTap: () {},
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
