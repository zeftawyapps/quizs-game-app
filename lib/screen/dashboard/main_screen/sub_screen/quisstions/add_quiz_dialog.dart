import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_quizs_game/bloc/dep_bloc.dart';
import 'package:islamic_quizs_game/navigations/navigation_service.dart';
import 'package:quiz_module/bloc/base_bloc/base_bloc.dart';
import 'package:quiz_module/bloc/base_bloc/base_state.dart';
import 'package:quiz_module/model/quiz_model.dart';

import '../../../../../bloc/quiz_bloc.dart';
import '../../../../../consts/views/colors.dart';
import '../../../../../consts/views/decoration.dart';
import '../../../../../util/validators/required_validator.dart';
import '../../../../../widgits/generators/input_form/form_validations.dart';
import '../../../../../widgits/generators/input_form/input_fields/text_form_field_validation.dart';

class AddQuizDialog extends StatefulWidget {
  AddQuizDialog({super.key, required this.depDocaId, this.quizBaseModel});
  String depDocaId;
  QuizBaseModel? quizBaseModel;
  @override
  State<AddQuizDialog> createState() => _AddQuizDialogState();
}

class _AddQuizDialogState extends State<AddQuizDialog> {
  ValidationsForm form = ValidationsForm();
  bool isloading = false;
  QuizBloc quizBloc = QuizBloc();
  int answer = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.quizBaseModel != null) {
      answer = widget.quizBaseModel!.answer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocListener<QuizModuleBaseBloc, QuizModuleBaseState>(
        bloc: quizBloc.bloc,
        listener: (context, state) {
          state.when(init: () {
            print("init");
          }, loading: () {
            print("loading");
            setState(() {
              isloading = true;
            });
          }, success: (d) {
            print("success");
            setState(() {
              isloading = false;
            });
            Navigator.of(context).pop();
          }, failure: (e, r) {
            print("failed");
            setState(() {
              isloading = false;
            });
          });
        },
        child: Container(
            height: 800.h,
            width: 300.w,
            // add form and
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "اضافة سؤال جديد",
                      style: (TextStyle(
                          color: DasgbordColors.titelTextFont, fontSize: 15.sp)),
                    ),
                    form.build(context, [
                      TextFormFieldValidation(
                        controller: TextEditingController(),
                        initValue: widget.quizBaseModel?.question,
                        textStyle: DashboardDecorations.textFieldText,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                          Icons.quiz,
                          color: DasgbordColors.inputTextFont,
                        )),
                        keyData: quizBloc.quession,
                        baseValidation: [RequiredValidator()],
                        hintText: "السؤال",
                        padding: EdgeInsets.only(bottom: 30.h),
                      ),
                      TextFormFieldValidation(
                          controller: TextEditingController(),
                          initValue: widget.quizBaseModel?.choose1,
                          textStyle: DashboardDecorations.textFieldText,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                            Icons.question_answer,
                            color: DasgbordColors.inputTextFont,
                          )),
                          keyData: quizBloc.choise1,
                          baseValidation: [RequiredValidator()],
                          hintText: "اجابة 1"),
                      TextFormFieldValidation(
                          controller: TextEditingController(),
                          initValue: widget.quizBaseModel?.choose2,
                          textStyle: DashboardDecorations.textFieldText,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                            Icons.question_answer,
                            color: DasgbordColors.inputTextFont,
                          )),
                          keyData: quizBloc.choise2,
                          baseValidation: [RequiredValidator()],
                          hintText: "اجابة 2"),
                      TextFormFieldValidation(
                          controller: TextEditingController(),
                          initValue: widget.quizBaseModel?.choose3,
                          textStyle: DashboardDecorations.textFieldText,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                            Icons.question_answer,
                            color: DasgbordColors.inputTextFont,
                          )),
                          keyData: quizBloc.choise3,
                          baseValidation: [RequiredValidator()],
                          hintText: "اجابة 3"),
                      TextFormFieldValidation(
                          controller: TextEditingController(),
                          initValue: widget.quizBaseModel?.choose4,
                          textStyle: DashboardDecorations.textFieldText,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                            Icons.question_answer,
                            color: DasgbordColors.inputTextFont,
                          )),
                          keyData: quizBloc.choise4,
                          baseValidation: [RequiredValidator()],
                          hintText: "اجابة 4"),
                    ]),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: DasgbordColors.background1,
                          size: 15.sp,
                        ),
                        Text(
                          "الاجابة الصحيحة",
                          style: TextStyle(
                              color: DasgbordColors.titelTextFont, fontSize: 10.sp),
                        ),
                      ],
                    ),
                    StatefulBuilder(
                      builder: (context , s ) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          // the decoration like textfeild theam
                          decoration: BoxDecoration(
                            color: DasgbordColors.textFields,
                            borderRadius: BorderRadius.circular(15.sp),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Row(
                                    children: [
                                      Radio(
                                        value: 1,
                                        groupValue: answer,
                                        onChanged: (value) {
                                          s(() {
                                            answer = value as int;
                                          });
                                        },
                                      ),
                                      Text("1",
                                          style: TextStyle(
                                              color: DasgbordColors.titelTextFont,
                                              fontSize: 5.sp)),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    children: [
                                      Radio(
                                        value: 2,
                                        groupValue: answer,
                                        onChanged: (value) {
                                          s(() {
                                            answer = value as int;
                                          });
                                        },
                                      ),
                                      Text("2",
                                          style: TextStyle(
                                              color: DasgbordColors.titelTextFont,
                                              fontSize: 5.sp)),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    children: [
                                      Radio(
                                        value: 3,
                                        groupValue: answer,
                                        onChanged: (value) {
                                          s(() {
                                            answer = value as int;
                                          });
                                        },
                                      ),
                                      Text("3",
                                          style: TextStyle(
                                              color: DasgbordColors.titelTextFont,
                                              fontSize: 5.sp)),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    children: [
                                      Radio(
                                        value: 4,
                                        groupValue: answer,
                                        onChanged: (value) {
                                          s(() {
                                            answer = value as int;
                                          });
                                        },
                                      ),
                                      Text("4",
                                          style: TextStyle(
                                              color: DasgbordColors.titelTextFont,
                                              fontSize: 5.sp)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    MaterialButton(
                        onPressed: () {
                          var map = form.getInputData();
                          map[quizBloc.answer] = answer;
                          map[quizBloc.depDocid] = widget.depDocaId;
                          map[quizBloc.quession] = map[quizBloc.quession];

                          if (widget.quizBaseModel != null) {
                            quizBloc.editQuizs(
                                map: map, id: widget.quizBaseModel!.id!);
                          } else {
                            quizBloc.addQuizs(map: map);
                          }
                        },
                        child: Container(
                          width: 150.w,
                          height: 65.h,
                          decoration: DashboardDecorations.bottonDecoration,
                          child: isloading
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : Center(
                                  child: Text("ادخال",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 5.sp)),
                                ),
                        )),
                  ],
                ),
              ),
            )),
      ),
    ).animate().scale(duration: Duration(milliseconds: 500));
    ;
  }
}
