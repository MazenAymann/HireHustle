import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'notification_screen_state.dart';

class NotificationScreenCubit extends Cubit<NotificationScreenState> {
  NotificationScreenCubit() : super(NotificationScreenInitial());

  static bool isNotificationsEnabled = false;

  void triggerNotifications(){
    isNotificationsEnabled = !isNotificationsEnabled;
    emit(NotificationsTriggered());
  }
}
