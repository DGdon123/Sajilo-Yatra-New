import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/auth/presentation/login/views/vehicle_owner_login/vehicle_owner_login_screen.dart';

import 'package:sajilo_yatra/const/app_dimension.dart';
import 'package:sajilo_yatra/const/app_images_const.dart';

import 'package:sajilo_yatra/utils/keyboard_dismiss/keyboard_dismiss_extension.dart';

import '../../../../const/app_colors_const.dart';
import '../../../../const/app_const.dart';
import '../../../../const/app_fonts.dart';
import 'users_login/user_login_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        labelPadding: const EdgeInsets.only(top: 2),
        labelStyle: TextStyle(
            fontFamily: AppFont.kProductsanfont,
            fontSize: AppDimensions.body_13,
            letterSpacing: 0.04.dp,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.extraLightBackgroundGray),
        labelColor: AppColorConst.kappWhiteColor,
        unselectedLabelColor: CupertinoColors.systemGrey4,
        isScrollable: true,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        tabs: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Tab(text: 'User'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Tab(text: 'Vehicle Owner'),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColorConst.kappscafoldbggrey));
    // final isuser = ref.watch(isUserProvider);

    return DefaultTabController(
      length: 2,
      child: GestureDetector(
        onTap: context.dismissKeyboard,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 8.1.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: AppDimensions.paddingDEFAULT),
                    Text(
                      AppConst.kLoginAccount,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: AppDimensions.body_22,
                          letterSpacing: 0.06.dp,
                          fontFamily: AppFont.kProductsanfont,
                          fontWeight: AppDimensions.fontMedium,
                          color: CupertinoColors.black),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            AppImagesConst.appHead,
                            height: 6.54.h,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(
                              width: AppDimensions.paddingEXTRASMALL),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const SizedBox(width: AppDimensions.paddingDEFAULT),
                    Text(
                      "Hello, welcome back to your account",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: AppDimensions.body_14,
                          letterSpacing: 0.06.dp,
                          fontFamily: AppFont.kProductsanfont,
                          fontWeight: AppDimensions.fontNormal,
                          color: CupertinoColors.systemGrey),
                    ),
                  ],
                ),
                SizedBox(height: 5.3.h),
                Center(
                  child: PreferredSize(
                    preferredSize: _tabBar.preferredSize,
                    child: Container(
                      child: Material(
                        borderRadius: BorderRadius.circular(3.0),
                        color: AppColorConst.kappprimaryColorRed,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: _tabBar,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        const Home(),
                        VHome(),
                      ],
                    ),
                  ),
                )

                // const AspectRatio(aspectRatio: 2, child: Placeholder()),

                // HeaderText(
                //   title: AppConst.kLogin,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     UsertypeCard(
                //       onTap: toogleUserProfessional,
                //       lable: "Admin",
                //       isMember: isuser,
                //     ),
                //     UsertypeCard(
                //       onTap: toogleUserProfessional,
                //       lable: "Palika",
                //       isMember: !isuser,
                //     ),
                //     UsertypeCard(
                //       onTap: toogleUserProfessional,
                //       lable: "Teacher",
                //       isMember: !isuser,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
