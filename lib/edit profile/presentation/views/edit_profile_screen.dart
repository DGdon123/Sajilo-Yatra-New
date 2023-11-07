import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/commons/custom_form.dart';
import 'package:sajilo_yatra/commons/custom_primary_button.dart';
import 'package:sajilo_yatra/commons/custom_secondary_button.dart';
import 'package:sajilo_yatra/commons/custom_third_button.dart';
import 'package:sajilo_yatra/const/app_colors_const.dart';
import 'package:sajilo_yatra/const/app_const.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';
import 'package:sajilo_yatra/const/app_fonts.dart';
import 'package:sajilo_yatra/const/app_images_const.dart';
import 'package:sajilo_yatra/edit%20profile/data/models/edit_profile_request_model.dart';
import 'package:sajilo_yatra/help/help.dart';
import 'package:sajilo_yatra/offers/offers.dart';
import 'package:sajilo_yatra/profile/data/models/profile_params_model.dart';
import 'package:sajilo_yatra/profile/presentation/controllers/profile_controller.dart';
import 'package:sajilo_yatra/profile/presentation/views/profile_screen.dart';
import 'package:sajilo_yatra/utils/bottom_bar/bottom_bar.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:sajilo_yatra/utils/form_validation/form_validation_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loader_skeleton/loader_skeleton.dart';
import 'package:logger/logger.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

import '../../data/repositories/edit_profile_repository.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<EditProfile> {
  String token = "";
  final GlobalKey<FormState> registerSignKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String? dob;
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

  appLogin() async {
    if (registerSignKey.currentState!.validate()) {
      await ref.read(editprofileRepositoryProvider).getUserInfo2(
          EditProfileRequestModel(
            email: email.text,
            name: name.text,
            dob: dobController.text,
            location: location.text,
            phoneNumber: phone.text,
          ),
          ProfileParams(token: token));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 1000),
        content: const Text("Profile has been updated successfully"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom == 0
                ? MediaQuery.of(context).size.height + 120
                : MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewInsets.bottom -
                    100,
            right: 20,
            left: 20),
      ));
      pushAndRemoveUntil(context, const Profile());
    }
  }

  @override
  Widget build(BuildContext context) {
    final assingedClass =
        ref.watch(profileControllerProvider(ProfileParams(token: token)));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppConst.kEditProfile,
          style: TextStyle(
              fontSize: AppDimensions.body_16,
              letterSpacing: 0.06.dp,
              fontFamily: AppFont.kProductsanfont,
              fontWeight: AppDimensions.fontMedium,
              color: AppColorConst.kappWhiteColor),
        ),
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
        backgroundColor: AppColorConst.kappprimaryColorRed,
      ),
      body: assingedClass.when(
          data: (data) {
            return Form(
              key: registerSignKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 35),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              maxRadius: 60,
                              child: Image.asset(
                                AppImagesConst.appCar,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 85),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColorConst
                                      .kappWhiteColor, // Set the border color here
                                  width: 4, // Set the border width here
                                ),
                              ),
                              child: const CircleAvatar(
                                backgroundColor:
                                    CupertinoColors.lightBackgroundGray,
                                child: Icon(
                                  CupertinoIcons
                                      .photo_fill, // Replace with the desired icon
                                  size:
                                      20, // Adjust the size of the icon as needed
                                  color: Colors
                                      .white, // Adjust the icon color as needed
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "YOUR NAME",
                            style: TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: AppDimensions.body_13,
                                fontFamily: AppFont.kProductsanfont),
                          ),
                          TextFormField(
                            validator: (input) => input!.isValidName(input),
                            cursorColor: AppColorConst.kappscafoldbggrey,
                            keyboardType: TextInputType.visiblePassword,
                            controller: name,
                            decoration: InputDecoration(
                              hintText: data.name,
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppDimensions.paddingEXTRALARGE,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "YOUR EMAIL",
                            style: TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: AppDimensions.body_13,
                                fontFamily: AppFont.kProductsanfont),
                          ),
                          TextFormField(
                            validator: (input) => input!.isValidEmail(input),
                            cursorColor: AppColorConst.kappscafoldbggrey,
                            keyboardType: TextInputType.visiblePassword,
                            controller: email,
                            decoration: InputDecoration(
                              hintText: data.email,
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppDimensions.paddingEXTRALARGE,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "YOUR PHONE NUMBER",
                            style: TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: AppDimensions.body_13,
                                fontFamily: AppFont.kProductsanfont),
                          ),
                          TextFormField(
                            validator: (input) => input!.isPhoneValidate(input),
                            controller: phone,
                            cursorColor: AppColorConst.kappscafoldbggrey,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: data.phone,
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppDimensions.paddingEXTRALARGE,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "YOUR LOCATION",
                            style: TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: AppDimensions.body_13,
                                fontFamily: AppFont.kProductsanfont),
                          ),
                          TextFormField(
                            controller: location,
                            validator: (input) => input!.isAddressValid(input),
                            cursorColor: AppColorConst.kappscafoldbggrey,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              hintText: data.location,
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppDimensions.paddingEXTRALARGE,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "YOUR DATE OF BIRTH",
                            style: TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: AppDimensions.body_13,
                                fontFamily: AppFont.kProductsanfont),
                          ),
                          TextFormField(
                            validator: (input) => input!.isDOBValidate(input),
                            readOnly: true,
                            controller: dobController,
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              final DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      // Change the colors here
                                      primaryColor: AppColorConst
                                          .kappprimaryColorRed, // Header background color

                                      colorScheme: const ColorScheme.light(
                                        primary: AppColorConst
                                            .kappprimaryColorRed, // Selected day background color
                                        onPrimary: Colors
                                            .white, // Selected day text color
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (date != null) {
                                dobController.text =
                                    DateFormat("yyyy-MM-dd").format(date);
                                dob = date.toString();
                              }
                            },
                            cursorColor: AppColorConst.kappscafoldbggrey,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              hintText: data.dob,
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.1,
                                      color: AppColorConst.kappscafoldbggrey,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomSecondaryButton(
                          text: "CANCEL",
                          onPressed: () {
                            dobController.clear();
                            name.clear();
                            email.clear();
                            phone.clear();
                            location.clear();
                          },
                        ),
                        const SizedBox(
                          width: AppDimensions.paddingEXTRALARGE,
                        ),
                        CustomThirdButton(
                          text: "SAVE",
                          onPressed: () {
                            appLogin();
                          },
                          gradient: AppColorConst.kappprimaryColorRed,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppDimensions.paddingEXTRALARGE,
                    ),
                  ],
                ),
              ),
            );
          },
          error: (er, s) => Text(er.toString()),
          loading: () => Center(
                  child: CardProfileSkeleton(
                isCircularImage: true,
                isBottomLinesActive: false,
              ))),
    );
  }
}
