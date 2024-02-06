import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_quizs_game/bloc/dep_bloc.dart';
import 'package:islamic_quizs_game/bloc/quiz_bloc.dart';
import 'package:islamic_quizs_game/models/dep_model.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/sub_screen/quisstions/add_quiz_dialog.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/sub_screen/quisstions/pubUpmenu.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/sub_screen/quisstions/pubUpmenuForDep.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/sub_screen/quisstions/quiz_items.dart';
import 'package:islamic_quizs_game/widgits/loading.dart';
import 'package:quiz_module/bloc/base_bloc/base_bloc.dart';
import 'package:quiz_module/bloc/base_bloc/base_state.dart';
import 'package:quiz_module/model/quiz_model.dart';

import '../../../../../consts/views/colors.dart';

class DashboardQuizScreens extends StatefulWidget {
  DashboardQuizScreens(
      {super.key, required this.depDocaId, required this.depName});
  String depDocaId = "1";
  String depName = "depName";
  @override
  State<DashboardQuizScreens> createState() => _DashboardQuizScreensState();
}

class _DashboardQuizScreensState extends State<DashboardQuizScreens> {
  QuizBloc quizBloc = QuizBloc();
  DepBloc depBloc = DepBloc();
  bool isloading = false;
  QuizDep? quizDep;
  bool ispublis = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quizBloc.getQuizsDashboard(widget.depDocaId);
    depBloc.getDepartment(widget.depDocaId);
    isloading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // add pubUpmenu
          actions: [
            PopUpMenuDeps(
                ispublis: ispublis,
                onpublish: () {
                  depBloc.publisDepartment(

                      ispublis: !ispublis,
                      id: widget.depDocaId);
                })
          ],
          title: Text(widget.depName, style: TextStyle(fontSize: 10.sp)),
          centerTitle: true,
          backgroundColor: DasgbordColors.background1,
        ),
        body: BlocListener<QuizModuleBaseBloc, QuizModuleBaseState>(
  bloc: depBloc.httpInputbloc,
  listener: (context, state) {
 state.maybeWhen(orElse: (){} , loading: (){} ,
     success: (d){

   // load
     depBloc.getDepartment(widget.depDocaId);
     setState(() {
       isloading = false;
       quizDep = d;
       ispublis = d.isPublish;
     });

  } , failure: (e , r){
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
  child: BlocListener<QuizModuleBaseBloc, QuizModuleBaseState>(
          bloc: depBloc.bloc,
          listener: (context, state) {
            state.maybeWhen(
                loading: () {

                },
                orElse: () {},
                success: (d) {
                  if (isloading == false) {
                    ispublis = d.isPublish;
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text(ispublis
                                ? "تم  نشر قسم ${widget.depName} "
                                : "تم الغاء نشر قسم ${widget.depName} "
                            ),


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
                             quizDep = d;
                            ispublis = d.isPublish;
                          });
                    }) ;

                  } else {
                    setState(() {
                      isloading = false;
                      quizDep = d;
                      ispublis = d.isPublish;
                    });
                  }
                },

                failure: (e, r) {});
          },
          child: Container(
            child: Column(
              children: [
                Expanded(
                    flex: 7,
                    child: BlocBuilder<QuizModuleBaseBloc<List<QuizBaseModel>>,
                        QuizModuleBaseState<List<QuizBaseModel>>>(
                      bloc: quizBloc.bloclist,
                      builder: (context, s) {
                        return s.when(init: () {
                          return Container();
                        }, loading: () {
                          return Container(
                            child: Center(
                                child: Loading(
                              color: DasgbordColors.hintTextFont,
                            )),
                          );
                        }, success: (d) {
                          var data = d;
                          if (data == null ||
                              data.isEmpty ||
                              data.length == 0) {
                            // ad colum with text no quiz and empty icon
                            return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.quiz_outlined,
                                    size: 100,
                                    color: DasgbordColors.background1,
                                  ),
                                  Center(
                                    child: Text("لا يوجد اسئلة",
                                        style: TextStyle(
                                            color: DasgbordColors.background1,
                                            fontSize: 20)),
                                  ),
                                ],
                              ),
                            );
                          }
                          String pulish =
                              ispublis ? "تم النشر" : "لم يتم النشر";
                          return Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 25),
                            color: DasgbordColors.alarmTitle,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                      child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        " :حالة القسم $pulish",
                                        style: TextStyle(fontSize: 5.sp
                                        ,color: ispublis ? Colors.green : Colors.red

                                        ),
                                      )),
                                      Expanded(
                                          child: Text(
                                        "عدد الاسئلة : ${data.length} ",
                                        style: TextStyle(fontSize: 5.sp),
                                      )),
                                    ],
                                  )),
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 17,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: data!.length,
                                    itemBuilder: (context, index) {
                                      return QuizItems(
                                        quizBaseModel: data[index],
                                        quizBloc: quizBloc,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }, failure: (e, r) {
                          return Container(
                            child: Center(
                              child: Text("error"),
                            ),
                          );
                        });
                      },
                    ))
              ],
            ),
          ),
        ),
),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: MaterialButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AddQuizDialog(
                    depDocaId: widget.depDocaId,
                  );
                }).then((value) =>  quizBloc.getQuizsDashboard(widget.depDocaId));
            ;
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Container(
              height: 75.h,
              width: 100.w,
              decoration: BoxDecoration(
                  color: DasgbordColors.background1,
                  borderRadius: BorderRadius.circular(20.sp)),
              child: Center(
                  child: Text(
                "اضافة",
                style: TextStyle(
                    fontSize: 10.sp, color: DasgbordColors.accentColors),
              )),
            ),
          ),
        ));
  }
}
