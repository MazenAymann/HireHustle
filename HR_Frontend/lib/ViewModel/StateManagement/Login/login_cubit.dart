import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hirehustle/Helpers/CacheHelper.dart';
import 'package:hirehustle/ViewModel/APIs/DioHelper.dart';
import 'package:meta/meta.dart';
import 'package:rive/rive.dart';

import 'login_panda_states_enum.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Artboard? riveArtBoard;

  late RiveAnimationController idleController;
  late RiveAnimationController handsUpController;
  late RiveAnimationController handsDownController;
  late RiveAnimationController successController;
  late RiveAnimationController failController;
  late RiveAnimationController lookDownRightController;
  late RiveAnimationController lookDownLeftController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // To identify if you are in focus with password text field.
  final passwordFocusNode = FocusNode();
  bool isLookingRight = false;
  bool isLookingLeft = false;

  void removeAllControllers() {
    riveArtBoard?.artboard.removeController(idleController);
    riveArtBoard?.artboard.removeController(handsUpController);
    riveArtBoard?.artboard.removeController(handsDownController);
    riveArtBoard?.artboard.removeController(successController);
    riveArtBoard?.artboard.removeController(failController);
    riveArtBoard?.artboard.removeController(lookDownRightController);
    riveArtBoard?.artboard.removeController(lookDownLeftController);
    isLookingRight = false;
    isLookingLeft = false;
  }

  void addController(String controllerType) {
    removeAllControllers();
    switch (controllerType) {
      case 'idle':
        riveArtBoard?.artboard.addController(idleController);
        break;
      case 'handsUp':
        riveArtBoard?.artboard.addController(handsUpController);
        break;
      case 'handsDown':
        riveArtBoard?.artboard.addController(handsDownController);
        break;
      case 'success':
        riveArtBoard?.artboard.addController(successController);
        break;
      case 'fail':
        riveArtBoard?.artboard.addController(failController);
        break;
      case 'lookDownRight':
        isLookingRight = true;
        riveArtBoard?.artboard.addController(lookDownRightController);
        break;
      case 'lookDownLeft':
        isLookingLeft = true;
        riveArtBoard?.artboard.addController(lookDownLeftController);
        break;
      default:
        print('Sorry, UnRecognized Controller.');
    }
  }

  void checkPasswordFocusNode() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        addController('handsUp');
      } else if (!passwordFocusNode.hasFocus) {
        addController('handsDown');
      }
    });
  }

  void initializeAll() {
    idleController = SimpleAnimation(STATES.idle.name);
    handsUpController = SimpleAnimation(STATES.Hands_up.name);
    handsDownController = SimpleAnimation(STATES.hands_down.name);
    successController = SimpleAnimation(STATES.success.name);
    failController = SimpleAnimation(STATES.fail.name);
    lookDownRightController = SimpleAnimation(STATES.Look_down_right.name);
    lookDownLeftController = SimpleAnimation(STATES.Look_down_left.name);

    // rootBundle Job? holds all assets we have.
    rootBundle
        .load('assets/animations/panda-login-animation.riv')
        .then((data) async {
      final file = RiveFile.import(data);
      final artBoard = file.mainArtboard;
      // Default Controller = Default Animation View
      artBoard.addController(idleController);
      riveArtBoard = artBoard;
      emit(LoginInitial());
    });
    checkPasswordFocusNode();
  }

  void usernameOnChanged(value) {
    if (value.isNotEmpty && value.length < 16 && !isLookingLeft) {
      addController('lookDownLeft');
    } else if (value.isNotEmpty && value.length >= 16 && !isLookingRight) {
      addController('lookDownRight');
    }
  }

  bool obsecure = true;

  void triggerVisibility() {
    obsecure = !obsecure;
    emit(TriggerVisibility());
  }

  var username = TextEditingController();
  var password = TextEditingController();

  void validateUsernameAndPassword(cacheHelper) {
    // Manual Delay bec, a bug in the library.
    Future.delayed(const Duration(seconds: 1), () {
      if (formKey.currentState!.validate()) {
        login(cacheHelper);
      } else {
        addController('fail');
        Future.delayed(const Duration(seconds: 3), () => addController('idle'),);
      }
    });
  }


  Future<void> login(cacheHelper) async {

    var jsonData = {
      'username': username.text,
      'password': password.text,
    };
    Response response = await DioHelper.postAPI(
      endpoint: 'hr/login',
      data: jsonData,
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.data);
      if (jsonResponse['status'] == 'success') {
        var data = jsonResponse['data'];
        String token = data['token'];
        String hr = jsonEncode(data['hr']);
        cacheHelper.saveCache(key: 'token', value: token);
        cacheHelper.saveCache(key: 'hr', value: hr);
        addController('success');
        emit(LoginSuccess());
        username.clear();
        password.clear();
      } else if (jsonResponse['status'] == 'failed') {
        String loginFailedMessage = jsonResponse['message'];
        addController('fail');
        emit(LoginFailed(loginFailedMessage));
        Future.delayed(const Duration(seconds: 5), () => addController('idle'),);
      }
    } else {
      String apiRequestErrorMessage = 'Sorry, There is a server request error.';
      emit(ApiRequestFailed(apiRequestErrorMessage));
      Future.delayed(const Duration(seconds: 5), () => addController('idle'),);
    }
  }
}
