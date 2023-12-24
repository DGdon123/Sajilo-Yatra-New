import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/const/app_colors_const.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';
import 'package:sajilo_yatra/const/app_fonts.dart';
import 'package:sajilo_yatra/const/app_images_const.dart';
import 'package:sajilo_yatra/users_profile/presentation/views/profile_screen.dart';

import '../../../auth/presentation/login/views/main_login_screen.dart';
import '../../../const/app_const.dart';
import '../../../users_rentals/presentation/views/rental_screen.dart';
import '../../../users_tickets/presentation/views/ticket_screen.dart';
import '../../../utils/custom_navigation/app_nav.dart';
import '../../../vehicle_owners_ticket/presentation/views/vehicle_owner_ticket_screen.dart';

class VehicleOwnerDashboard extends ConsumerStatefulWidget {
  const VehicleOwnerDashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

String? currentAddress;

class _MyHelloState extends ConsumerState<VehicleOwnerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
            kToolbarHeight + 1), // Set the preferred height of the AppBar
        child: AppBar(
          backgroundColor: AppColorConst.kappWhiteColor,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.location_on_rounded),
                color: CupertinoColors.systemGrey,
                onPressed: () {
                  pushAndRemoveUntil(context, const LoginScreen());
                },
              );
            },
          ),
          title: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    currentAddress ?? "Loading address...",
                    style: TextStyle(
                      fontSize: AppDimensions.body_15,
                      letterSpacing: 0.06.dp,
                      fontFamily: AppFont.jProductsanfont,
                      fontWeight: AppDimensions.fontNormal,
                      color: CupertinoColors.darkBackgroundGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_sharp),
              color: CupertinoColors.darkBackgroundGray,
              iconSize: 4.w,
              onPressed: () {
                pushAndRemoveUntil(context, const LoginScreen());
              },
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.person_circle_fill),
              color: CupertinoColors.systemGrey4,
              iconSize: 9.w,
              onPressed: () {
                pushAndRemoveUntil(context, const Profile());
              },
            )
          ],
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 0.5.h),
              Row(
                children: [
                  const SizedBox(width: AppDimensions.paddingLARGE),
                  Text(
                    AppConst.kWorks,
                    style: TextStyle(
                        fontSize: AppDimensions.body_18,
                        letterSpacing: 0.06.dp,
                        fontFamily: AppFont.kProductsanfont,
                        fontWeight: AppDimensions.fontBold,
                        color: AppColorConst.kappprimaryColorRed),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.paddingDEFAULT),
              Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: AppDimensions.paddingLARGE),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: ContinuousRectangleBorder(
                                  side: const BorderSide(
                                    width: 0.8,
                                    color: Color(0xFFE8E9EB),
                                  ),
                                  borderRadius: BorderRadius.circular(50)),
                              backgroundColor: const Color(0xFFE8E9EB),
                              elevation: 0,
                              fixedSize: Size(89.3.w, 24.h),
                            ),
                            onPressed: () async {
                              normalNav(
                                  context, const VehicleOwnerTicketScreen());
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  AppImagesConst.appRide,
                                  height: 35.54.h,
                                  width: 73.w,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  top: 10,
                                  left: 0,
                                  child: Text(
                                    AppConst.kRide,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_20,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.lProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: AppDimensions.paddingLARGE),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: ContinuousRectangleBorder(
                                    side: const BorderSide(
                                      width: 0.8,
                                      color: Color(0xFFE8E9EB),
                                    ),
                                    borderRadius: BorderRadius.circular(50)),
                                backgroundColor: const Color(0xFFE8E9EB),
                                elevation: 0,
                                fixedSize: Size(89.3.w, 24.h)),
                            onPressed: () async {
                              normalNav(
                                  context, const VehicleOwnerTicketScreen());
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  AppImagesConst.appTicket,
                                  height: 35.54.h,
                                  width: 73.w,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  top: 10,
                                  left: 0,
                                  child: Text(
                                    AppConst.kTicket,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_20,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.lProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: AppDimensions.paddingLARGE),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: ContinuousRectangleBorder(
                                    side: const BorderSide(
                                      width: 0.8,
                                      color: Color(0xFFE8E9EB),
                                    ),
                                    borderRadius: BorderRadius.circular(50)),
                                backgroundColor: const Color(0xFFE8E9EB),
                                elevation: 0,
                                fixedSize: Size(89.3.w, 24.h)),
                            onPressed: () async {
                              normalNav(context, const RentalScreen());
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  AppImagesConst.appRental,
                                  height: 35.54.h,
                                  width: 73.w,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  top: 10,
                                  left: 0,
                                  child: Text(
                                    AppConst.krental,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_20,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.lProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: AppDimensions.paddingLARGE),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
