import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:islamic_quizs_game/bloc/auth_bloc.dart';
import 'package:islamic_quizs_game/widgits/loading.dart';
import 'package:quiz_module/bloc/base_bloc/base_bloc.dart';
import 'package:quiz_module/bloc/base_bloc/base_state.dart';
import 'package:quiz_module/model/depratment.dart';

import '../../../../bloc/app_auth_bloc.dart';
import '../../../../bloc/app_dep_bloc.dart';
import '../../../../consts/views/assets.dart';
import '../../../../consts/views/colors.dart';
import '../../../../models/dep_model.dart';
import '../../../../models/game_dep_model.dart';

class LoadDepsListView extends StatefulWidget {
    LoadDepsListView({super.key , required this.userGameDep ,

    required this.mony ,
      this. interstitialAd , required this.authBloc
    });
    List<GameDepModel> userGameDep = [];
    int mony   ;
    AppAuthBloc authBloc  ;
    AdManagerInterstitialAd?  interstitialAd;
    @override
  State<LoadDepsListView> createState() => _LoadDepsListViewState();
}

class _LoadDepsListViewState extends State<LoadDepsListView> {
  AppDepBloc bloc = AppDepBloc();
  List<bool> isclicked = [];
  ({String id, String name, int sort, int mony}) args = ( id: "", name : "" ,sort :  1 ,mony:  0);
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
var userGameDep = widget.userGameDep ??[];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {

                        var isDep = userGameDep.where((element) => element.game_dep_id == data[index].id).toList() ;

                        if (isDep.length > 0 ) {
                          print ("isDep ${isDep[0]??""}}") ;

                        }

                        isclicked.add(false);
                        var depData =
                            QuizDep.fromJson(data[index].map!, data[index].id!);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
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
                                    duration: Duration(milliseconds: 200),
                                    height: isclicked[index] ? 200.h : 150.h,
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
                                              duration:
                                                  Duration(milliseconds: 200),
                                              height: 75.h,
                                              width: 75.w,
                                              child: SvgPicture.asset(
                                                AppAsset.quranSVG,
                                                alignment:
                                                    AlignmentDirectional.center,
                                                fit: BoxFit.fitWidth,
                                                color: LightColors.iconColor,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    " ${depData.depName}",
                                                    style: TextStyle(
                                                        color: LightColors
                                                            .TextColor,
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        " قيمة القسم",
                                                        style: TextStyle(
                                                            color: LightColors
                                                                .TextColor,
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        width: 20.w,
                                                      ),
                                                      Text(
                                                        " ${depData.mony}",
                                                        style: TextStyle(
                                                            color: LightColors
                                                                .TextColor,
                                                            fontSize: 25.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        AnimatedContainer(
                                          height: isclicked[index] ? 70.h : 0.h,
                                          child: startGameDep(data[index].id!,
                                              data[index].depName! ,   depData.mony , depData.sort   ),
                                          duration: Duration(milliseconds: 200),
                                        )
                                      ],
                                    )))
                                .animate()
                                .fadeIn(
                                    duration: Duration(milliseconds: 1000),
                                    curve: Curves.easeIn),
                          ),
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

  Widget startGameDep(String depId, String depName  , int mony , int sort  ) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: MaterialButton(
        onPressed: () {
          if (widget.mony >= mony) {
            args = ( id:  depId,name:  "$depName" ,sort:  sort ,mony:  mony );

            if (widget.interstitialAd != null) {
              widget.interstitialAd!.show();
            }

            Navigator.pushNamed(context, "/quiz", arguments: args)
            .then((value) => {
            widget.   authBloc.getUserProfile()
            });
            ;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("لا يوجد لديك النقود الكافية"),
            ));
          }



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

  Widget startGameDepButton (String depId, String depName) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: MaterialButton(
        onPressed: () {
          args = ( id:  depId, name:   "$depName" , sort:  1 ,mony:  0 );
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
