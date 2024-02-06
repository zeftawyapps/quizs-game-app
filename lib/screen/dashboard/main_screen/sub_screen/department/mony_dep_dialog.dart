import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_quizs_game/bloc/dep_bloc.dart';
import 'package:islamic_quizs_game/models/dep_model.dart';
import 'package:islamic_quizs_game/navigations/navigation_service.dart';
import 'package:quiz_module/bloc/base_bloc/base_bloc.dart';
import 'package:quiz_module/bloc/base_bloc/base_state.dart';
import 'package:quiz_module/model/depratment.dart';

import '../../../../../consts/views/colors.dart';
import '../../../../../consts/views/decoration.dart';
import '../../../../../util/validators/required_validator.dart';
import '../../../../../widgits/generators/input_form/form_validations.dart';
import '../../../../../widgits/generators/input_form/input_fields/text_form_field_validation.dart';

class MonyDepDialog extends StatefulWidget {
  MonyDepDialog({super.key, this.dep});
  QuizDep? dep;
  @override
  State<MonyDepDialog> createState() => _MonyDepDialogState();
}

class _MonyDepDialogState extends State<MonyDepDialog> {
  ValidationsForm form = ValidationsForm();
  bool isloading = false;
  DepBloc departmentBloc = DepBloc();
  Map<String ,dynamic> map = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocListener<QuizModuleBaseBloc, QuizModuleBaseState>(
        bloc: departmentBloc.bloc,
        listener: (context, state) {
          state.when(init: () {
            print("init");
          }, loading: () {
            print("loading");
            setState(() {
              isloading = true;
              widget.dep!.mony = map["mony"]??"";
            });
          }, success: (d) {
            print("success");
            setState(() {
              isloading = false;
            });
            Navigator.of(context).pop();
          }, failure: (e, r) {
            print("failed");
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text(e.message??"حدث خطا"),


                    actions: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: DasgbordColors.background1,
                                borderRadius:
                                BorderRadius.circular(2.sp)),
                            child: Center(child: Text("موافق" , style: TextStyle(fontSize: 10.sp  , color: Colors.white ),))),
                      )
                    ],
                  );
                }).then((value)  {
              setState(() {
                isloading = false;
              });

            }) ;},
          );
        },
        child: BlocListener<QuizModuleBaseBloc, QuizModuleBaseState>(
          bloc: departmentBloc.httpInputbloc,
          listener: (context, state) {
            state.when(init: () {
              print("init");
            }, loading: () {
              print("loading");
              setState(() {
                widget.dep!.sort = map["mony"]??"";

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
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text(e.message??"حدث خطا"),


                      actions: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: DasgbordColors.background1,
                                  borderRadius:
                                  BorderRadius.circular(2.sp)),
                              child: Center(child: Text("موافق" , style: TextStyle(fontSize: 10.sp  , color: Colors.white ),))),
                        )
                      ],
                    );
                  }).then((value)  {
                setState(() {
                  isloading = false;
                });

              }) ;
            });
          },
          child: Container(
              height: 400.h,
              width: 300.w,
              // add form and
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "اضافة قيمة نقدية للقسم ",
                      style: (TextStyle(
                          color: DasgbordColors.titelTextFont,
                          fontSize: 15.sp)),
                    ),
                    form.build(context, [
                      TextFormFieldValidation(
                          controller: TextEditingController(),
                          initValue: widget.dep?.mony==0?"":widget.dep?.mony.toString(),
                          textInputType: TextInputType.number,
                          textStyle: DashboardDecorations.textFieldText,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.integration_instructions,
                                color: DasgbordColors.inputTextFont,
                              )),
                          keyData: departmentBloc.depMonykey,
                          baseValidation: [RequiredValidator()],
                          hintText: "قيمة نقدية"),
                    ]),
                    SizedBox(
                      height: 20.h,
                    ),
                    MaterialButton(
                        onPressed: () {
                          map = form.getInputData();
                          departmentBloc.addMonyDepartment(id: widget.dep!.id!, monyMap: map );
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
              )),
        ),
      ),
    );
  }
}
