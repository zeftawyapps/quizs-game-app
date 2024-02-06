import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../consts/views/colors.dart';

class ChooseBtn extends StatelessWidget {
  ChooseBtn(
      {super.key,
      required this.number,
      required this.text,
      required this.onTap,
      required this.state});
  int number;
  String text;
  // coll back void with int prom
  Function(int i) onTap;
  int state = 0;
  Color backColor(int state) {
    if (state == 0) {
      return LightColors.backgroundButtom;
    } else if (state == 1) {
      return LightColors.currectAnswer;
    } else {
      return LightColors.wrongAncswer;
    }
  }

  Color backColorShadow(int state) {
    if (state == 0) {
      return LightColors.backgroundButtomShadow;
    } else if (state == 1) {
      return LightColors.currectAnswerShadow;
    } else {
      return LightColors.wrongAncswerShadow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(number);
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: backColor(state),
              borderRadius: BorderRadius.circular(20),
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: backColorShadow(state),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0.5, .5), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("$number -",
                        style: TextStyle(
                            color: LightColors.iconColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "$text",
                      style: TextStyle(
                          color: LightColors.iconColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
