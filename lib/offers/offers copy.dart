// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/commons/custom_primary_button.dart';
import 'package:sajilo_yatra/const/app_colors_const.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';
import 'package:sajilo_yatra/const/app_fonts.dart';
import 'package:sajilo_yatra/const/app_images_const.dart';
import 'dart:convert';

import 'package:sajilo_yatra/helpers/ui_helper.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%202.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%203.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%204.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%205.dart';
import 'package:sajilo_yatra/offers/offerone%20copy.dart';
import 'package:sajilo_yatra/offers/offerone.dart';
import 'package:sajilo_yatra/utils/custom_list/custom_listing.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';

class Offers1 extends StatefulWidget {
  const Offers1({Key? key}) : super(key: key);

  @override
  State<Offers1> createState() => _OfferOneState();
}

class _OfferOneState extends State<Offers1> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Offers',
          style: TextStyle(
              fontSize: AppDimensions.body_16,
              letterSpacing: 0.06.dp,
              fontFamily: AppFont.kProductsanfont,
              fontWeight: AppDimensions.fontMedium,
              color: AppColorConst.kappWhiteColor),
        ),
        backgroundColor: AppColorConst.kappprimaryColorRed,
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(1.0), // Set the height of the underline
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColorConst
                      .kappprimaryColorRed, // Set the color of the underline
                  width: 3, // Set the width of the underline
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: AppDimensions.paddingDEFAULT,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    normalNav(context, const OfferOne());
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: AppDimensions.paddingDEFAULT,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: const Offset(0, 0),
                              blurRadius: 7.0,
                              spreadRadius:
                                  2.0, // Adjust the spreadRadius value as desired
                            ),
                            //BoxShadow
                            //BoxShadow
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3.8)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                                height: AppDimensions.paddingDEFAULT),
                            Image.asset(
                              AppImagesConst.appOne,
                              width: 30.w,
                              height: 13.h,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(height: AppDimensions.paddingSMALL),
                            Text(
                              "SAVE Rs: 100",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: AppDimensions.body_16,
                                  letterSpacing: 0.06.dp,
                                  fontFamily: AppFont.qProductsanfont,
                                  fontWeight: AppDimensions.fontBold,
                                  color: AppColorConst.kappsecondaryColorBlack),
                            ),
                            Text(
                              "on First Ticket/Ride",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: AppDimensions.body_13,
                                  letterSpacing: 0.06.dp,
                                  fontFamily: AppFont.qProductsanfont,
                                  fontWeight: AppDimensions.fontNormal,
                                  color: AppColorConst.kappscafoldbggrey),
                            ),
                            const SizedBox(height: AppDimensions.paddingSMALL),
                            Container(
                              height: 4.h,
                              width: 39.w,
                              decoration: const BoxDecoration(
                                color: AppColorConst.kappprimaryColorRed,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "CODE : ",
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_13,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.xProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                  Text(
                                    "YGFJY899",
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_13,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.xProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: AppDimensions.paddingSMALL,
                ),
                InkWell(
                  onTap: () {
                    normalNav(context, const OfferThree());
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: const Offset(0, 0),
                              blurRadius: 7.0,
                              spreadRadius:
                                  2.0, // Adjust the spreadRadius value as desired
                            ),
                            //BoxShadow
                            //BoxShadow
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3.8)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                                height: AppDimensions.paddingDEFAULT),
                            Image.asset(
                              AppImagesConst.appTwo,
                              width: 30.w,
                              height: 13.h,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(height: AppDimensions.paddingSMALL),
                            Text(
                              "SAVE Rs: 900",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: AppDimensions.body_16,
                                  letterSpacing: 0.06.dp,
                                  fontFamily: AppFont.qProductsanfont,
                                  fontWeight: AppDimensions.fontBold,
                                  color: AppColorConst.kappsecondaryColorBlack),
                            ),
                            Text(
                              "on Referral",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: AppDimensions.body_13,
                                  letterSpacing: 0.06.dp,
                                  fontFamily: AppFont.qProductsanfont,
                                  fontWeight: AppDimensions.fontNormal,
                                  color: AppColorConst.kappscafoldbggrey),
                            ),
                            const SizedBox(height: AppDimensions.paddingSMALL),
                            Container(
                              height: 4.h,
                              width: 39.w,
                              decoration: const BoxDecoration(
                                color: AppColorConst.kappprimaryColorRed,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "CODE : ",
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_13,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.xProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                  Text(
                                    "HRDTY56",
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_13,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.xProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppDimensions.paddingDEFAULT,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    normalNav(context, const OfferFour());
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: AppDimensions.paddingDEFAULT,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: const Offset(0, 0),
                              blurRadius: 7.0,
                              spreadRadius:
                                  2.0, // Adjust the spreadRadius value as desired
                            ),
                            //BoxShadow
                            //BoxShadow
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3.8)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                                height: AppDimensions.paddingDEFAULT),
                            Image.asset(
                              AppImagesConst.appThree,
                              width: 30.w,
                              height: 13.h,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(height: AppDimensions.paddingSMALL),
                            Text(
                              "SAVE Rs: 2000",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: AppDimensions.body_16,
                                  letterSpacing: 0.06.dp,
                                  fontFamily: AppFont.qProductsanfont,
                                  fontWeight: AppDimensions.fontBold,
                                  color: AppColorConst.kappsecondaryColorBlack),
                            ),
                            Text(
                              "on 45 Min Ride",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: AppDimensions.body_13,
                                  letterSpacing: 0.06.dp,
                                  fontFamily: AppFont.qProductsanfont,
                                  fontWeight: AppDimensions.fontNormal,
                                  color: AppColorConst.kappscafoldbggrey),
                            ),
                            const SizedBox(height: AppDimensions.paddingSMALL),
                            Container(
                              height: 4.h,
                              width: 39.w,
                              decoration: const BoxDecoration(
                                color: AppColorConst.kappprimaryColorRed,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "CODE : ",
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_13,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.xProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                  Text(
                                    "AKI745",
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_13,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.xProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: AppDimensions.paddingSMALL,
                ),
                InkWell(
                  onTap: () {
                    normalNav(context, const OfferFive());
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: const Offset(0, 0),
                              blurRadius: 7.0,
                              spreadRadius:
                                  2.0, // Adjust the spreadRadius value as desired
                            ),
                            //BoxShadow
                            //BoxShadow
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3.8)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                                height: AppDimensions.paddingDEFAULT),
                            Image.asset(
                              AppImagesConst.appFour,
                              width: 30.w,
                              height: 13.h,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(height: AppDimensions.paddingSMALL),
                            Text(
                              "SAVE Rs: 1000",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: AppDimensions.body_16,
                                  letterSpacing: 0.06.dp,
                                  fontFamily: AppFont.qProductsanfont,
                                  fontWeight: AppDimensions.fontBold,
                                  color: AppColorConst.kappsecondaryColorBlack),
                            ),
                            Text(
                              "on 1 hour 30 Min Ride",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: AppDimensions.body_13,
                                  letterSpacing: 0.06.dp,
                                  fontFamily: AppFont.qProductsanfont,
                                  fontWeight: AppDimensions.fontNormal,
                                  color: AppColorConst.kappscafoldbggrey),
                            ),
                            const SizedBox(height: AppDimensions.paddingSMALL),
                            Container(
                              height: 4.h,
                              width: 39.w,
                              decoration: const BoxDecoration(
                                color: AppColorConst.kappprimaryColorRed,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "CODE : ",
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_13,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.xProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                  Text(
                                    "HGHG7",
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_13,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.xProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppDimensions.paddingDEFAULT,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    normalNav(context, const OfferSix());
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: AppDimensions.paddingDEFAULT,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: const Offset(0, 0),
                              blurRadius: 7.0,
                              spreadRadius:
                                  2.0, // Adjust the spreadRadius value as desired
                            ),
                            //BoxShadow
                            //BoxShadow
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3.8)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                                height: AppDimensions.paddingDEFAULT),
                            Image.asset(
                              AppImagesConst.appFive,
                              width: 30.w,
                              height: 13.h,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(height: AppDimensions.paddingSMALL),
                            Text(
                              "SAVE Rs: 70",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: AppDimensions.body_16,
                                  letterSpacing: 0.06.dp,
                                  fontFamily: AppFont.qProductsanfont,
                                  fontWeight: AppDimensions.fontBold,
                                  color: AppColorConst.kappsecondaryColorBlack),
                            ),
                            Text(
                              "on Every Ticket/Ride",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: AppDimensions.body_13,
                                  letterSpacing: 0.06.dp,
                                  fontFamily: AppFont.qProductsanfont,
                                  fontWeight: AppDimensions.fontNormal,
                                  color: AppColorConst.kappscafoldbggrey),
                            ),
                            const SizedBox(height: AppDimensions.paddingSMALL),
                            Container(
                              height: 4.h,
                              width: 39.w,
                              decoration: const BoxDecoration(
                                color: AppColorConst.kappprimaryColorRed,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "CODE : ",
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_13,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.xProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                  Text(
                                    "JHVJ34",
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_13,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.xProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: AppDimensions.paddingSMALL,
                ),
                InkWell(
                  onTap: () {
                    normalNav(context, const OfferTwo());
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: const Offset(0, 0),
                              blurRadius: 7.0,
                              spreadRadius:
                                  2.0, // Adjust the spreadRadius value as desired
                            ),
                            //BoxShadow
                            //BoxShadow
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3.8)),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                                height: AppDimensions.paddingDEFAULT),
                            Image.asset(
                              AppImagesConst.appSix,
                              width: 30.w,
                              height: 13.h,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(height: AppDimensions.paddingSMALL),
                            Text(
                              "SAVE Rs: 200",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: AppDimensions.body_16,
                                  letterSpacing: 0.06.dp,
                                  fontFamily: AppFont.qProductsanfont,
                                  fontWeight: AppDimensions.fontBold,
                                  color: AppColorConst.kappsecondaryColorBlack),
                            ),
                            Text(
                              "on KTM Tickets",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: AppDimensions.body_13,
                                  letterSpacing: 0.06.dp,
                                  fontFamily: AppFont.qProductsanfont,
                                  fontWeight: AppDimensions.fontNormal,
                                  color: AppColorConst.kappscafoldbggrey),
                            ),
                            const SizedBox(height: AppDimensions.paddingSMALL),
                            Container(
                              height: 4.h,
                              width: 39.w,
                              decoration: const BoxDecoration(
                                color: AppColorConst.kappprimaryColorRed,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "CODE : ",
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_13,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.xProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                  Text(
                                    "UIGF78",
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_13,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.xProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst.kappWhiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppDimensions.paddingDEFAULT,
            ),
          ],
        ),
      ),
    );
  }
}
