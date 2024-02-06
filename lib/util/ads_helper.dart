import 'dart:io';

import 'package:islamic_quizs_game/app_configs.dart';

class AdHelper {
  static String get bannerAdUnitId {
    // add your own Ad Unit ID here when  envtyp is dev
    if (AppConfigration.envType == EnvType.dev) {
      if (Platform.isAndroid) {
        return "/6499/example/banner";
      } else if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/2934735716";
      } else {
        throw new UnsupportedError('Unsupported platform');
      }
    } else {
      if (Platform.isAndroid) {
        return 'ca-app-pub-5460723757552584/9352302916';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2934735716';
      } else {
        throw new UnsupportedError('Unsupported platform');
      }
    }
  }

  static String get interstitialAdUnitId {
    if (AppConfigration.envType == EnvType.dev) {
      if (Platform.isAndroid) {
        return "/6499/example/interstitial";
      } else if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/4411468910";
      } else {
        throw new UnsupportedError("Unsupported platform");
      }
    } else {
      if (Platform.isAndroid) {
        return "ca-app-pub-5460723757552584/9352302916";
      } else if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/4411468910";
      } else {
        throw new UnsupportedError("Unsupported platform");
      }
    }
  }

  static String get rewardedAdUnitId {
    // add your own Ad Unit ID here when  envtyp is dev
    if (AppConfigration.envType == EnvType.dev) {
      if (Platform.isAndroid) {
        return "/6499/example/rewarded-video";
      } else if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/1712485313";
      } else {
        throw new UnsupportedError("Unsupported platform");
      }
    } else {
      if (Platform.isAndroid) {
        return "ca-app-pub-3940256099942544/5224354917";
      } else if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/1712485313";
      } else {
        throw new UnsupportedError("Unsupported platform");
      }
    }
  }
}
