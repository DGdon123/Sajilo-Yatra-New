import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/const/app_colors_const.dart';
import 'package:sajilo_yatra/const/app_const.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';
import 'package:sajilo_yatra/const/app_fonts.dart';
import 'package:sajilo_yatra/const/app_images_const.dart';
import 'package:sajilo_yatra/profile/data/models/profile_params_model.dart';
import 'package:sajilo_yatra/profile/presentation/controllers/profile_controller.dart';
import 'package:sajilo_yatra/utils/bottom_bar/bottom_bar.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loader_skeleton/loader_skeleton.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<Profile> {
  String token = "";
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('tokens')!;
  }

  @override
  Widget build(BuildContext context) {
    final assingedClass =
        ref.watch(profileControllerProvider(ProfileParams(token: token)));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppConst.kProfile,
          style: TextStyle(
              fontSize: AppDimensions.body_16,
              letterSpacing: 0.06.dp,
              fontFamily: AppFont.kProductsanfont,
              fontWeight: AppDimensions.fontMedium,
              color: AppColorConst.kappWhiteColor),
        ),
        backgroundColor: AppColorConst.kappprimaryColorRed,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: AppColorConst.kappWhiteColor,
              onPressed: () {
                pushAndRemoveUntil(context, const BottomBar());
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: 20.h,
              color: AppColorConst.kappprimaryColorRed,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(0, 8),
                            blurRadius: 7.0,
                            spreadRadius:
                                2.0, // Adjust the spreadRadius value as desired
                          ),
                          //BoxShadow
                          //BoxShadow
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 20.0, top: 20),
                                child: Icon(
                                  Icons.edit_square,
                                  color: AppColorConst.kappprimaryColorRed,
                                ),
                              )
                            ],
                          ),
                          assingedClass.when(
                              data: (data) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: CupertinoColors
                                              .systemGrey5, // Set the border color here
                                          width:
                                              4.8, // Set the border width here
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        maxRadius: 38,
                                        child: Image.asset(
                                          AppImagesConst.appCar,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: AppDimensions.paddingDEFAULT,
                                    ),
                                    Text(
                                      data.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: AppDimensions.body_22,
                                          letterSpacing: 0.8,
                                          fontFamily: AppFont.kProductsanfont,
                                          fontWeight: AppDimensions.fontBold,
                                          color: AppColorConst
                                              .kappsecondaryColorBlack),
                                    ),
                                    Text(
                                      data.email,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: AppDimensions.body_15,
                                          letterSpacing: 0.85,
                                          fontFamily: AppFont.qProductsanfont,
                                          fontWeight: AppDimensions.fontNormal,
                                          color: CupertinoColors.systemGrey),
                                    ),
                                  ],
                                );
                              },
                              error: (er, s) => Text(er.toString()),
                              loading: () => Center(
                                      child: CardPageSkeleton(
                                    totalLines: 2,
                                  ))),
                          SizedBox(
                            height: 4.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
          SizedBox(
            height: 2.5.h,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColorConst.kappprimaryColorRed,
                  child: Icon(
                    Icons.widgets_outlined,
                    color: AppColorConst.kappWhiteColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.0),
                  child: Text(
                    AppConst.kappBarDashboard,
                    style: TextStyle(
                        fontFamily: AppFont.lProductsanfont,
                        letterSpacing: 0.4,
                        fontWeight: AppDimensions.fontMedium,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: AppDimensions.body_20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: AppDimensions.paddingEXTRALARGE,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColorConst.kappprimaryColorRed,
                  child: Icon(
                    Icons.history_outlined,
                    color: AppColorConst.kappWhiteColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.0),
                  child: Text(
                    AppConst.kHistory,
                    style: TextStyle(
                        fontFamily: AppFont.lProductsanfont,
                        letterSpacing: 0.4,
                        fontWeight: AppDimensions.fontMedium,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: AppDimensions.body_20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: AppDimensions.paddingEXTRALARGE,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColorConst.kappprimaryColorRed,
                  child: Icon(
                    Icons.percent_outlined,
                    color: AppColorConst.kappWhiteColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Text(
                    AppConst.kOffers,
                    style: const TextStyle(
                        fontFamily: AppFont.lProductsanfont,
                        letterSpacing: 0.4,
                        fontWeight: AppDimensions.fontMedium,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: AppDimensions.body_20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: AppDimensions.paddingEXTRALARGE,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColorConst.kappprimaryColorRed,
                  child: Icon(
                    Icons.help_outline,
                    color: AppColorConst.kappWhiteColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.0),
                  child: Text(
                    AppConst.kHelp,
                    style: TextStyle(
                        fontFamily: AppFont.lProductsanfont,
                        letterSpacing: 0.4,
                        fontWeight: AppDimensions.fontMedium,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: AppDimensions.body_20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: AppDimensions.paddingEXTRALARGE,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColorConst.kappprimaryColorRed,
                  child: Icon(
                    Icons.logout_outlined,
                    color: AppColorConst.kappWhiteColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Text(
                    AppConst.kLogout,
                    style: const TextStyle(
                        fontFamily: AppFont.lProductsanfont,
                        letterSpacing: 0.4,
                        fontWeight: AppDimensions.fontMedium,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: AppDimensions.body_20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
