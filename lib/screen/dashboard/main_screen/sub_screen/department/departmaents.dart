import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_quizs_game/bloc/dep_bloc.dart';
import 'package:islamic_quizs_game/consts/views/colors.dart';
import 'package:islamic_quizs_game/models/dep_model.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/sub_screen/department/add_dep_dialog.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/sub_screen/department/dep_items.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/sub_screen/quisstions/quiz_screens.dart';
import 'package:islamic_quizs_game/widgits/loading.dart';
import 'package:quiz_module/bloc/base_bloc/base_bloc.dart';
import 'package:quiz_module/bloc/base_bloc/base_state.dart';
import 'package:quiz_module/model/depratment.dart';
import 'package:quiz_module/utilis/models/base_data_model.dart';

import '../../../../../consts/views/assets.dart';

class DapartmentsScreen extends StatefulWidget {
  const DapartmentsScreen({super.key});

  @override
  State<DapartmentsScreen> createState() => _DapartmentsScreenState();
}

class _DapartmentsScreenState extends State<DapartmentsScreen> {
  DepBloc departmentBloc = DepBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    departmentBloc.getDepartments();
  }
@override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();

}
@override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();

}
  @override
  Widget build(BuildContext context) {
    bool isSmall = MediaQuery.of(context).size.width < 600;

    int count = isSmall ? 2 : 4;
    return FadeIn(
      child: Scaffold(
        body: Container(
            child: Column(
          children: [
            Expanded(
                child: Container(
              color: DasgbordColors.background1,
              child: Center(
                  child: Text("شاشة الاقسام",
                      style: TextStyle(color: Colors.white, fontSize: 30))),
            )),
            Expanded(
                flex: 7,
                child: Container(
                  color: DasgbordColors.background1,
                  child: BlocBuilder<
                          QuizModuleBaseBloc<List<DepartmentBaseModel>>,
                          QuizModuleBaseState<List<DepartmentBaseModel>>>(
                      bloc: departmentBloc.bloclist,
                      builder: (context, s) {
                        return s.when(init: () {
                          return Container();
                        }, loading: () {
                          return Container(
                            child: Center(child: Loading()),
                          );
                        }, success: (d) {
                          var data = d;

                          return FadeIn(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: DasgbordColors.accentColors,
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: data!.length + 1,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: count,
                                  childAspectRatio: 1,
                                ),
                                itemBuilder: (context, index) {
                                  if (index == data.length) {
                                    return MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return AddDepDialog();
                                                  })
                                              .then((value) => departmentBloc
                                                  .getDepartments());
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  DasgbordColors.secondryColors,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              border: Border.all(
                                                  color: DasgbordColors
                                                      .background1,
                                                  width: 2),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              color: DasgbordColors.background1,
                                              size: 30,
                                            )),
                                      ),
                                    );
                                  } else {
                                    var depData = QuizDep.fromJson(
                                        data[index].map!, data[index].id!);
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DepItems(
                                        dep: depData,
                                        departmentBloc: departmentBloc,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        }, failure: (d, e) {
                          return Container();
                        });
                      }),
                ))
          ],
        )),
      ),
    );
  }
}
