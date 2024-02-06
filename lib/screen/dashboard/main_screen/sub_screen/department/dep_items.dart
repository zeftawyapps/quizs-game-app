import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_quizs_game/bloc/dep_bloc.dart';
import 'package:islamic_quizs_game/models/dep_model.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/sub_screen/department/add_dep_dialog.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/sub_screen/department/pubUpmenu.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/sub_screen/department/sort_dep_dialog.dart';
import 'package:quiz_module/model/depratment.dart';

import '../../../../../consts/views/assets.dart';
import '../../../../../consts/views/colors.dart';
import '../../../../../widgits/alarm/wedgets_functions.dart';
import '../quisstions/add_quiz_dialog.dart';
import '../quisstions/pubUpmenu.dart';
import '../quisstions/quiz_screens.dart';
import 'mony_dep_dialog.dart';

class DepItems extends StatelessWidget {
  DepItems({super.key, required this.dep, required this.departmentBloc});
  QuizDep dep;
  DepBloc departmentBloc;
  @override
  Widget build(BuildContext context) {
    String name = dep.depName;
    String id = dep.id!;
    int mony = dep.mony!;
    int sort = dep.sort!;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => DashboardQuizScreens(
                    depDocaId: id,
                    depName: name,
                  ))).then((value) => {
                    departmentBloc.getDepartments()
          });
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: PopUpMenuDep(
                    onAddMony: () {
                      showDialog(
                          context: context,
                          builder: (_) => MonyDepDialog(
                                dep: dep,
                              )).then((value) {
                        departmentBloc.getDepartments();
                      });
                    },
                    onsort: () {
                      showDialog(
                          context: context,
                          builder: (_) => SortDepDialog(
                                dep: dep,
                              )).then((value) {
                        departmentBloc.getDepartments();
                      });
                    },
                    onedit: () {
                      showDialog(
                          context: context,
                          builder: (_) => AddDepDialog(
                                dep: dep,
                              )).then((value) {
                        departmentBloc.getDepartments();
                      });
                    },
                    ondelete: () {
                      showDialog(
                              context: context,
                              builder: (context) => showAlarmeYesNo(
                                  context,
                                  "الحذف",
                                  "هل تريد حذف هذا القسم معه الاسئله ؟"))
                          .then((value) {
                        if (value == true) {
                          departmentBloc.deleteDepartment(id: id);
                          // timer to reload
                          Timer(Duration(milliseconds: 500), () {
                            departmentBloc.getDepartments();
                          });
                        }
                      });
                    },
                  )),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  child: SvgPicture.asset(AppAsset.quranSVG,
                      height: 50.sp,
                      width: 50.sp,
                      color:dep.isPublish? DasgbordColors.backgroundpublished :  DasgbordColors.background1),
                ),
              ),
              Expanded(
                child: Text(
                  "$name",
                  style: TextStyle(
                    color:dep.isPublish? DasgbordColors.backgroundpublished :  DasgbordColors.background1,
                    fontSize: 6.sp,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        " المستوى: $sort  ",
                        style: TextStyle(
                          color: DasgbordColors.background1,
                          fontSize: 4.sp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: MaterialButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => SortDepDialog(
                                  dep: dep,
                                )).then((value) {
                              departmentBloc.getDepartments();
                            });
                          },
                          child: Icon(
                            Icons.edit,
                            color: DasgbordColors.background1,
                          )),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        " القيمة: $mony ",
                        style: TextStyle(
                          color: DasgbordColors.background1,
                          fontSize: 4.sp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: MaterialButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => MonyDepDialog(
                                  dep: dep,
                                )).then((value) {
                              departmentBloc.getDepartments();
                            });
                          },
                          child: Icon(
                            Icons.edit,
                            color: DasgbordColors.background1,
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
