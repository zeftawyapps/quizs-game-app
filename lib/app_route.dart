import 'package:flutter/material.dart';
import 'package:islamic_quizs_game/consts/views/assets.dart';
import 'package:islamic_quizs_game/screen/app/privacey.dart';
import 'package:islamic_quizs_game/screen/app/profile_screen/profile_screen.dart';
import 'package:islamic_quizs_game/screen/app/quiz_screen/quiz_screen.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/sub_screen/quisstions/quiz_screens.dart';

import 'navigations/navigation_service.dart';
import 'screen/app/mainScreen/main_screen.dart';

abstract class AppRoute{
  static Map<String, Widget> _router = {
 MainSrcreen.path: const MainSrcreen(),
  QuizScreen.path: const QuizScreen(),
    ProfileScreen.path:   ProfileScreen(),
    PrivacyPolicy.path:  PrivacyPolicy(),
  };
  static void routersInit() {
    NavigationService().setRouters(_router);
  }

}