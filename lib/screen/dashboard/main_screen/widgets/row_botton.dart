import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_quizs_game/consts/views/colors.dart';
import 'package:islamic_quizs_game/provider/app_states.dart';
import 'package:provider/provider.dart';
class RowBottom extends StatelessWidget {
    RowBottom({super.key ,required  this.title , required this.itemIndex});
String title  ;
int itemIndex = 0;
  @override
  Widget build(BuildContext context) {
    int itemIndex =Provider.of<AppStateAndSettings>(context).itemIndex ;
    bool isSelect = itemIndex == this.itemIndex ;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: isSelect ? DasgbordColors.accentColors : Colors.transparent ,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 3,
              child: Text(title , style: TextStyle(color:  isSelect ? DasgbordColors.background1 : DasgbordColors.accentColors,
              fontSize: 5.sp
              ) ,),
            ) ,
            Expanded( flex:  2 , child: SizedBox( )) ,
            Expanded(child: Icon(Icons.arrow_forward_ios , color:  isSelect ? DasgbordColors.background1  : DasgbordColors.accentColors, size: 15, ))
          ],
        ),
      ),
    ) ;
  }
}
