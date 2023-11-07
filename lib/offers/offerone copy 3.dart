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
import 'package:sajilo_yatra/utils/custom_list/custom_listing.dart';

class OfferFour extends StatefulWidget {
  const OfferFour({Key? key}) : super(key: key);

  @override
  State<OfferFour> createState() => _OfferFourState();
}

class _OfferFourState extends State<OfferFour> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String? grade;
  String? product;
  var num = 1;
  String? thickness;
  String? price;
  var gradeName;
  var productName;
  var thicknessName;
  var priceName;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Offer Three',
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
                Navigator.pop(context);
              },
            );
          },
        ),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: UiHelper.displayHeight(context) * 0.195,
                      width: UiHelper.displayWidth(context) * 0.96,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0.5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(0, 8),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                          //BoxShadow
                        ],
                      ),
                      margin: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 25, left: 23),
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              AppImagesConst.appThree,
                              height: UiHelper.displayHeight(context) * 0.12,
                              width: UiHelper.displayWidth(context) * 0.29,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 27, top: 17),
                            child: Column(
                              children: [
                                Text(
                                  "SAVE Rs: 2000",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: AppDimensions.body_27,
                                      letterSpacing: 0.06.dp,
                                      fontFamily: AppFont.qProductsanfont,
                                      fontWeight: AppDimensions.fontBold,
                                      color: AppColorConst
                                          .kappsecondaryColorBlack),
                                ),
                                UiHelper.verticalSpace(vspace: Spacing.xxsmall),
                                Text(
                                  "on 45 Min Ride",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: AppDimensions.body_16,
                                      letterSpacing: 0.06.dp,
                                      fontFamily: AppFont.qProductsanfont,
                                      fontWeight: AppDimensions.fontNormal,
                                      color: AppColorConst.kappscafoldbggrey),
                                ),
                                Container(
                                  height:
                                      UiHelper.displayHeight(context) * 0.05,
                                  width: UiHelper.displayWidth(context) * 0.4,
                                  decoration: const BoxDecoration(
                                    color: AppColorConst.kappprimaryColorRed,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                  ),
                                  margin: const EdgeInsets.only(top: 8.5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "CODE : ",
                                        style: TextStyle(
                                            fontSize: AppDimensions.body_14,
                                            letterSpacing: 0.06.dp,
                                            fontFamily: AppFont.xProductsanfont,
                                            fontWeight: AppDimensions.fontBold,
                                            color:
                                                AppColorConst.kappWhiteColor),
                                      ),
                                      Text(
                                        "AKI745",
                                        style: TextStyle(
                                            fontSize: AppDimensions.body_14,
                                            letterSpacing: 0.06.dp,
                                            fontFamily: AppFont.xProductsanfont,
                                            fontWeight: AppDimensions.fontBold,
                                            color:
                                                AppColorConst.kappWhiteColor),
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
                    Container(
                      height: UiHelper.displayHeight(context) * 0.06,
                      width: UiHelper.displayWidth(context) * 0.96,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7F7),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0.5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(0, 8),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                          //BoxShadow
                        ],
                      ),
                      child: const Text(
                        "Save Rs: 2000 on 45 Min Ride",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff2222222),
                          fontSize: AppDimensions.body_18,
                          fontFamily: AppFont.lProductsanfont,
                          fontWeight: AppDimensions.fontNormal,
                        ),
                      ),
                    ),
                    Container(
                        height: UiHelper.displayHeight(context) * 0.470,
                        width: UiHelper.displayWidth(context) * 0.96,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0.5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: const Offset(0, 8),
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                            //BoxShadow,
                          ],
                        ),
                        child: Expanded(
                            child: ListView(
                          children: [
                            Container(height: 1.5.h),
                            Container(
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomListing(
                                    text:
                                        'Apply Coupon code AKI745 on 45 Min Ride and \nsave Rs.900 on AKI745 vehicle services',
                                  ),
                                  SizedBox(
                                    height: AppDimensions.paddingSMALL,
                                  ),
                                  CustomListing(
                                    text:
                                        'New users will get 10% up to Rs.150 discount \n+ 100% up to Rs.70 Promo Sajilo Yatra Cashback',
                                  ),
                                  SizedBox(
                                    height: AppDimensions.paddingSMALL,
                                  ),
                                  CustomListing(
                                    text:
                                        'Existing customers get 100% up to Rs.100 Promo \nSajilo Yatra Cashback',
                                  ),
                                  SizedBox(
                                    height: AppDimensions.paddingSMALL,
                                  ),
                                  CustomListing(
                                    text:
                                        'This is a special offer valid for vehicle bookings \nmade on Sajilo Yatra for AKI745 vehicle \nbookings only',
                                  ),
                                  SizedBox(
                                    height: AppDimensions.paddingSMALL,
                                  ),
                                  CustomListing(
                                    text:
                                        'No minimum transaction value applicable',
                                  ),
                                  SizedBox(
                                    height: AppDimensions.paddingSMALL,
                                  ),
                                  CustomListing(
                                    text:
                                        'This offer is valid only once per user, only on \nAKI745 Vehicle Bookings',
                                  ),
                                  SizedBox(
                                    height: AppDimensions.paddingSMALL,
                                  ),
                                  CustomListing(
                                    text:
                                        'This offer cannot be combined with any other \noffer',
                                  ),
                                  SizedBox(
                                    height: AppDimensions.paddingSMALL,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))),
                    const SizedBox(
                      height: AppDimensions.paddingLARGE,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomPrimaryButton(
                          text: "Copy Code",
                          onPressed: () {
                            String code =
                                "AKI745"; // replace with the actual code string
                            Clipboard.setData(ClipboardData(text: code));
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Code copied to clipboard',
                              confirmBtnColor:
                                  AppColorConst.kappprimaryColorRed,
                            );
                          },
                          gradient: AppColorConst.kappprimaryColorRed,
                        ),
                        const SizedBox(
                          width: AppDimensions.paddingDEFAULT,
                        ),
                        CustomPrimaryButton(
                          text: "Book Now",
                          onPressed: () {},
                          gradient: AppColorConst.kappprimaryColorRed,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
