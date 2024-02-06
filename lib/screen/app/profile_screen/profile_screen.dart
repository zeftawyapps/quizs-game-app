import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:islamic_quizs_game/models/store_model.dart';
import 'package:islamic_quizs_game/models/user_model.dart';
import 'package:islamic_quizs_game/navigations/navigation_service.dart';
import 'package:islamic_quizs_game/util/ads_helper.dart';
import 'package:islamic_quizs_game/util/payment/payment.dart';
import 'package:islamic_quizs_game/widgits/main_screens/projectScreen.dart';
import 'package:pay/pay.dart';
import 'package:users_module/bloc/base_bloc/base_bloc.dart';
import 'package:users_module/bloc/base_bloc/base_state.dart';

import '../../../bloc/app_auth_bloc.dart';
import '../../../consts/views/assets.dart';
import '../../../consts/views/colors.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});
  static String path = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AppuserModel user;
  List<StoreModel> list = [];
  RewardedAd? rewardedAd;
  AppAuthBloc? authBloc;
  PaymentConfiguration? payment;
  bool ispay = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authBloc = AppAuthBloc();

    loadPyment();
  }

  void loadPyment() async {
    payment = await getpayment();
  }

  @override
  Widget build(BuildContext context) {
   if (ispay) {
      ispay = false;

    }else {
    user = ModalRoute.of(context)!.settings.arguments as AppuserModel;
   }
    loadMony();
    loadRewardedAds();

    return ProjectScreen(
        child: Container(
      color: LightColors.background1,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
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
                  Container(
                    height: 50.h,
                    width: 50.w,
                    child:  IconButton(
                      onPressed: () {

                      },
                      icon: Icon(
                        Icons.logout,
                        color: LightColors.titelTextColor,
                      ),
                    )
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),

            Container(
              height: 70.h,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("المتجر",
                    style: TextStyle(
                        color: LightColors.titelTextColorSmall,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold)),
              ),
            ),

            Container(
              height: 70.h,
              child: Text("لديك ${user?.totalMoney ?? 0} نقدا",
                  style: TextStyle(
                      color: LightColors.titelTextColorSmall,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold)),
            ),
            // add list view with list of store
            Expanded(
              flex: 5,
              child: BlocListener<UserModuleBaseBloc<AppuserModel>,
                  UserModuleBaseState<AppuserModel>>(
                bloc: authBloc!.userModuleBaseBloc,
                listener: (context, state) {
                  // TODO: implement listener
                  state.maybeWhen(
                      orElse: () {},
                      success: (v) {
                        setState(() {
                          user = v!;

                          // alarm of success
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("تم اضافة النقود") ) );

                        });
                      });
                },
                child: ListView.builder(
                  itemBuilder: (c, i) {
                    bool isAdShow = false;
                    isAdShow = list[i].price == 0 ? true : false;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                          color: LightColors.backgroundButtom,
                          child: Column(
                            children: [
                              Text("${list[i].mony} نقدا",
                                  style: TextStyle(
                                      color: LightColors.backgroundCenter,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold)),
                              Text("${list[i].price} دولار",
                                  style: TextStyle(
                                      color: LightColors.backgroundCenter,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold)),
                              !isAdShow
                                  ? setGooglePay((result) {
                                    if (ispay) {
                                      return;
                                    }

                                      print(result);
                                       ispay = true;
                                        chagneMony(list[i].mony);

                                    },
                                      PaymentItem(
                                        label: 'شراء',
                                        amount: '${list[i].price}',
                                        status: PaymentItemStatus.final_price,
                                      ))
                                  : MaterialButton(
                                      onPressed: () {
                                        if (list[i].price == 0) {
                                          if (rewardedAd != null) {
                                            rewardShow();
                                          }
                                        } else {}
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: LightColors.backgroundCenter,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Center(
                                          child: Text("مشاهدة الاعلان",
                                              style: TextStyle(
                                                  color: LightColors
                                                      .textFieldsFoucs,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      )),
                            ],
                          )),
                    );
                  },
                  itemCount: list.length,
                ),
              ),
            )
          ]),
        ),
      ),
    ));
  }

  Future loadRewardedAds() async {
    await RewardedAd.load(
        adUnitId: AdHelper.rewardedAdUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            this.rewardedAd = ad;


          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            // add snack bar
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("لا يوجد اعلانات حاليا") ) );
          },

        ));
    initRewardedAdsLesteners();
  }

  void rewardShow() {
    rewardedAd?.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
          chagneMony(5);
      // Reward the user for watching an ad.
      print("onUserEarnedReward");
      setState(() {
        ispay = true;
      });
     });
  }

  void initRewardedAdsLesteners() {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) async {
          chagneMony(5);
          await loadRewardedAds();

        },
        onAdDismissedFullScreenContent: (RewardedAd ad) async {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
          await loadRewardedAds();
        },
        onAdFailedToShowFullScreenContent:
            (RewardedAd ad, AdError error) async {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
          await loadRewardedAds();
        },
        onAdImpression: (RewardedAd ad) async {

          await loadRewardedAds();
        },
      );
    }
  }

  void chagneMony(int mony) {
    int totalMony = user.totalMoney ?? 0;
    totalMony += mony;
    authBloc!.setUserProfile(totalMony);
  }

  void loadMony() {
    list = [
      StoreModel(id: 1, mony: 5, price: 0),
      StoreModel(id: 2, mony: 25, price: 0.25),
      StoreModel(id: 3, mony: 50, price: 0.50),
      StoreModel(id: 4, mony: 100, price: 1),
    ];
  }
}
