// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:convert';

import 'package:sajilo_yatra/helpers/ui_helper.dart';

class OfferTwo extends StatefulWidget {
  const OfferTwo({Key? key}) : super(key: key);

  @override
  State<OfferTwo> createState() => _OfferTwoState();
}

class _OfferTwoState extends State<OfferTwo> {
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
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0062DE),
        centerTitle: true,
        title: const Text('Offers',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: 'ComicNeue',
              fontSize: 24,
              fontWeight: FontWeight.w900,
            )),
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFFFFFFFF),
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
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
                      height: UiHelper.displayHeight(context) * 0.218,
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
                            margin: const EdgeInsets.only(top: 35, left: 23),
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              "images/two.png",
                              height: UiHelper.displayHeight(context) * 0.12,
                              width: UiHelper.displayWidth(context) * 0.29,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 27, top: 26),
                            child: Column(
                              children: [
                                Text(
                                  "SAVE Rs: 200",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Sen",
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF222222),
                                    fontSize:
                                        UiHelper.displayWidth(context) * 0.077,
                                  ),
                                ),
                                UiHelper.verticalSpace(vspace: Spacing.xxsmall),
                                Text(
                                  "on KTM Tickets",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize:
                                        UiHelper.displayWidth(context) * 0.052,
                                  ),
                                ),
                                Container(
                                  height:
                                      UiHelper.displayHeight(context) * 0.05,
                                  width: UiHelper.displayWidth(context) * 0.4,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF4E93E8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  margin: const EdgeInsets.only(top: 8.5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "CODE :",
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            fontWeight: FontWeight.w900,
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 17),
                                      ),
                                      Text(
                                        " UIGF78",
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            fontWeight: FontWeight.w900,
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 17),
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
                        "Save Rs: 200 on KTM Tickets",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 2.8,
                          color: Color(0xff2222222),
                          fontSize: 19.5,
                          fontFamily: "BalooTammudu2",
                          fontWeight: FontWeight.w500,
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
                            Container(height: 2.h),
                            Container(
                              child: Column(children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              height: UiHelper.displayHeight(
                                                      context) *
                                                  0.02,
                                              width: UiHelper.displayWidth(
                                                      context) *
                                                  0.039,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF9BC2F2),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(80.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    offset: const Offset(0, 8),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 0.0,
                                                  ), //BoxShadow
                                                  //BoxShadow
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Text(
                                                'Apply Coupon code UIGF78 on KTM tickets and \nsave Rs.200 on UIGF78 vehicle services',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    letterSpacing: 0.3,
                                                    height: 0.17.h,
                                                    fontFamily: "KumbhSans",
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xFF222222),
                                                    fontSize:
                                                        UiHelper.displayWidth(
                                                                context) *
                                                            0.036),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(height: 2.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              height: UiHelper.displayHeight(
                                                      context) *
                                                  0.02,
                                              width: UiHelper.displayWidth(
                                                      context) *
                                                  0.039,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF9BC2F2),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(80.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    offset: const Offset(0, 8),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 0.0,
                                                  ), //BoxShadow
                                                  //BoxShadow
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Text(
                                                'New users will get 10% up to Rs.150 discount \n+ 100% up to Rs.70 Promo Sajilo Yatra Cashback',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    letterSpacing: 0.3,
                                                    height: 0.17.h,
                                                    fontFamily: "KumbhSans",
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xFF222222),
                                                    fontSize:
                                                        UiHelper.displayWidth(
                                                                context) *
                                                            0.036),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(height: 2.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              height: UiHelper.displayHeight(
                                                      context) *
                                                  0.02,
                                              width: UiHelper.displayWidth(
                                                      context) *
                                                  0.039,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF9BC2F2),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(80.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    offset: const Offset(0, 8),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 0.0,
                                                  ), //BoxShadow
                                                  //BoxShadow
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Text(
                                                'Existing customers get 100% up to Rs.100 Promo \nSajilo Yatra Cashback',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    letterSpacing: 0.3,
                                                    fontFamily: "KumbhSans",
                                                    height: 0.17.h,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xFF222222),
                                                    fontSize:
                                                        UiHelper.displayWidth(
                                                                context) *
                                                            0.036),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(height: 2.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              height: UiHelper.displayHeight(
                                                      context) *
                                                  0.02,
                                              width: UiHelper.displayWidth(
                                                      context) *
                                                  0.039,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF9BC2F2),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(80.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    offset: const Offset(0, 8),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 0.0,
                                                  ), //BoxShadow
                                                  //BoxShadow
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Text(
                                                'This is a special offer valid for vehicle bookings \nmade on Sajilo Yatra for UIGF78 vehicle \nbookings only',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    letterSpacing: 0.3,
                                                    height: 0.17.h,
                                                    fontFamily: "KumbhSans",
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xFF222222),
                                                    fontSize:
                                                        UiHelper.displayWidth(
                                                                context) *
                                                            0.036),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(height: 2.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              height: UiHelper.displayHeight(
                                                      context) *
                                                  0.02,
                                              width: UiHelper.displayWidth(
                                                      context) *
                                                  0.039,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF9BC2F2),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(80.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    offset: const Offset(0, 8),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 0.0,
                                                  ), //BoxShadow
                                                  //BoxShadow
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Text(
                                                'No minimum transaction value applicable',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    letterSpacing: 0.3,
                                                    height: 0.17.h,
                                                    fontFamily: "KumbhSans",
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xFF222222),
                                                    fontSize:
                                                        UiHelper.displayWidth(
                                                                context) *
                                                            0.036),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(height: 2.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              height: UiHelper.displayHeight(
                                                      context) *
                                                  0.02,
                                              width: UiHelper.displayWidth(
                                                      context) *
                                                  0.039,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF9BC2F2),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(80.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    offset: const Offset(0, 8),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 0.0,
                                                  ), //BoxShadow
                                                  //BoxShadow
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Text(
                                                'This offer is valid only once per user, only on \nUIGF78 Vehicle Bookings',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    letterSpacing: 0.3,
                                                    height: 0.17.h,
                                                    fontFamily: "KumbhSans",
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xFF222222),
                                                    fontSize:
                                                        UiHelper.displayWidth(
                                                                context) *
                                                            0.036),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(height: 2.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              height: UiHelper.displayHeight(
                                                      context) *
                                                  0.02,
                                              width: UiHelper.displayWidth(
                                                      context) *
                                                  0.039,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF9BC2F2),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(80.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    offset: const Offset(0, 8),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 0.0,
                                                  ), //BoxShadow
                                                  //BoxShadow
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Text(
                                                'This offer cannot be combined with any \nother offer',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    letterSpacing: 0.3,
                                                    height: 0.17.h,
                                                    fontFamily: "KumbhSans",
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xFF222222),
                                                    fontSize:
                                                        UiHelper.displayWidth(
                                                                context) *
                                                            0.036),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                            )
                          ],
                        ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 40,
                            width: 125,
                            margin: const EdgeInsets.only(
                              top: 15,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xFF4E93E8), //background color of button
                                //border width and color

                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text(
                                "Copy Code",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  height: 1,
                                  fontFamily: "ZenKakuGothicAntique",
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                String code =
                                    "UIGF78"; // replace with the actual code string
                                Clipboard.setData(ClipboardData(text: code));
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  text: 'Code copied to clipboard',
                                  confirmBtnColor: const Color(0xFF0062DE),
                                );
                              },
                            )),
                        Container(
                            height: 40,
                            width: 125,
                            margin: const EdgeInsets.only(top: 15, left: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xFF4E93E8), //background color of button
                                //border width and color

                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text(
                                "Book Now",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  height: 1,
                                  fontFamily: "ZenKakuGothicAntique",
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/tenth');
                              },
                            )),
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
