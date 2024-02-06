import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamic_quizs_game/widgits/loading.dart';
import 'package:quiz_module/bloc/base_bloc/base_bloc.dart';
import 'package:quiz_module/bloc/base_bloc/base_state.dart';
import 'package:quiz_module/model/depratment.dart';

import '../../../../bloc/app_dep_bloc.dart';
import '../../../../consts/views/assets.dart';
import '../../../../consts/views/colors.dart';

class LoadDepsGridView extends StatefulWidget {
  const LoadDepsGridView({super.key});

  @override
  State<LoadDepsGridView> createState() => _LoadDepsGridViewState();
}

class _LoadDepsGridViewState extends State<LoadDepsGridView> {
  AppDepBloc bloc = AppDepBloc();
  List<bool> isclicked = [];
  (String id, String name) args = ("", "");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getDepartment();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizModuleBaseBloc, QuizModuleBaseState>(
      bloc: bloc.bloclist,
      builder: (context, state) {
        return state.when(
            init: () {
              return Container();
            },
            loading: () => Container(
                  child: Center(
                    child: Loading(),
                  ),
                ),
            success: (v) {
              var data = v as List<DepartmentBaseModel>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: GridView.builder(
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                          childAspectRatio: 2.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        isclicked.add(false);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              isclicked[index] = !isclicked[index];
                              if (isclicked[index]) {
                                // for eache element in list make it false except the clicked one
                                for (var i = 0; i < isclicked.length; i++) {
                                  if (i != index) {
                                    isclicked[i] = false;
                                  }
                                }
                              }
                            });
                          },
                          child: AnimatedContainer(
                                  duration: Duration(milliseconds: 1000),
                                  height: isclicked[index] ? 150.h : 100.h,
                                  decoration: BoxDecoration(
                                    color: LightColors.backgroundButtom,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          AnimatedContainer(
                                            duration: Duration(milliseconds: 200),
                                            height: isclicked[index] ? 30.h : 70.h,
                                            width: isclicked[index] ? 30.w : 70.w,
                                            child: SvgPicture.asset(
                                              AppAsset.quranSVG,
                                              alignment:
                                                  AlignmentDirectional.center,
                                              fit: BoxFit.fitWidth,
                                              color: LightColors.iconColor,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              " ${data[index].depName}",
                                              style: TextStyle(
                                                  color: LightColors.TextColor,
                                                  fontSize:  isclicked[index] ?  10.sp: 15.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      AnimatedContainer(
                                        height: isclicked[index] ? 70.h : 0.h,
                                        child: startGameDep(data[index].id!,
                                            data[index].depName!),
                                        duration: Duration(milliseconds: 200),
                                      )
                                    ],
                                  )))
                              .animate()
                              .fadeIn(
                                  duration: Duration(milliseconds: 1000),
                                  curve: Curves.easeIn),
                        );
                      }),
                ),
              );
            },
            failure: (e, r) {
              return Container();
            });
      },
    );
  }

  Widget startGameDep(String depId, String depName) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: MaterialButton(
        onPressed: () {
          args = (depId, "$depName");
          Navigator.pushNamed(context, "/quiz", arguments: args);
        },
        child: Container(
          decoration: BoxDecoration(
            color: LightColors.backgroundCenter,
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(5, 10), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Text(
              "بدا الاسئلة",
              style: TextStyle(
                  color: LightColors.titelTextColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }



}
