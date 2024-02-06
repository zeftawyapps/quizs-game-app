
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_module/constants/api_base_url.dart';
import 'package:quiz_module/https/commerce_http_urls.dart';

import 'app_configs.dart';
import 'app_louncher.dart';
import 'app_route.dart';


void main() async {
  AppConfigration.appType = AppType.DashBord;
  AppConfigration.envType = EnvType.dev;
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
 await AppConfigration.FirebaseInit();
  await AppConfigration.backenRoutsdInit();
  AppRoute.routersInit();
  runApp(const AppLouncher());
}
