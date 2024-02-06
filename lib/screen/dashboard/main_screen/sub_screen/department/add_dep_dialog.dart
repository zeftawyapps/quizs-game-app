import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_quizs_game/bloc/dep_bloc.dart';
import 'package:islamic_quizs_game/navigations/navigation_service.dart';
import 'package:quiz_module/bloc/base_bloc/base_bloc.dart';
import 'package:quiz_module/bloc/base_bloc/base_state.dart';
import 'package:quiz_module/model/depratment.dart';

import '../../../../../consts/views/colors.dart';
import '../../../../../consts/views/decoration.dart';
import '../../../../../util/validators/required_validator.dart';
import '../../../../../widgits/generators/input_form/form_validations.dart';
import '../../../../../widgits/generators/input_form/input_fields/text_form_field_validation.dart';

class AddDepDialog extends StatefulWidget {
  AddDepDialog({super.key, this.dep});
  DepartmentBaseModel? dep;
  @override
  State<AddDepDialog> createState() => _AddDepDialogState();
}

class _AddDepDialogState extends State<AddDepDialog> {
  ValidationsForm form = ValidationsForm();
  bool isloading = false;
  DepBloc departmentBloc = DepBloc();
  var map = {};
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
          widget.dep!.depName = map["depName"];

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
    } ,

  child: BlocListener<QuizModuleBaseBloc, QuizModuleBaseState>(
        bloc: departmentBloc.httpInputbloc,
        listener: (context, state) {
          state.when(init: () {
            print("init");
          }, loading: () {
            print("loading");
            setState(() {
              widget.dep = DepartmentBaseModel(depName: map["depName"]);

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
            height: 400.h,
            width: 300.w,
            // add form and
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "اضافة قسم جديد",
                    style: (TextStyle(
                        color: DasgbordColors.titelTextFont, fontSize: 15.sp)),
                  ),
                  form.build(context, [
                    TextFormFieldValidation(
                        controller: TextEditingController(),
                        initValue: widget.dep?.depName,
                        textStyle: DashboardDecorations.textFieldText,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                          Icons.integration_instructions,
                          color: DasgbordColors.inputTextFont,
                        )),
                        keyData: departmentBloc.depNamekey,
                        baseValidation: [RequiredValidator()],
                        hintText: "اسم القسم"),
                  ]),
                  SizedBox(
                    height: 20.h,
                  ),
                  MaterialButton(
                      onPressed: ()   {
                     map    = form.getInputData();

                        if (widget.dep != null) {
                          departmentBloc.editDepartment(
                              map: form.getInputData(),
                              id: widget.dep?.id ?? "");
                        } else {
                          departmentBloc.addDepartment(
                              map: form.getInputData());
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
                                child: Text("تسجيل",
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
