

import 'package:flutter/cupertino.dart';
import 'package:islamic_quizs_game/consts/views/decoration.dart';

import 'colors.dart';


class Backgrounds{
  static  LinearGradient screenBackGround(){
   return LinearGradient(colors: [DasgbordColors.secondryColors , DasgbordColors.secondryColors ] ,
   begin: Alignment.bottomLeft ,
       end:Alignment.topRight
   );
 }
  static  LinearGradient splashScreenBackGround(){
    return LinearGradient(colors: [LightColors.background1 , LightColors.backgroundCenter  ] ,
        begin: Alignment.bottomLeft ,
        end:Alignment.topRight
    );
  }


  static  LinearGradient bottonBackGround(){
    return LinearGradient(colors: [DasgbordColors.bottonbegn ,DasgbordColors.bottonEnd   ] ,
        begin: Alignment.bottomLeft ,
        end:Alignment.topRight
    );


  }
  static  LinearGradient logInBackGround(){
    return LinearGradient(colors: [DasgbordColors.background1 ,DasgbordColors.background1   ] ,
        begin: Alignment.bottomLeft ,
        end:Alignment.topRight
    );


  }

}