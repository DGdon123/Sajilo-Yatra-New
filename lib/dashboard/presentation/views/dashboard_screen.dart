import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/auth/data/models/forget_password_models/user_forgot_password_request_model.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%202.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%203.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%204.dart';
import 'package:sajilo_yatra/offers/offerone%20copy%205.dart';
import 'package:sajilo_yatra/offers/offerone%20copy.dart';
import 'package:sajilo_yatra/offers/offerone.dart';
import 'package:sajilo_yatra/ride/data/address_model.dart';
import 'package:sajilo_yatra/ride/presentation/views/home_address.dart';
import 'package:sajilo_yatra/ride/presentation/views/home_destination.dart';
import 'package:sajilo_yatra/ride/presentation/views/set_work_location.dart';
import 'package:sajilo_yatra/ride/presentation/views/work_address.dart';
import 'package:sajilo_yatra/ride/presentation/views/work_destination.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:sajilo_yatra/utils/form_validation/form_validation_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../const/app_colors_const.dart';
import '../../../../../const/app_const.dart';
import '../../../../../const/app_dimension.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../../const/app_fonts.dart';
import '../../../auth/presentation/login/controllers/forget_password_controllers/user_forget_password_controller.dart';
import '../../../auth/presentation/login/controllers/login_controllers/auth_state_helper.dart';
import '../../../auth/presentation/login/views/main_login_screen.dart';
import '../../../auth/presentation/login/views/vehicle_owners_forget_password/vehicle_owner_forget_password_token_screen.dart';
import '../../../const/app_images_const.dart';
import '../../../ride/presentation/views/search_destination.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<Dashboard> {
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> forgotSignKey = GlobalKey<FormState>();

  LatLng? currentLocation;
  AddressClassModel? add;
  String? currentAddress;

  @override
  void dispose() {
    emailController.clear();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefsData();
    getCurrentLocation();
  }

  void loadSharedPrefsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    add = AddressClassModel(
      home: prefs.getString('home'),
      work: prefs.getString('work'),
      home1: prefs.getString('home1'),
      work1: prefs.getString('work1'),
      lat1: prefs.getDouble('lat1'),
      long1: prefs.getDouble('long1'),
      lat2: prefs.getDouble('lat2'),
      long2: prefs.getDouble('long2'),
      latitude1: prefs.getDouble('latitude1'),
      longitude1: prefs.getDouble('longitude1'),
      latitude2: prefs.getDouble('latitude2'),
      longitude2: prefs.getDouble('longitude2'),
    );
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle the case where the user denies location permission
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle the case where the user permanently denies location permission
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLocation = LatLng(position.latitude, position.longitude);
      await getCurrentAddress();
    }
  }

  Future<void> getCurrentAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      currentLocation!.latitude,
      currentLocation!.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];

      String thoroughfare = placemark.thoroughfare ?? '';
      String locality = placemark.locality ?? '';
      String administrativeArea = placemark.administrativeArea ?? '';

      currentAddress = '$thoroughfare, $locality, $administrativeArea';
    }
    setState(() {});
  }

  void Function()? toogleObcure() {
    ref
        .read(loginscreenPasswordObscureProvider.notifier)
        .update((state) => !state);
    return null;
  }

  void Function()? toogleUserProfessional() {
    ref.read(isUserProvider.notifier).update((state) => !state);
    return null;
  }

  appLogin() async {
    ForgotPasswordRequestModel forgotPasswordRequestModel =
        ForgotPasswordRequestModel(
      email: emailController.text,
    );
    if (forgotSignKey.currentState!.validate()) {
      ref.read(forgotpasswordloadingProvider.notifier).update((state) => true);
      await ref.read(forgetpasswordControllerProvider.notifier).forgot_password(
          context: context,
          forgotPasswordRequestModel: forgotPasswordRequestModel);
    }

    ref.read(forgotpasswordloadingProvider.notifier).update((state) => false);
    // normalNav(context, const AssignClassScreen());
  }

  @override
  Widget build(BuildContext context) {
    log(currentAddress.toString());
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
                pushAndRemoveUntil(context, const LoginScreen());
              },
            )
          ],
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.white,
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
                    AppConst.kappBarServices,
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
                            onPressed: () async {},
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
                            onPressed: () async {},
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
                            onPressed: () async {},
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
              const SizedBox(height: AppDimensions.paddingEXTRALARGE),
              Row(
                children: [
                  const SizedBox(width: AppDimensions.paddingLARGE),
                  Text(
                    "Take a ride to",
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    height: 6.h,
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.location_on_rounded,
                          color: AppColorConst.kappprimaryColorRed,
                        ),
                        suffixIcon: Icon(
                          CupertinoIcons.search,
                          size: 5.w,
                          color: CupertinoColors.darkBackgroundGray,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.8,
                                color: AppColorConst.kappscafoldbggrey,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(7)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.8,
                                color: AppColorConst.kappscafoldbggrey,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(7)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.8,
                                color: AppColorConst.kappscafoldbggrey,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(7)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.8,
                                color: AppColorConst.kappscafoldbggrey,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(7)),
                        border: InputBorder.none,
                        fillColor: const Color(0xffF9F9FC),
                        filled: true,
                        hintText: AppConst.ksearchDestination,
                        hintStyle: const TextStyle(
                            fontSize: AppDimensions.body_14,
                            fontWeight: FontWeight.w100,
                            letterSpacing: 0.25,
                            fontFamily: AppFont.kProductsanfont),
                        // labelStyle:
                        //     const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                        // label: Text(
                        //   lable,
                        // ),
                      ),
                      controller: emailController,
                      onTap: () {
                        normalNav(context, const Destination());
                      },
                      validator: (input) => input!.isValidEmail(input),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.paddingDEFAULT),
              Row(
                children: [
                  const SizedBox(
                    width: AppDimensions.paddingLARGE,
                  ),
                  Container(
                    width: 88.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffF9F9FC),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  if (add?.home1 != "") {
                                    return SlideTransition(
                                      position: animation.drive(
                                        Tween(
                                          begin: const Offset(0, 1),
                                          end: Offset.zero,
                                        ).chain(
                                          CurveTween(curve: Curves.easeOut),
                                        ),
                                      ),
                                      child: HomeLocation(
                                        latitude:
                                            double.parse(add!.lat1.toString()),
                                        longitude:
                                            double.parse(add!.long1.toString()),
                                        destination: add!.home1.toString(),
                                      ), // Replace with your desired screen
                                    );
                                  } else if (add?.home != "") {
                                    return SlideTransition(
                                        position: animation.drive(
                                          Tween(
                                            begin: const Offset(0, 1),
                                            end: Offset.zero,
                                          ).chain(
                                            CurveTween(curve: Curves.easeOut),
                                          ),
                                        ),
                                        child: HomeLocation(
                                          latitude: double.parse(
                                              add!.latitude1.toString()),
                                          longitude: double.parse(
                                              add!.longitude1.toString()),
                                          destination: add!.home.toString(),
                                        ) // Replace with your desired screen
                                        );
                                  } else {
                                    return SlideTransition(
                                      position: animation.drive(
                                        Tween(
                                          begin: const Offset(0, 1),
                                          end: Offset.zero,
                                        ).chain(
                                          CurveTween(curve: Curves.easeOut),
                                        ),
                                      ),
                                      child:
                                          const HomeAddress(), // Replace with your desired screen
                                    );
                                  }
                                },
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              const SizedBox(
                                width: AppDimensions.paddingSMALL,
                              ),
                              Container(
                                width: 9.w,
                                height: 5.h,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Icon(
                                  CupertinoIcons.home,
                                  size: 4.85.w,
                                  color: AppColorConst.kappprimaryColorRed,
                                ),
                              ),
                              const SizedBox(
                                width: AppDimensions.paddingSMALL,
                              ),
                              SizedBox(
                                width: 27.5.w,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 1.27.h),
                                      Text(
                                        AppConst.kappBarHome,
                                        style: TextStyle(
                                            fontSize: AppDimensions.body_12,
                                            letterSpacing: 0.06.dp,
                                            fontFamily: AppFont.lProductsanfont,
                                            fontWeight: AppDimensions.fontBold,
                                            color: AppColorConst
                                                .kappsecondaryColorBlack),
                                      ),
                                      const SizedBox(
                                          height:
                                              AppDimensions.paddingEXTRASMALL),
                                      Text(
                                        add?.home1 ??
                                            add?.home ??
                                            AppConst.kSetHome ??
                                            "Set Home Address",
                                        style: const TextStyle(
                                            fontSize: AppDimensions.body_11,
                                            fontFamily: AppFont.lProductsanfont,
                                            fontWeight:
                                                AppDimensions.fontNormal,
                                            color: AppColorConst
                                                .kappscafoldbggrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  if (add?.work1 != "") {
                                    return SlideTransition(
                                      position: animation.drive(
                                        Tween(
                                          begin: const Offset(0, 1),
                                          end: Offset.zero,
                                        ).chain(
                                          CurveTween(curve: Curves.easeOut),
                                        ),
                                      ),
                                      child: WorkLocation(
                                        latitude:
                                            double.parse(add!.lat2.toString()),
                                        longitude:
                                            double.parse(add!.long2.toString()),
                                        destination: add!.work1.toString(),
                                      ), // Replace with your desired screen
                                    );
                                  } else if (add?.work != "") {
                                    return SlideTransition(
                                        position: animation.drive(
                                          Tween(
                                            begin: const Offset(0, 1),
                                            end: Offset.zero,
                                          ).chain(
                                            CurveTween(curve: Curves.easeOut),
                                          ),
                                        ),
                                        child: WorkLocation(
                                          latitude: double.parse(
                                              add!.latitude2.toString()),
                                          longitude: double.parse(
                                              add!.longitude2.toString()),
                                          destination: add!.work.toString(),
                                        ) // Replace with your desired screen
                                        );
                                  } else {
                                    return SlideTransition(
                                      position: animation.drive(
                                        Tween(
                                          begin: const Offset(0, 1),
                                          end: Offset.zero,
                                        ).chain(
                                          CurveTween(curve: Curves.easeOut),
                                        ),
                                      ),
                                      child:
                                          const WorkAddress(), // Replace with your desired screen
                                    );
                                  }
                                },
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              const SizedBox(
                                width: AppDimensions.paddingDEFAULT,
                              ),
                              Container(
                                width: 9.w,
                                height: 5.h,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Icon(
                                  Icons.business_center_rounded,
                                  size: 4.85.w,
                                  color: AppColorConst.kappprimaryColorRed,
                                ),
                              ),
                              const SizedBox(
                                width: AppDimensions.paddingSMALL,
                              ),
                              SizedBox(
                                width: 27.5.w,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 1.27.h),
                                      Text(
                                        AppConst.kWork,
                                        style: TextStyle(
                                            fontSize: AppDimensions.body_12,
                                            letterSpacing: 0.06.dp,
                                            fontFamily: AppFont.lProductsanfont,
                                            fontWeight: AppDimensions.fontBold,
                                            color: AppColorConst
                                                .kappsecondaryColorBlack),
                                      ),
                                      const SizedBox(
                                          height:
                                              AppDimensions.paddingEXTRASMALL),
                                      Text(
                                        add?.work1 ??
                                            add?.work ??
                                            AppConst.kSetWork ??
                                            "Set Work Address",
                                        style: const TextStyle(
                                            fontSize: AppDimensions.body_11,
                                            fontFamily: AppFont.lProductsanfont,
                                            fontWeight:
                                                AppDimensions.fontNormal,
                                            color: AppColorConst
                                                .kappscafoldbggrey),
                                      ),
                                    ],
                                  ),
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
              const SizedBox(height: AppDimensions.paddingEXTRALARGE),
              Row(
                children: [
                  const SizedBox(width: AppDimensions.paddingLARGE),
                  Text(
                    "Check out some offers?",
                    style: TextStyle(
                        fontSize: AppDimensions.body_18,
                        letterSpacing: 0.06.dp,
                        fontFamily: AppFont.kProductsanfont,
                        fontWeight: AppDimensions.fontBold,
                        color: AppColorConst.kappprimaryColorRed),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.paddingEXTRASMALL),
              SizedBox(
                height: 34.h,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(width: AppDimensions.paddingLARGE),
                      InkWell(
                        onTap: () {
                          normalNav(context, const OfferOne());
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 30.h,
                              width: 50.w,
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(3.8)),
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
                                  const SizedBox(
                                      height: AppDimensions.paddingSMALL),
                                  Text(
                                    "SAVE Rs: 100",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_16,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.qProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst
                                            .kappsecondaryColorBlack),
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
                                  const SizedBox(
                                      height: AppDimensions.paddingSMALL),
                                  Container(
                                    height: 4.h,
                                    width: 39.w,
                                    decoration: const BoxDecoration(
                                      color: AppColorConst.kappprimaryColorRed,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "CODE : ",
                                          style: TextStyle(
                                              fontSize: AppDimensions.body_13,
                                              letterSpacing: 0.06.dp,
                                              fontFamily:
                                                  AppFont.xProductsanfont,
                                              fontWeight:
                                                  AppDimensions.fontBold,
                                              color:
                                                  AppColorConst.kappWhiteColor),
                                        ),
                                        Text(
                                          "YGFJY899",
                                          style: TextStyle(
                                              fontSize: AppDimensions.body_13,
                                              letterSpacing: 0.06.dp,
                                              fontFamily:
                                                  AppFont.xProductsanfont,
                                              fontWeight:
                                                  AppDimensions.fontBold,
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
                      const SizedBox(width: AppDimensions.paddingLARGE),
                      InkWell(
                        onTap: () {
                          normalNav(context, const OfferThree());
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 30.h,
                              width: 50.w,
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(3.8)),
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
                                  const SizedBox(
                                      height: AppDimensions.paddingSMALL),
                                  Text(
                                    "SAVE Rs: 900",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_16,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.qProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst
                                            .kappsecondaryColorBlack),
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
                                  const SizedBox(
                                      height: AppDimensions.paddingSMALL),
                                  Container(
                                    height: 4.h,
                                    width: 39.w,
                                    decoration: const BoxDecoration(
                                      color: AppColorConst.kappprimaryColorRed,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "CODE : ",
                                          style: TextStyle(
                                              fontSize: AppDimensions.body_13,
                                              letterSpacing: 0.06.dp,
                                              fontFamily:
                                                  AppFont.xProductsanfont,
                                              fontWeight:
                                                  AppDimensions.fontBold,
                                              color:
                                                  AppColorConst.kappWhiteColor),
                                        ),
                                        Text(
                                          "HRDTY56",
                                          style: TextStyle(
                                              fontSize: AppDimensions.body_13,
                                              letterSpacing: 0.06.dp,
                                              fontFamily:
                                                  AppFont.xProductsanfont,
                                              fontWeight:
                                                  AppDimensions.fontBold,
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
                      const SizedBox(width: AppDimensions.paddingLARGE),
                      InkWell(
                        onTap: () {
                          normalNav(context, const OfferFour());
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 30.h,
                              width: 50.w,
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(3.8)),
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
                                  const SizedBox(
                                      height: AppDimensions.paddingSMALL),
                                  Text(
                                    "SAVE Rs: 2000",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_16,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.qProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst
                                            .kappsecondaryColorBlack),
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
                                  const SizedBox(
                                      height: AppDimensions.paddingSMALL),
                                  Container(
                                    height: 4.h,
                                    width: 39.w,
                                    decoration: const BoxDecoration(
                                      color: AppColorConst.kappprimaryColorRed,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "CODE : ",
                                          style: TextStyle(
                                              fontSize: AppDimensions.body_13,
                                              letterSpacing: 0.06.dp,
                                              fontFamily:
                                                  AppFont.xProductsanfont,
                                              fontWeight:
                                                  AppDimensions.fontBold,
                                              color:
                                                  AppColorConst.kappWhiteColor),
                                        ),
                                        Text(
                                          "AKI745",
                                          style: TextStyle(
                                              fontSize: AppDimensions.body_13,
                                              letterSpacing: 0.06.dp,
                                              fontFamily:
                                                  AppFont.xProductsanfont,
                                              fontWeight:
                                                  AppDimensions.fontBold,
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
                      const SizedBox(width: AppDimensions.paddingLARGE),
                      InkWell(
                        onTap: () {
                          normalNav(context, const OfferFour());
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 30.h,
                              width: 50.w,
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(3.8)),
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
                                  const SizedBox(
                                      height: AppDimensions.paddingSMALL),
                                  Text(
                                    "SAVE Rs: 1000",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_16,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.qProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst
                                            .kappsecondaryColorBlack),
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
                                  const SizedBox(
                                      height: AppDimensions.paddingSMALL),
                                  Container(
                                    height: 4.h,
                                    width: 39.w,
                                    decoration: const BoxDecoration(
                                      color: AppColorConst.kappprimaryColorRed,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "CODE : ",
                                          style: TextStyle(
                                              fontSize: AppDimensions.body_13,
                                              letterSpacing: 0.06.dp,
                                              fontFamily:
                                                  AppFont.xProductsanfont,
                                              fontWeight:
                                                  AppDimensions.fontBold,
                                              color:
                                                  AppColorConst.kappWhiteColor),
                                        ),
                                        Text(
                                          "HGHG7",
                                          style: TextStyle(
                                              fontSize: AppDimensions.body_13,
                                              letterSpacing: 0.06.dp,
                                              fontFamily:
                                                  AppFont.xProductsanfont,
                                              fontWeight:
                                                  AppDimensions.fontBold,
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
                      const SizedBox(width: AppDimensions.paddingLARGE),
                      InkWell(
                        onTap: () {
                          normalNav(context, const OfferFive());
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 30.h,
                              width: 50.w,
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(3.8)),
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
                                  const SizedBox(
                                      height: AppDimensions.paddingSMALL),
                                  Text(
                                    "SAVE Rs: 70",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_16,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.qProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst
                                            .kappsecondaryColorBlack),
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
                                  const SizedBox(
                                      height: AppDimensions.paddingSMALL),
                                  Container(
                                    height: 4.h,
                                    width: 39.w,
                                    decoration: const BoxDecoration(
                                      color: AppColorConst.kappprimaryColorRed,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "CODE : ",
                                          style: TextStyle(
                                              fontSize: AppDimensions.body_13,
                                              letterSpacing: 0.06.dp,
                                              fontFamily:
                                                  AppFont.xProductsanfont,
                                              fontWeight:
                                                  AppDimensions.fontBold,
                                              color:
                                                  AppColorConst.kappWhiteColor),
                                        ),
                                        Text(
                                          "JHVJ34",
                                          style: TextStyle(
                                              fontSize: AppDimensions.body_13,
                                              letterSpacing: 0.06.dp,
                                              fontFamily:
                                                  AppFont.xProductsanfont,
                                              fontWeight:
                                                  AppDimensions.fontBold,
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
                      const SizedBox(width: AppDimensions.paddingLARGE),
                      InkWell(
                        onTap: () {
                          normalNav(context, const OfferSix());
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 30.h,
                              width: 50.w,
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(3.8)),
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
                                  const SizedBox(
                                      height: AppDimensions.paddingSMALL),
                                  Text(
                                    "SAVE Rs: 500",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_16,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.qProductsanfont,
                                        fontWeight: AppDimensions.fontBold,
                                        color: AppColorConst
                                            .kappsecondaryColorBlack),
                                  ),
                                  Text(
                                    "on Five Ticket/Ride",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: AppDimensions.body_13,
                                        letterSpacing: 0.06.dp,
                                        fontFamily: AppFont.qProductsanfont,
                                        fontWeight: AppDimensions.fontNormal,
                                        color: AppColorConst.kappscafoldbggrey),
                                  ),
                                  const SizedBox(
                                      height: AppDimensions.paddingSMALL),
                                  Container(
                                    height: 4.h,
                                    width: 39.w,
                                    decoration: const BoxDecoration(
                                      color: AppColorConst.kappprimaryColorRed,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "CODE : ",
                                          style: TextStyle(
                                              fontSize: AppDimensions.body_13,
                                              letterSpacing: 0.06.dp,
                                              fontFamily:
                                                  AppFont.xProductsanfont,
                                              fontWeight:
                                                  AppDimensions.fontBold,
                                              color:
                                                  AppColorConst.kappWhiteColor),
                                        ),
                                        Text(
                                          "TBGGFY94",
                                          style: TextStyle(
                                              fontSize: AppDimensions.body_13,
                                              letterSpacing: 0.06.dp,
                                              fontFamily:
                                                  AppFont.xProductsanfont,
                                              fontWeight:
                                                  AppDimensions.fontBold,
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
                      const SizedBox(width: AppDimensions.paddingLARGE),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.paddingEXTRASMALL),
            ]),
      ),
    );
  }
}
