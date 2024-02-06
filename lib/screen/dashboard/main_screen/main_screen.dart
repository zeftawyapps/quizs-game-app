import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_quizs_game/consts/views/assets.dart';
import 'package:islamic_quizs_game/consts/views/colors.dart';
import 'package:islamic_quizs_game/provider/app_states.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/sub_screen/department/departmaents.dart';
import 'package:islamic_quizs_game/screen/dashboard/main_screen/sub_screen/users_sceen.dart';
import 'package:provider/provider.dart';

import 'widgets/row_botton.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int itemIndex = 0;
  @override
  Widget build(BuildContext context) {
    var _itemIndexProvider = Provider.of<AppStateAndSettings>(context);
    itemIndex = _itemIndexProvider.itemIndex;
    return FadeIn(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: double.infinity,
                      color: DasgbordColors.background1,
                      child: Column(children: [
                        // add image
                        SizedBox(
                          height: 50.h,
                        ),
                        Image.asset(
                          AppAsset.logo2,
                          height: 300.h,
                        ),
                        Expanded(
                          child: Container(
                            color: DasgbordColors.background1,
                            child: Column(
                              children: [
                                MaterialButton(
                                    onPressed: () {
                                      _itemIndexProvider.itemIndex = 0;
                                    },
                                    child: RowBottom(
                                      title: "الاقسام",
                                      itemIndex: 0,
                                    )),
                                MaterialButton(
                                    onPressed: () {
                                      _itemIndexProvider.itemIndex = 1;
                                    },
                                    child: RowBottom(
                                      title: "المستخدمين",
                                      itemIndex: 1,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    )),
                    Expanded(
                        flex: 3,
                        child: Container(
                          height: double.infinity,
                          child: ScreenShow(itemIndex)  ,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ScreenShow(int itemIndex) {
     Map<int, Widget> _screens = {
      0: DapartmentsScreen(),
      1: UsersScreen(),
    };
     Widget _screen = _screens[itemIndex]!;
     return _screen;
    }
  }

