import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_quizs_game/bloc/quiz_bloc.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/sub_screen/quisstions/pubUpmenu.dart';
import 'package:islamic_quizs_game/widgits/alarm/wedgets_functions.dart';
import 'package:quiz_module/model/quiz_model.dart';

import 'add_quiz_dialog.dart';

class QuizItems extends StatelessWidget {
  QuizItems({super.key, required this.quizBaseModel , required this.quizBloc});
  QuizBaseModel quizBaseModel;
  QuizBloc quizBloc ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)
        ,shape: BoxShape.rectangle ,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,

            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        ),

        padding: EdgeInsets.all(10),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10  ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: PopUpMenu(
                        onedit: () {
                          bool value ;
                          showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AddQuizDialog(
                                  quizBaseModel: quizBaseModel, depDocaId: quizBaseModel.depId,
                                );
                              })
                          .then((value) => quizBloc.getQuizs(quizBaseModel.depId));
                        },
                        ondelete: () {

                          showDialog(context: context, builder:(context) => showAlarmeYesNo(context, "الحذف",

                              "هل تريد حذف هذا السؤال؟")
                          ).then((value)   {
                        if(value == true){
                          quizBloc.deleteQuizs(quizBaseModel.id , quizBaseModel.depId);
                          // timer to reload
                          Timer(Duration(milliseconds: 500), () {
                            quizBloc.getQuizsDashboard(quizBaseModel.depId);
                          });
                        }});


                        },
                      )),
              Text(quizBaseModel.question , style: TextStyle(fontSize: 8.sp ),),
              SizedBox(
                height: 10,
              ),
              AnsswerChoos(
                value: 1,
                answer: quizBaseModel.choose1,
                isCorrect: quizBaseModel.answer == 1,
              ),
              AnsswerChoos(
                value: 2,
                answer: quizBaseModel.choose2,
                isCorrect: quizBaseModel.answer == 2,
              ),
              AnsswerChoos(
                value: 3,
                answer: quizBaseModel.choose3,
                isCorrect: quizBaseModel.answer == 3,
              ),
              AnsswerChoos(
                value: 4,
                answer: quizBaseModel.choose4,
                isCorrect: quizBaseModel.answer == 4,
              ),
            ]),
          ),

      ),
    );
  }
}

class AnsswerChoos extends StatelessWidget {
  AnsswerChoos(
      {super.key,
      required this.value,
      required this.answer,
      required this.isCorrect});
  int value = 0;
  String answer = "";
  bool isCorrect = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        padding: EdgeInsets.only(right: 10),
        color: isCorrect ? Color(0x9635f904)
            : Colors.transparent,
        child:    Text(" $value - $answer "
        , style: TextStyle(fontSize: 5.sp , color:   Colors.black),
        ) ,
      ),
    );
  }
}
