import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:islamic_quizs_game/bloc/app_auth_bloc.dart';

import 'package:islamic_quizs_game/consts/views/colors.dart';
import 'package:islamic_quizs_game/models/game_dep_model.dart';
import 'package:islamic_quizs_game/screen/app/mainScreen/widget/load_deps_gridView.dart';
import 'package:islamic_quizs_game/screen/app/mainScreen/widget/load_deps_listView.dart';
import 'package:islamic_quizs_game/screen/app/mainScreen/widget/profil_data.dart';
import 'package:islamic_quizs_game/screen/app/mainScreen/widget/statistic.dart';
import 'package:islamic_quizs_game/util/ads_helper.dart';
import 'package:islamic_quizs_game/util/audio_play.dart';

import 'package:users_module/bloc/base_bloc/base_bloc.dart';
import 'package:users_module/bloc/base_bloc/base_state.dart';

import '../../../bloc/app_profile_sub_data_bloc.dart';
import '../../../models/user_model.dart';
import '../../../widgits/main_screens/projectScreen.dart';

class MainSrcreen extends StatefulWidget {
  const MainSrcreen({super.key});

  static const String path = '/main';

  @override
  State<MainSrcreen> createState() => _MainSrcreenState();
}

class _MainSrcreenState extends State<MainSrcreen> {
  AppAuthBloc authBloc = AppAuthBloc();
  AppProfileSubDataBloc appProfileSubDataBloc = AppProfileSubDataBloc();
  AppuserModel? user;
  // init untesetionl adunit '
  AdManagerInterstitialAd? _interstitialAd;
  int mony = 0;
  bool isiniting = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authBloc.getUserProfile();
    appProfileSubDataBloc.getSource();
  }

  @override
  Widget build(BuildContext context) {
    loadAd();
    return ProjectScreen(
      child: Container(
        color: LightColors.background1,
        child: BlocListener<UserModuleBaseBloc<AppuserModel>,
            UserModuleBaseState<AppuserModel>>(
          bloc: authBloc.userModuleBaseBloc,
          listener: (context, state) {
            // TODO: implement listener
            state.maybeWhen(
                orElse: () {},
                success: (v) {
                  setState(() {
                    user = v;
                    if (mony != user!.totalMoney ) {

                      if (!isiniting) {
                        int deff = user!.totalMoney! - mony;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "تم اضافة $deff نقطة الى رصيدك",
                            style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),

                          ),
                        ));
                      }else{
                        isiniting = false;
                      }
                      mony = user!.totalMoney ?? 0;
                    }
                  });
                });
          },
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: ProfilData(
                    user: user,
                    authBloc: authBloc,
                  )),
              SizedBox(
                height: 5.h,
              ),
              Expanded(
                  flex: 4,
                  child: Statistics(
                    level: user?.level ?? 1,
                    money: user?.totalMoney ?? 0,
                    scores: user?.score ?? 0,
                  )),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                  flex: 11,
                  child: BlocBuilder<UserModuleBaseBloc<List<GameDepModel>>,
                      UserModuleBaseState<List<GameDepModel>>>(
                    bloc: appProfileSubDataBloc.userModuleBaseBloc,
                    builder: (context, state) {
                      return state.maybeWhen(orElse: () {
                        return Container();
                      }, success: (v) {
                        return LoadDepsListView(
                          userGameDep: v ?? [],
                          mony: user!.totalMoney ?? 20,
                          interstitialAd: _interstitialAd,
                          authBloc: authBloc,
                        );
                      });
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void loadAd() {
    AdManagerInterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdManagerAdRequest(),
        adLoadCallback: AdManagerInterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('AdManagerInterstitialAd failed to load: $error');
          },
        ));
  }
}
