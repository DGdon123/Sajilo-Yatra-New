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
import 'package:advance_expansion_tile/advance_expansion_tile.dart';
import 'package:sajilo_yatra/helpers/ui_helper.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%202.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%203.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%204.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%205.dart';
import 'package:sajilo_yatra/offers/offerone%20copy.dart';
import 'package:sajilo_yatra/offers/offerone.dart';
import 'package:sajilo_yatra/utils/custom_list/custom_listing.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _OfferOneState();
}

class _OfferOneState extends State<Help> {
  final GlobalKey<AdvanceExpansionTileState> _globalKey = GlobalKey();
  final GlobalKey<AdvanceExpansionTileState> _globalKey1 = GlobalKey();

  final GlobalKey<AdvanceExpansionTileState> _globalKey3 = GlobalKey();
  final GlobalKey<AdvanceExpansionTileState> _globalKey4 = GlobalKey();
  final GlobalKey<AdvanceExpansionTileState> _globalKey5 = GlobalKey();
  final GlobalKey<AdvanceExpansionTileState> _globalKey6 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'FAQs',
          style: TextStyle(
              fontSize: AppDimensions.body_16,
              letterSpacing: 1.5,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: AppDimensions.paddingDEFAULT,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AdvanceExpansionTile(
                iconColor: AppColorConst.kappsecondaryColorBlack,
                textColor: AppColorConst.kappsecondaryColorBlack,
                collapsedTextColor: AppColorConst.kappsecondaryColorBlack,
                collapsedIconColor: AppColorConst.kappsecondaryColorBlack,
                key: _globalKey,
                title: const Text(
                  "Is your payment platform secure?",
                  style: TextStyle(letterSpacing: 0.6),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColorConst.kappscafoldbggrey),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: Container(
                      width: double.infinity,
                      color: AppColorConst.kappprimaryColorRed,
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Yes, it is the most safest payment platform ever done. Users would perform cash transactions hand to hand with the vehicle owner.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              letterSpacing: 0.6,
                              color: AppColorConst.kappWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AdvanceExpansionTile(
                iconColor: AppColorConst.kappsecondaryColorBlack,
                textColor: AppColorConst.kappsecondaryColorBlack,
                collapsedTextColor: AppColorConst.kappsecondaryColorBlack,
                collapsedIconColor: AppColorConst.kappsecondaryColorBlack,
                key: _globalKey1,
                title: const Text(
                  "How do I change my account email and password?",
                  style: TextStyle(letterSpacing: 0.6),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColorConst.kappscafoldbggrey),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: Container(
                      width: double.infinity,
                      color: AppColorConst.kappprimaryColorRed,
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "You can change your password by clicking forgot password and resetting your password but, you are not reset your email. If you want to use another \nemail, you have to register it in the application.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              letterSpacing: 0.6,
                              color: AppColorConst.kappWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AdvanceExpansionTile(
                iconColor: AppColorConst.kappsecondaryColorBlack,
                textColor: AppColorConst.kappsecondaryColorBlack,
                collapsedTextColor: AppColorConst.kappsecondaryColorBlack,
                collapsedIconColor: AppColorConst.kappsecondaryColorBlack,
                key: _globalKey3,
                title: const Text(
                  "How to leave a review for a driver",
                  style: TextStyle(letterSpacing: 0.6),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColorConst.kappscafoldbggrey),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: Container(
                      width: double.infinity,
                      color: AppColorConst.kappprimaryColorRed,
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Once the app immediately after the ride is completed. You will see a window where you can evaluate the driver and write a review. If you did not enjoy your ride and you decide to write a negative review, don’t worry - the driver will not see that it was you.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              letterSpacing: 0.6,
                              color: AppColorConst.kappWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AdvanceExpansionTile(
                iconColor: AppColorConst.kappsecondaryColorBlack,
                textColor: AppColorConst.kappsecondaryColorBlack,
                collapsedTextColor: AppColorConst.kappsecondaryColorBlack,
                collapsedIconColor: AppColorConst.kappsecondaryColorBlack,
                key: _globalKey4,
                title: const Text(
                  "How to find belongings I left behind",
                  style: TextStyle(letterSpacing: 0.6),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColorConst.kappscafoldbggrey),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: Container(
                      width: double.infinity,
                      color: AppColorConst.kappprimaryColorRed,
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "If you have left your belongings in the vehicle, write to us at dipeshgurung797@gmail.com. Include the time and route of your ride, and if possible tell us the car’s make, color, and registration number. We’ll help find your belongings.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              letterSpacing: 0.6,
                              color: AppColorConst.kappWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AdvanceExpansionTile(
                iconColor: AppColorConst.kappsecondaryColorBlack,
                textColor: AppColorConst.kappsecondaryColorBlack,
                collapsedTextColor: AppColorConst.kappsecondaryColorBlack,
                collapsedIconColor: AppColorConst.kappsecondaryColorBlack,
                key: _globalKey5,
                title: const Text(
                  "Are there smoking breaks or stop-offs?",
                  style: TextStyle(letterSpacing: 0.6),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColorConst.kappscafoldbggrey),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: Container(
                      width: double.infinity,
                      color: AppColorConst.kappprimaryColorRed,
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Some of our trips have breaks planned into the schedule for the purposes of providing driving breaks and rest periods for the drivers. However, our aim is to get you to your destination as quickly as possible, which is why we don't schedule any other type of break.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              letterSpacing: 0.6,
                              color: AppColorConst.kappWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AdvanceExpansionTile(
                iconColor: AppColorConst.kappsecondaryColorBlack,
                textColor: AppColorConst.kappsecondaryColorBlack,
                collapsedTextColor: AppColorConst.kappsecondaryColorBlack,
                collapsedIconColor: AppColorConst.kappsecondaryColorBlack,
                key: _globalKey6,
                title: const Text(
                  "I’m running a little late. Will the vehicle wait for me?",
                  style: TextStyle(letterSpacing: 0.6),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColorConst.kappscafoldbggrey),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: Container(
                      width: double.infinity,
                      color: AppColorConst.kappprimaryColorRed,
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Unfortunately, the vehicle cannot wait for delayed passengers. Our vehicles travel within a network and are bound to a timetable. Please ensure that you are at the stop at least 15 minutes before departure.\n\nIf you realize that you’re not going to make it, you can cancel your ride up to 15 minutes before departure via Booking screen.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              letterSpacing: 0.6,
                              color: AppColorConst.kappWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
