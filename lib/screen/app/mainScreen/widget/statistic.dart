import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../consts/views/colors.dart';
class Statistics extends StatelessWidget {
    Statistics({super.key ,
    required this.level ,
    required this.money ,
    required this.scores

    });
int level = 1 ;
int money = 20 ;
int scores = 0 ;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          color: LightColors.backgroundButtom,
          borderRadius: BorderRadius.circular(20),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: LightColors.backgroundButtom,
              spreadRadius: 5,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "المستوى",
                        style: TextStyle(
                            color: LightColors.TextColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        level.toString(),
                        style: TextStyle(
                            color: LightColors.TextColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    // border only lift
                    border: Border(
                      left: BorderSide(
                        color: LightColors.background1,
                        width: 2,
                      ),
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "النقود",
                        style: TextStyle(
                            color: LightColors.TextColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                         money.toString(),
                        style: TextStyle(
                            color: LightColors.TextColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    // border only lift
                    border: Border(
                      left: BorderSide(
                        color: LightColors.background1,
                        width: 2,
                      ),
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "الدرجات",
                        style: TextStyle(
                            color: LightColors.TextColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        scores.toString(),
                        style: TextStyle(
                            color: LightColors.TextColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
