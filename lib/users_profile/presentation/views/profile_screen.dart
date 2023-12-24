import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickalert/quickalert.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/auth/presentation/login/controllers/login_controllers/user_login_controller.dart';
import 'package:sajilo_yatra/commons/custom_primary_button.dart';
import 'package:sajilo_yatra/const/app_colors_const.dart';
import 'package:sajilo_yatra/const/app_const.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';
import 'package:sajilo_yatra/const/app_fonts.dart';
import 'package:sajilo_yatra/const/app_images_const.dart';
import 'package:sajilo_yatra/help/help.dart';
import 'package:sajilo_yatra/offers/offers.dart';
import 'package:sajilo_yatra/users_profile/data/models/profile_params_model.dart';
import 'package:sajilo_yatra/users_profile/presentation/controllers/profile_controller.dart';
import 'package:sajilo_yatra/utils/bottom_bar/bottom_bar.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loader_skeleton/loader_skeleton.dart';
import 'package:logger/logger.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

import '../../../users_edit profile/presentation/views/edit_profile_screen.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<Profile> {
  String token = "";
  var parsedToken = 0;
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  void initState() {
    super.initState();
    loadData(); // Preload the data when the widget is built.
  }

  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('tokens') ?? "";
      logger.d(token);
      parsedToken = int.tryParse(token) ?? 0;
      logger.d(parsedToken);
    });
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
        actions: [
          Consumer(
            builder: (context, ref, child) => IconButton(
              icon: const Icon(Icons.logout_outlined),
              tooltip: 'Open shopping cart',
              onPressed: () async {
                QuickAlert.show(
                    context: context,
                    type: QuickAlertType.confirm,
                    text: 'Do you want to logout',
                    confirmBtnText: 'Yes',
                    cancelBtnText: 'No',
                    confirmBtnColor: Colors.green,
                    onConfirmBtnTap: () async {
                      await ref
                          .watch(loginControllerProvider.notifier)
                          .logout(context);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 800),
                            content: const Text("Log Out Successfully"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }
                    });
              },

              // await ref.read(authControllerProvider.notifier).logout(context);
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(children: [
            ClipPath(
              clipper: CurvedBottomClipper(),
              child: Container(
                height: 27.h,
                color: AppColorConst.kappprimaryColorRed,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 60),
                    width: 89.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: const Offset(0, 2),
                          blurRadius: 7.0,
                          spreadRadius:
                              2.0, // Adjust the spreadRadius value as desired
                        ),
                        //BoxShadow
                        //BoxShadow
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        assingedClass.when(
                            data: (data) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 9.5.h,
                                  ),
                                  Text(
                                    data.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: AppDimensions.body_22,
                                        letterSpacing: 0.5,
                                        fontFamily: AppFont.lProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: Color.fromARGB(255, 59, 59, 59)),
                                    overflow: TextOverflow
                                        .ellipsis, // Display ellipsis (...) for overflowing text
                                    maxLines: 1,
                                  ),
                                  const SizedBox(
                                    height: AppDimensions.paddingLARGE,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: AppDimensions.paddingLARGE,
                                      ),
                                      const Icon(
                                        CupertinoIcons.phone_fill,
                                        color: Color.fromARGB(255, 59, 59, 59),
                                      ),
                                      const SizedBox(
                                        width: AppDimensions.paddingDEFAULT,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Text(
                                                data.phone,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  fontSize:
                                                      AppDimensions.body_15,
                                                  letterSpacing: 0.7,
                                                  fontFamily:
                                                      AppFont.pProductsanfont,
                                                  fontWeight:
                                                      AppDimensions.fontNormal,
                                                  color: CupertinoColors
                                                      .systemGrey,
                                                ),
                                                overflow: TextOverflow
                                                    .ellipsis, // Display ellipsis (...) for overflowing text
                                                maxLines:
                                                    1, // Display a single line of text
                                              ),
                                              const SizedBox(
                                                width: AppDimensions
                                                    .paddingDEFAULT,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: AppDimensions.paddingSMALL,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: AppDimensions.paddingLARGE,
                                      ),
                                      const Icon(
                                        CupertinoIcons.mail_solid,
                                        color: Color.fromARGB(255, 59, 59, 59),
                                      ),
                                      const SizedBox(
                                        width: AppDimensions.paddingDEFAULT,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Text(
                                                data.email,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  fontSize:
                                                      AppDimensions.body_15,
                                                  letterSpacing: 0.7,
                                                  fontFamily:
                                                      AppFont.pProductsanfont,
                                                  fontWeight:
                                                      AppDimensions.fontNormal,
                                                  color: CupertinoColors
                                                      .systemGrey,
                                                ),
                                                overflow: TextOverflow
                                                    .ellipsis, // Display ellipsis (...) for overflowing text
                                                maxLines:
                                                    1, // Display a single line of text
                                              ),
                                              const SizedBox(
                                                width: AppDimensions
                                                    .paddingDEFAULT,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: AppDimensions.paddingSMALL,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: AppDimensions.paddingLARGE,
                                      ),
                                      const Icon(
                                        Icons.location_on_rounded,
                                        color: Color.fromARGB(255, 59, 59, 59),
                                      ),
                                      const SizedBox(
                                        width: AppDimensions.paddingDEFAULT,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Text(
                                                data.location,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  fontSize:
                                                      AppDimensions.body_15,
                                                  letterSpacing: 0.7,
                                                  fontFamily:
                                                      AppFont.pProductsanfont,
                                                  fontWeight:
                                                      AppDimensions.fontNormal,
                                                  color: CupertinoColors
                                                      .systemGrey,
                                                ),
                                                overflow: TextOverflow
                                                    .ellipsis, // Display ellipsis (...) for overflowing text
                                                maxLines:
                                                    1, // Display a single line of text
                                              ),
                                              const SizedBox(
                                                width: AppDimensions
                                                    .paddingDEFAULT,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: AppDimensions.paddingSMALL,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: AppDimensions.paddingLARGE,
                                      ),
                                      const Icon(
                                        CupertinoIcons.calendar,
                                        color: Color.fromARGB(255, 59, 59, 59),
                                      ),
                                      const SizedBox(
                                        width: AppDimensions.paddingDEFAULT,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Text(
                                                data.dob,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                  fontSize:
                                                      AppDimensions.body_15,
                                                  letterSpacing: 0.7,
                                                  fontFamily:
                                                      AppFont.pProductsanfont,
                                                  fontWeight:
                                                      AppDimensions.fontNormal,
                                                  color: CupertinoColors
                                                      .systemGrey,
                                                ),
                                                overflow: TextOverflow
                                                    .ellipsis, // Display ellipsis (...) for overflowing text
                                                maxLines:
                                                    1, // Display a single line of text
                                              ),
                                              const SizedBox(
                                                width: AppDimensions
                                                    .paddingDEFAULT,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: AppDimensions.paddingDEFAULT,
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: AppDimensions.paddingDEFAULT,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      normalNav(context, const EditProfile());
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.pencil_outline,
                                            color:
                                                Color.fromARGB(255, 59, 59, 59),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 28.0),
                                            child: Text(
                                              AppConst.kEditProfile,
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppFont.lProductsanfont,
                                                  letterSpacing: 1,
                                                  fontWeight:
                                                      AppDimensions.fontMedium,
                                                  color: Color.fromARGB(
                                                      255, 59, 59, 59),
                                                  fontSize:
                                                      AppDimensions.body_16),
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(Icons.arrow_forward_ios_outlined,
                                              size: 17,
                                              color:
                                                  CupertinoColors.systemGrey4),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppDimensions.paddingLARGE,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.history_outlined,
                                          color:
                                              Color.fromARGB(255, 59, 59, 59),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 28.0),
                                          child: Text(
                                            AppConst.kHistory,
                                            style: TextStyle(
                                                fontFamily:
                                                    AppFont.lProductsanfont,
                                                letterSpacing: 1,
                                                fontWeight:
                                                    AppDimensions.fontMedium,
                                                color: Color.fromARGB(
                                                    255, 59, 59, 59),
                                                fontSize:
                                                    AppDimensions.body_16),
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_forward_ios_outlined,
                                            size: 17,
                                            color: CupertinoColors.systemGrey4),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppDimensions.paddingLARGE,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      normalNav(context, const Offers());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.percent_outlined,
                                            color:
                                                Color.fromARGB(255, 59, 59, 59),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 28.0),
                                            child: Text(
                                              AppConst.kOffers,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      AppFont.lProductsanfont,
                                                  letterSpacing: 1,
                                                  fontWeight:
                                                      AppDimensions.fontMedium,
                                                  color: Color.fromARGB(
                                                      255, 59, 59, 59),
                                                  fontSize:
                                                      AppDimensions.body_16),
                                            ),
                                          ),
                                          const Spacer(),
                                          const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 17,
                                              color:
                                                  CupertinoColors.systemGrey4),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppDimensions.paddingLARGE,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      normalNav(context, const Help());
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.help_outline,
                                            color:
                                                Color.fromARGB(255, 59, 59, 59),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 28.0),
                                            child: Text(
                                              AppConst.kHelp,
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppFont.lProductsanfont,
                                                  letterSpacing: 1,
                                                  fontWeight:
                                                      AppDimensions.fontMedium,
                                                  color: Color.fromARGB(
                                                      255, 59, 59, 59),
                                                  fontSize:
                                                      AppDimensions.body_16),
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(Icons.arrow_forward_ios_outlined,
                                              size: 17,
                                              color:
                                                  CupertinoColors.systemGrey4),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            error: (er, s) => Text(er.toString()),
                            loading: () => Center(
                                    child: CardPageSkeleton(
                                  totalLines: 10,
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
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 2.0,
                      spreadRadius:
                          2.0, // Adjust the spreadRadius value as desired
                    ),
                    //BoxShadow
                    //BoxShadow
                  ],
                  border: Border.all(
                    color: AppColorConst
                        .kappWhiteColor, // Set the border color here
                    width: 3.7, // Set the border width here
                  ),
                ),
                child: CircleAvatar(
                  maxRadius: 45,
                  child: Image.asset(
                    AppImagesConst.appCar,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 1.9.h,
          ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 18.0),
          //   child: Row(
          //     children: [
          //       const CircleAvatar(
          //         backgroundColor: AppColorConst.kappprimaryColorRed,
          //         child: Icon(
          //           Icons.logout_outlined,
          //           color: AppColorConst.kappWhiteColor,
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 28.0),
          //         child: Text(
          //           AppConst.kLogout,
          //           style: const TextStyle(
          //               fontFamily: AppFont.lProductsanfont,
          //               letterSpacing: 0.4,
          //               fontWeight: AppDimensions.fontMedium,
          //               color: Color.fromARGB(255, 0, 0, 0),
          //               fontSize: AppDimensions.body_20),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30); // Start at the top-left corner
    final firstControlPoint = Offset(size.width / 4, size.height);
    final firstEndPoint = Offset(size.width / 2, size.height - 20);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final secondControlPoint =
        Offset(size.width - (size.width / 1), size.height);
    final secondEndPoint = Offset(size.width, size.height - 130);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0); // Line to the top-right corner
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CurvedBottomClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Move to the top-left corner
    final firstControlPoint = Offset(size.width / 4, 0);
    final firstEndPoint = Offset(size.width / 2, 20);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final secondControlPoint = Offset(size.width - (size.width / 4), 40);
    final secondEndPoint = Offset(size.width, 80);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height); // Line to the bottom-right corner
    path.lineTo(0, size.height); // Line to the bottom-left corner
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CurvedBottomClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Move to the top-left corner
    final firstControlPoint = Offset(size.width / 4, 0);
    final firstEndPoint = Offset(size.width / 2, 20);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final secondControlPoint = Offset(size.width - (size.width / 4), 40);
    final secondEndPoint = Offset(size.width, 80);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height); // Line to the bottom-right corner
    path.lineTo(0, size.height); // Line to the bottom-left corner
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
