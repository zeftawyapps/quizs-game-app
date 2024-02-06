import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_quizs_game/consts/views/assets.dart';
import 'package:islamic_quizs_game/navigations/navigation_service.dart';
import 'package:islamic_quizs_game/screen/app/quiz_screen/choos_ptn.dart';
import 'package:islamic_quizs_game/screen/app/result/result.dart';
import 'package:islamic_quizs_game/widgits/loading.dart';
import 'package:islamic_quizs_game/widgits/main_screens/projectScreen.dart';
import 'package:quiz_module/bloc/base_bloc/base_bloc.dart';
import 'package:quiz_module/bloc/base_bloc/base_state.dart';
import 'package:quiz_module/model/quiz_model.dart';

import '../../../bloc/quiz_bloc.dart';
import '../../../consts/views/colors.dart';
import '../../../util/audio_play.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  static const String path = '/quiz';
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currectanswoer = 2;
  List<int> btnStatus = [0, 0, 0, 0];
  QuizBloc bloc = QuizBloc();
  String depId = "";
  String name = "";
  int sort = 0;
  int mony = 0;

  bool isStarted = false;
  int i = 0;
  int leng = 0;
  bool isAnsered = false;
  int currects = 0;
  int wrongs = 0;
  PlaySound playSound = PlaySound();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void changeQuestion() {
    Timer(Duration(milliseconds: 1200), () {
      setState(() {
        isAnsered = true;
      });
    });
    Timer(Duration(milliseconds: 1300), () {


      setState(() {
        isAnsered = false;
        i++;
        btnStatus = [0, 0, 0, 0];
        if (i == leng) {
          showDialog(
              context: context,
              builder: (context) {
                return ZoomIn(
                    child: ResultDialog(
                  correct: currects,
                  depId: depId,
                  wrong: wrongs,
                  total: leng,
                  depLevel: 1,
                  mony: 0,
                ));
              }).then((value) => NavigationService().goBack());
        }
      });
    });
  }
void startgmae()async{
  await playSound.playStart();

    isStarted = true;

}
  @override
  Widget build(BuildContext context) {
    ({String id, String name, int sort, int mony}) args =
        ModalRoute.of(context)!.settings.arguments as ({
      String id,
      String name,
      int sort,
      int mony
    });

    depId = args.id;
    name = args.name;
    sort = args.sort;
    mony = args.mony;
    if (!isStarted) {
      bloc.getQuizs(depId);

    }

    return ProjectScreen(
        child: Container(
            color: LightColors.background1,
            child: BlocBuilder<QuizModuleBaseBloc, QuizModuleBaseState>(
              bloc: bloc.bloclist,
              builder: (context, state) {
                return state.when(init: () {
                  return Container();
                }, loading: () {
                  return Container(
                    child: Center(
                      child: Loading(),
                    ),
                  );
                }, success: (v) {
                  if (!isStarted)
                  startgmae();

                  if (v.isEmpty) {
                    // add eympty widget and back btn
                    return Container(
                        child: Center(
                            child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "لا يوجد اسئلة",
                          style: TextStyle(
                              color: LightColors.titelTextColor,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            NavigationService().goBack();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                color: LightColors.backgroundButtom,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "رجوع",
                              style: TextStyle(
                                  color: LightColors.iconColor,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    )));
                  }
                  ;

                  List<QuizBaseModel> list = v as List<QuizBaseModel>;
                  leng = list.length;

                  if (i == leng) {
                    return FadeIn(
                      child: Container(
                        child: Center(
                            child: Text(
                          "انتهيت من الاسئلة",
                          style: TextStyle(
                              color: LightColors.titelTextColor,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    );
                  }
                  currectanswoer = list[i].answer;
                  return FadeOut(
                    animate: i == leng,
                    child: Column(children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                NavigationService().goBack();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: LightColors.titelTextColor,
                                size: 30.sp,
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Text(
                              "${args.name}",
                              style: TextStyle(
                                  color: LightColors.titelTextColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "$leng/${i + 1}",
                                        style: TextStyle(
                                            color: LightColors.iconColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: SingleChildScrollView(
                                        child: Text(
                                          " ${list[i].question}",
                                          style: TextStyle(
                                              color: LightColors.iconColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Expanded(
                        flex: 4,
                        child: isAnsered
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(10),
                                child: ListView(
                                  children: [
                                    ChooseBtn(
                                            number: 1,
                                            text: "${list[i].choose1}",
                                            onTap: (i) {
                                              setBtnStatus(i);
                                              changeQuestion();
                                            },
                                            state: btnStatus[0])
                                        .animate()
                                        .flipH(
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.easeIn,
                                            delay: Duration(milliseconds: 100)),
                                    ChooseBtn(
                                            number: 2,
                                            text: "${list[i].choose2}",
                                            onTap: (i) {
                                              setBtnStatus(i);
                                              changeQuestion();
                                            },
                                            state: btnStatus[1])
                                        .animate()
                                        .flipH(
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.easeIn,
                                            delay: Duration(milliseconds: 200)),
                                    ChooseBtn(
                                            number: 3,
                                            text: "${list[i].choose3}",
                                            onTap: (i) {
                                              setBtnStatus(i);
                                              changeQuestion();
                                            },
                                            state: btnStatus[2])
                                        .animate()
                                        .flipH(
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.easeIn,
                                            delay: Duration(milliseconds: 300)),
                                    ChooseBtn(
                                            number: 4,
                                            text: "${list[i].choose4}",
                                            onTap: (i) {
                                              setBtnStatus(i);
                                              changeQuestion();
                                            },
                                            state: btnStatus[3])
                                        .animate()
                                        .flipH(
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.easeIn,
                                            delay: Duration(milliseconds: 400)),
                                  ],
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 20.h,
                      )
                    ]),
                  );
                }, failure: (e, s) {
                  return Container();
                });
              },
            )));
  }

  void setBtnStatus(int i) async{
    int ii = i - 1;
    if (i == currectanswoer) {
      await  playSound.playCurrect();
      setState(()   {
        btnStatus[ii] = 1;
        currects++;

      });

    } else {
      await  playSound.playWrong();
      setState(()   {
        btnStatus[ii] = 2;
        wrongs++;
      });


    }
  }
}
