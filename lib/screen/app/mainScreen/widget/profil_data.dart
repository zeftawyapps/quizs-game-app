import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_quizs_game/navigations/navigation_service.dart';
import 'package:islamic_quizs_game/screen/app/profile_screen/profile_screen.dart';

import '../../../../bloc/app_auth_bloc.dart';
import '../../../../bloc/app_profile_sub_data_bloc.dart';
import '../../../../consts/views/assets.dart';
import '../../../../consts/views/colors.dart';
class ProfilData extends StatelessWidget {
    ProfilData({super.key , required this.user , required   this.authBloc});
  var user;
    AppAuthBloc authBloc ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10),
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Row(
          children: [
            Container(
                width: 75.w,
                height: 75.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                  backgroundImage: AssetImage(AppAsset.profile),
                )),
            Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? "name",
                        style: TextStyle(
                            color: LightColors.titelTextColor,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(user?.email ?? "email",
                          style: TextStyle(
                              color: LightColors.titelTextColorSmall,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: MaterialButton(
                  onPressed: () {
                    NavigationService().navigateToPage(path: ProfileScreen.path ,
                    data: user).then((value) => {
                      authBloc.getUserProfile()
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: LightColors.backgroundButtom,
                        borderRadius: BorderRadius.circular(20),
                     shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                            color: LightColors.backgroundButtomShadow,
                            blurRadius:0.5,
                            spreadRadius: 0,
                            offset: Offset(
                                4, 4), // shadow direction: bottom right
                          )
                        ],

                      ), // icont setting
                      child: Center(
                          child: Icon(
                            Icons.settings,
                            color: LightColors.iconColor,
                            size: 50,
                          )),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
