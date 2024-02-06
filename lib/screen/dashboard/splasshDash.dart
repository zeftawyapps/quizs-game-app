import 'dart:async';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_quizs_game/consts/views/decoration.dart';
import 'package:islamic_quizs_game/navigations/navigation_service.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/main_screen.dart';
import 'package:islamic_quizs_game/widgits/loading.dart';
import 'package:quiz_module/constants/api_base_url.dart';
import 'package:quiz_module/medules_test.dart';

import 'package:users_module/bloc/base_bloc/base_bloc.dart';
import 'package:users_module/bloc/base_bloc/base_state.dart';
import 'package:users_module/users_module.dart';
import 'package:users_module/utilis/shardeprefrance/shard_check.dart';

import '../../bloc/auth_bloc.dart';
import '../../consts/views/assets.dart';
import '../../consts/views/colors.dart';
import '../../util/validators/email_validator.dart';
import '../../util/validators/required_validator.dart';
import '../../widgits/alarm/wedgets_functions.dart';
import '../../widgits/generators/input_form/form_validations.dart';
import '../../widgits/generators/input_form/input_fields/text_form_field_validation.dart';


class SplashDashboardScreen extends StatefulWidget {
  const SplashDashboardScreen({super.key});
  static const String path = '/splash';

  @override
  State<SplashDashboardScreen> createState() => _SplashDashboardScreenState();
}

class _SplashDashboardScreenState extends State<SplashDashboardScreen> {
  bool isvisablity = false;
bool isloading = false;
AuthBloc authBloc = AuthBloc();
//form
  ValidationsForm form = ValidationsForm();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }

  void timer() async {


    try {
      Timer(Duration(seconds: 3), () {
        SharedPrefranceChecking sharedPrefranceChecking =  SharedPrefranceChecking();
        sharedPrefranceChecking.IsUserRejised(isRegistAction:  (s  ) => {
Navigator.of(context).push(MaterialPageRoute(builder: (c)=>MainScreen()))
          }  ,NotRegistAction:   () =>  {
          setState(() {
            isvisablity = true;
          })

        });

      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Scaffold(
        body: Container(
          color: Color(0xE4222C3E),
          child: BlocListener<UserModuleBaseBloc, UserModuleBaseState>(
            bloc: authBloc.userModuleBaseBloc,
  listener: (context, state) {
   state.when(init: (){}, loading: (){
       setState(() {
          isloading = true;
        });

   }, success: (d){
       Navigator. of(context).push(MaterialPageRoute(builder: (c)=>MainScreen()));
        setState(() {
            isloading = false;
          });

   }, failure: (e, f){
       showDialog(
           context: context,
           builder: (c) {
             return showAlarme(context, "خطا تسجيل", e.message!);
           }).then((value) {
         setState(() {
           isloading = false;
         });
       });
   },);
  },
  child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 1),
                width: isvisablity ? MediaQuery.of(context).size.width / 2 : 0,
                child: Center(
                  child: Container(
                    color: DasgbordColors.background2,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            "لوحة التحكم",
                            style: (TextStyle(
                                color: DasgbordColors.titelTextFont, fontSize: 20.sp)),
                          ),
                          form.build(context,  [
                            TextFormFieldValidation(
                                textStyle: DashboardDecorations.textFieldText,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: DasgbordColors.inputTextFont,
                                    )),
                                keyData: AuthBloc().emailKey,
                                baseValidation: [RequiredValidator(), EmailValidator()],
                                hintText: "ايميل"),
                            TextFormFieldValidation(
                                textStyle: DashboardDecorations.textFieldText,
                                isPssword: true,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: DasgbordColors.inputTextFont,
                                    )),
                                keyData: AuthBloc().passKey,
                                baseValidation: [RequiredValidator()],
                                hintText: "كلمة المرور"),
                          ])  ,

                          SizedBox(
                            height: 20.h,
                          ),
                          MaterialButton(
                              onPressed: () {
                                
                                authBloc.logIn(map: form.getInputData());
                              },
                              child:
                              Container(
                                width: 150.w,
                                height: 65.h,
                                decoration: DashboardDecorations.bottonDecoration,
                                child: isloading?Center(child: CircularProgressIndicator(
                                  color: Colors.white,
                                )):  Center(
                                  child: Text("تسجيل",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 5.sp)),
                                ),
                              )),
                        ],
                      ).animate().scaleX(
                          duration: Duration(seconds: 1),
                          delay: Duration(milliseconds:4000)),
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                width: isvisablity
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width,
                duration: Duration(seconds: 1),
                child: Center(
                    child: Image(
                  image: AssetImage(AppAsset.imglogo),
                  width: 200,
                  height: 200,
                )),
              ),
            ],
          ),
),
        ),
      ),
    );
  }
}
