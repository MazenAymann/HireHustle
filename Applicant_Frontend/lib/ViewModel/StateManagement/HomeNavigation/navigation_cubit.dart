import 'package:Applicant_HireHustle/View/Screens/Settings/Dark%20Mode/dark_mode.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:rive/rive.dart';

import '../../../Helpers/CacheHelper.dart';
import '../../../View/Screens/Job Posts/job_list.dart';
import '../../../View/Screens/Settings/settings.dart';
import '../../../constants.dart';
import '../Settings/DarkMode/dark_mode_enum.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

  var index = 0;

  List screenNames = [
    'Job Posts',
    '',
    // ''
  ];

  List screens = [
    JobList(),
    SettingsScreen(),
    // DarkMode(),
  ];

  void navigateBar(index){
    this.index = index;
    emit(NavigationChangePage());
  }

  Artboard? riveArtBoard;

  late RiveAnimationController idleController;
  late RiveAnimationController onController;
  late RiveAnimationController offController;

  void initializeAll() {
    idleController = SimpleAnimation(STATES.Idle_on.name);
    onController = SimpleAnimation(STATES.On.name);
    offController = SimpleAnimation(STATES.Off.name);

    rootBundle.load('assets/animations/dark_mode_switch.riv').then(
          (data) async {
        final file = RiveFile.import(data);
        final artBoard = file.mainArtboard;
        artBoard.addController(offController);
        riveArtBoard = artBoard;
        emit(NavigationInitial());
      },
    );
  }

  void addController(String controllerType) {
    removeAllControllers();
    switch (controllerType) {
      case 'Idle_on':
        riveArtBoard?.artboard.addController(idleController);
        break;
      case 'On':
        riveArtBoard?.artboard.addController(onController);
        break;
      case 'Off':
        riveArtBoard?.artboard.addController(offController);
        break;
      default:
        print('Sorry, UnRecognized Controller.');
    }
  }

  void removeAllControllers() {
    riveArtBoard?.artboard.removeController(idleController);
    riveArtBoard?.artboard.removeController(onController);
    riveArtBoard?.artboard.removeController(offController);
  }

  void triggerDarkMode() {
    Statics.isDarkMode = !Statics.isDarkMode;
    CacheHelper.saveCache(key: 'isDarkMode', value: Statics.isDarkMode);
    if (Statics.isDarkMode ) {
      addController('Off');
      emit(TriggerBackground());
    } else {
      addController('On');
      emit(TriggerBackground());
    }
  }
}
