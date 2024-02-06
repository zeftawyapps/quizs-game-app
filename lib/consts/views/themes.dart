import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 import 'colors.dart';

class Themes {
   static    ThemeData lightTheme = ThemeData(
     primaryColorLight: LightColors.primaryColors,
     floatingActionButtonTheme: FloatingActionButtonThemeData(
       backgroundColor: LightColors.primaryColors,),
      brightness: Brightness.light,
      backgroundColor: LightColors.backgroundColor,
      primaryColor: LightColors.primaryColors,
      appBarTheme: const AppBarTheme(
        backgroundColor: LightColors.appBar,
        titleTextStyle: TextStyle(
          color: LightColors.appBarText,
          fontSize: 15,
        ),
        iconTheme: IconThemeData(
          size: 25,
          color: Color(0xfff7eeee),
        ),
      ),
      drawerTheme:   DrawerThemeData(
        backgroundColor: LightColors.drawer,

      ),
      textTheme:   TextTheme(
        button: TextStyle(
          color: Colors.white,
          fontSize: 15.0.sp,
        ),
        subtitle1: TextStyle(
          color: LightColors.textFieldColor,
          fontSize: 5.sp,
        ),
        bodyText1: TextStyle(
          color: LightColors.titelTextColor,
          fontSize: 10.sp,
        ),

        bodyText2: TextStyle(
          color: Colors.black,
          fontSize: 10.sp,
          fontFamily: 'helvetice',
        ),
      ),

      iconTheme: IconThemeData(
        color: LightColors.iconColor,
        size: 5.sp,
      ),
      inputDecorationTheme:
      InputDecorationTheme(

          hintStyle: TextStyle(
              fontSize: 5.sp,
              color: Color(0xFF383839),
          ) ,
              labelStyle: TextStyle(
          color: LightColors.hintColor,
          fontSize: 10.sp,
        ),
        filled: true,
        fillColor: DasgbordColors.textFields,
        focusColor: DasgbordColors.textFieldsFoucs,
focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(20.sp),
         ),
         enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(20.sp),
         )
      )


         );
 static    ThemeData darkTheme =
  ThemeData(
      brightness: Brightness.light,
      primaryColorDark: DarkColors.primaryColors,
      backgroundColor: DarkColors.backgroundColor,
        primaryColor: DarkColors.primaryColors,
      appBarTheme:   AppBarTheme(
        backgroundColor: DarkColors.background1,
        titleTextStyle: TextStyle(
          color: DarkColors.appBarText,
          fontSize: 24.sp,
        ),
        iconTheme: IconThemeData(
          color: Color(0xfff7eeee),
        ),
      ),
      drawerTheme:   DrawerThemeData(
        backgroundColor: DarkColors.drawer,
      ),
      textTheme:   TextTheme(
        button: TextStyle(
          color: Colors.white,
          fontSize: 20.0.sp,
        ),
        subtitle1: TextStyle(
          color: DarkColors.textFieldColor,
          fontSize: 24.sp,
        ),
        bodyText1: TextStyle(
          color: DarkColors.textColor,
          fontSize: 25.sp,
        ),
        bodyText2: TextStyle(
          color: Colors.white ,
          fontSize: 24.sp,
        ),
      ),
      iconTheme: IconThemeData(
        color: DarkColors.iconColor,
        size: 35.sp,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: DarkColors.hintColor,
          fontSize: 15.sp,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DarkColors.dividerColor, width: 1),
        ),
      ));



}