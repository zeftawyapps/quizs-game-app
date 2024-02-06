import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_quizs_game/bloc/app_dep_bloc.dart';
import 'package:islamic_quizs_game/consts/views/colors.dart';
import 'package:quiz_module/bloc/base_bloc/base_bloc.dart';
import 'package:quiz_module/bloc/base_bloc/base_state.dart';

import '../../../util/audio_play.dart';

class ResultDialog extends StatefulWidget {
  ResultDialog(
      {super.key,
      required this.correct,
      required this.wrong,
        required this.depId,
      required this.total ,
      required this.depLevel ,
        required this.mony
      });
  int correct;
  int wrong;
  int total;
  String depId;
  int depLevel;
  int mony = 0;
  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  AppDepBloc appDepBloc = AppDepBloc();
  bool isRejister = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appDepBloc.setDepGameResult(widget.depId , widget.correct * 100, widget.correct
        , widget.wrong, widget.total, widget.depLevel , widget.mony
    );
  }

  void soundPlay(bool iswin)async{
    PlaySound playSound = PlaySound();
    if(iswin == true){
      await playSound.playwin();
    }else{
      await playSound.playloss();
    }
  }
  @override
  Widget build(BuildContext context) {
bool isWin = widget.correct > widget.wrong ? true : false ;
String winnerOrLoser = isWin == true ? "لقد فزت" : "لقد خسرت";
soundPlay(isWin);
     return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      shadowColor: LightColors.backgroundButtomShadow,
      child: Container(
        height: 400.h,
        width: 200.w,
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(20)),
        child: BlocListener<QuizModuleBaseBloc, QuizModuleBaseState>(
  bloc: appDepBloc.blocHttp,
  listener: (context, state) {
    state.maybeWhen(orElse: (){}
    , success: (v) {
     setState(() {
        isRejister = true;
      });

    }, loading: () {
      print("loading");
    }, failure: (e, r) {
      print("failed");
    }
    ) ;
  },
  child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: isWin == true ? Colors.green : Colors.red,
                    child: Center(
                      child: Text(
                        "$winnerOrLoser  انتهت الاسئلة",
                        style:
                            TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),


                Text("اجمالي الاسئلة : ${widget.total}",
                    style: TextStyle(fontSize: 18.sp)),
                Text(" الاجابات الصحيحة : ${widget.correct}",
                    style: TextStyle(fontSize: 18.sp)),
                Text(" الاجابات الخاطئة: ${widget.wrong}",
                    style: TextStyle(fontSize: 18.sp)),

                Text(
                    " الدرجات : ${widget.correct * 100} من ${widget.total * 100} ",
                    style: TextStyle(fontSize: 18.sp)),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    onPressed: () {
                      if(isRejister == true){
                      Navigator.pop(context);}
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: LightColors.backgroundButtom,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "حسنا",
                          style: TextStyle(
                              fontSize: 20.sp, color: LightColors.TextColor),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
),
      ),
    );
  }
}
