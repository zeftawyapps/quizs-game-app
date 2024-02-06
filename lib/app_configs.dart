import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:islamic_quizs_game/consts/views/assets.dart';
import 'package:islamic_quizs_game/screen/app/splassh.dart';
import 'package:islamic_quizs_game/screen/dashboard/splasshDash.dart';
import 'package:islamic_quizs_game/util/jsonengen/json_asset_reader.dart';
import 'package:quiz_module/https/commerce_http_urls.dart';
import 'package:users_module/https/commerce_http_urls.dart';

abstract class AppConfigration {
  static AppType appType = AppType.App;
  static EnvType envType = EnvType.dev;
  static BackendState backendState = BackendState.remote;

  static Future FirebaseInit() async {
    try {
      var data =
          await JsonAssetReader(path: AppConfigAssets.firebaseConfig).data;
      var firebaseConfig = data['firebaseConfig'];
      if (envType == EnvType.prod) {
        var prod = firebaseConfig['prod'];
        await Firebase.initializeApp(
            options: FirebaseOptions(
                apiKey: prod['apiKey'],
                appId: prod['appId'],
                messagingSenderId: prod['messagingSenderId'],
                projectId: prod['projectId'],
                storageBucket: prod['storageBucket']));
      } else {
        var dev = firebaseConfig['dev'];
        await Firebase.initializeApp(
            options: FirebaseOptions(
                apiKey: dev['apiKey'],
                appId: dev['appId'],
                messagingSenderId: dev['messagingSenderId'],
                projectId: dev['projectId'],
                storageBucket: dev['storageBucket']));
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future backenRoutsdInit() async {
    var data = await JsonAssetReader(path: AppConfigAssets.BaseUrl).data;
    var baseUrls = data['baseUrls'];
    String QuizebaseUrl;
    String useerbaseUrl;
    if (backendState == BackendState.local) {
      QuizebaseUrl = baseUrls['local'];
      useerbaseUrl = baseUrls['local'];
    } else {
      QuizebaseUrl = baseUrls['remote'];
      useerbaseUrl = baseUrls['remote'];
    }
    QuizBaseUrlEnveiroment(baseUrl: "$QuizebaseUrl");
    UsersUrlEnveiroment(baseUrl: "$useerbaseUrl");
  }

  static Widget _launchWidget({required Widget web, required Widget mobile}) {
    if (kIsWeb) {
      return web;
    } else {
      return mobile;
    }
  }

  static Widget _launchWeb({required Widget web, required Widget dashboard}) {
    if (appType == AppType.App) {
      return web;
    } else {
      return dashboard;
    }
  }

  static Widget launchScreen() {
    return _launchWidget(
        web: _launchWeb(
          web: const SplashScreen(),
          dashboard: SplashDashboardScreen(),
        ),
        mobile: SplashScreen());
  }

  static String baseRoute() {
    if (appType == AppType.App) {
      return SplashScreen.path;
    } else {
      return SplashScreen.path;
    }
  }
}

enum AppType { DashBord, App }

enum EnvType { localDev, dev, prod }

enum BackendState { local, remote }
