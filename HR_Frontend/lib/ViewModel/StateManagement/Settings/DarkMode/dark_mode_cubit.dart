import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:hirehustle/ViewModel/StateManagement/Settings/DarkMode/dark_mode_enum.dart';
import 'package:meta/meta.dart';
import 'package:rive/rive.dart';

part 'dark_mode_state.dart';

class DarkModeCubit extends Cubit<DarkModeState> {
  DarkModeCubit() : super(DarkModeInitial());

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
        emit(DarkModeInitial());
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

  static bool isDarkMode = true;

  var backgroundImage = 'assets/images/main_background.png';

  void triggerDarkMode() {
    isDarkMode = !isDarkMode;
    print(isDarkMode);
    if (isDarkMode) {
      addController('Off');
      emit(TriggerBackground());
    } else {
      addController('On');
      emit(BackgroundTrigger());
    }
  }
}
