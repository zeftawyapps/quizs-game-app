import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_quizs_game/bloc/app_auth_bloc.dart';
import 'package:islamic_quizs_game/consts/views/colors.dart';
import 'package:islamic_quizs_game/consts/views/decoration.dart';
import 'package:islamic_quizs_game/navigations/navigation_service.dart';
import 'package:islamic_quizs_game/screen/app/privacey.dart';
import 'package:quiz_module/https/commerce_http_urls.dart';
import 'package:quiz_module/medules_test.dart';
import 'package:users_module/bloc/base_bloc/base_bloc.dart';
import 'package:users_module/bloc/base_bloc/base_state.dart';
import 'package:users_module/users_module.dart';
import 'package:users_module/utilis/shardeprefrance/shard_check.dart';

import '../../consts/views/assets.dart';
import 'mainScreen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String path = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isvisablity = false;
  AppAuthBloc appAuthBloc = AppAuthBloc();
  bool isChecked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }

  void timer() async {
    // test connection
    try {
      Timer(Duration(seconds: 3), () {
        SharedPrefranceChecking sharedPrefranceChecking =
            SharedPrefranceChecking();
        sharedPrefranceChecking.IsUserRejised(
          isRegistAction: (s) {
            String token = s.token!;
            QuizHttpHeader().setToken(token);

            NavigationService().replacementToPage(path: MainSrcreen.path);
          },
          NotRegistAction: () => {
            setState(() {
              isvisablity = true;
            })
          },
        );
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserModuleBaseBloc, UserModuleBaseState>(
        bloc: appAuthBloc.userModuleBaseBloc,
        listener: (context, state) {
          state.whenOrNull(success: (v) {
            NavigationService().replacementToPage(path: MainSrcreen.path);
          }, failure: (error, d) {
            log(error.toString());
          });
        },
        child: Container(
          decoration: AppDecorations
              .splashBackground, // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.

          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(AppAsset.logo2),
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 20.h,
              ),
              AnimatedContainer(
                  height: isvisablity == true ? 100 : 0,
                  width: isvisablity == true ? 300 : 0,
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: isvisablity == true
                      ? // log in with google
                      Center(
                          child: Column(
                            children: [
                              Expanded(
                                  child: Row(
                                // privacy policy
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (v) {
                                          setState(() {
                                            isChecked = v!;
                                          });
                                        }),
                                  ),
                                  Expanded( flex:  2 ,
                                    child: Text(
                                      ' يجب الموافقة على',
                                      style: TextStyle(
                                        color: AppAssetColors.bottonText,
                                        fontSize: 8.sp,
                                      ),
                                    ),
                                  ),
                                  Expanded( flex: 2 ,
                                    child: InkWell(
                                      onTap: () {
                                        NavigationService().navigateToPage(
                                            path: PrivacyPolicy.path);
                                      },
                                      child: Text(
                                        'سياسة الخصوصية',
                                        style: TextStyle(

                                          fontSize: 10.sp,
                                          color : Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                              Visibility(
                                visible: isChecked,
                                child: MaterialButton(
                                  onPressed: () async {
                                    appAuthBloc.signUp();
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(seconds: 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:isChecked     ?AppAssetColors.background1: Colors.transparent,

                                    ) ,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Signe up with google' ,
                                          style: TextStyle(
                                            color: AppAssetColors.bottonText,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Text("G",
                                            style: TextStyle(
                                              color: AppAssetColors.bottonText,
                                              fontSize: 40.sp,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container()),
            ],
          )),
        ),
      ),
    );
  }
}
