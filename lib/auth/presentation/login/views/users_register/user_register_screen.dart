import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/auth/data/models/register_models/user_register_request_model.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:sajilo_yatra/utils/form_validation/form_validation_extension.dart';
import 'package:intl/intl.dart';
import '../../../../../commons/custom_form.dart';
import '../../../../../const/app_colors_const.dart';
import '../../../../../const/app_const.dart';

import '../../../../../const/app_dimension.dart';
import '../../../../../const/app_fonts.dart';
import '../../controllers/login_controllers/auth_state_helper.dart';
import '../../controllers/register_controllers/user_register_controller.dart';
import '../main_login_screen.dart';

class Register extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  String? dob;
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final GlobalKey<FormState> registerSignKey = GlobalKey<FormState>();
  String dropdownvalue = 'Male';
  int age = 0;

  // List of items in our dropdown menu
  var items = ['Male', 'Female', 'Others'];
  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    genderController.clear();
    ageController.clear();
    phoneNumberController.clear();
    locationController.clear();
    dobController.clear();
    super.dispose();
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
    RegisterRequestModel registerRequestModel = RegisterRequestModel(
      email: emailController.text,
      password: passwordController.text,
      age: age,
      dob: dobController.text,
      gender: genderController.text,
      location: locationController.text,
      name: nameController.text,
      phoneNumber: phoneNumberController.text,
    );
    if (registerSignKey.currentState!.validate()) {
      ref.read(loginSignUPloadingProvider.notifier).update((state) => true);
      await ref.read(registerControllerProvider.notifier).register(
          context: context, registerRequestModel: registerRequestModel);
    }

    ref.read(loginSignUPloadingProvider.notifier).update((state) => false);
  }

  @override
  Widget build(BuildContext context) {
    final passwordObcure = ref.watch(loginscreenPasswordObscureProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            kToolbarHeight + 1), // Set the preferred height of the AppBar
        child: AppBar(
          backgroundColor: AppColorConst.kappWhiteColor,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: AppColorConst.kappprimaryColorRed,
                onPressed: () {
                  pushAndRemoveUntil(context, LoginScreen());
                },
              );
            },
          ),
          title: Text(
            "Create Account",
            style: TextStyle(
                fontSize: AppDimensions.body_16,
                letterSpacing: 0.06.dp,
                fontFamily: AppFont.kProductsanfont,
                fontWeight: AppDimensions.fontMedium,
                color: AppColorConst.kappsecondaryColorBlack),
          ),
          centerTitle: true,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(1.0), // Set the height of the underline
            child: Container(
              decoration: BoxDecoration(
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
      ),
      backgroundColor: Colors.white,
      body: Form(
          key: registerSignKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      SizedBox(width: AppDimensions.paddingLARGE),
                      Text(
                        AppConst.kfullName,
                        style: TextStyle(
                            fontSize: AppDimensions.body_16,
                            letterSpacing: 0.06.dp,
                            fontFamily: AppFont.kProductsanfont,
                            fontWeight: AppDimensions.fontMedium,
                            color: AppColorConst.kappprimaryColorRed),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingEXTRASMALL),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomAppForm(isSuffixIconrequired: false,
                        readOnly: false,
                        textEditingController: nameController,
                        isPrefixIconrequired: true,
                        prefixIcon: CupertinoIcons.pencil_outline,
                        lable: AppConst.kfullName,
                        validator: (input) => input!.isValidName(input),
                      ),
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingSMALL),
                  Row(
                    children: [
                      SizedBox(width: AppDimensions.paddingLARGE),
                      Text(
                        AppConst.kemail,
                        style: TextStyle(
                            fontSize: AppDimensions.body_16,
                            letterSpacing: 0.06.dp,
                            fontFamily: AppFont.kProductsanfont,
                            fontWeight: AppDimensions.fontMedium,
                            color: AppColorConst.kappprimaryColorRed),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingEXTRASMALL),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomAppForm(isSuffixIconrequired: false,
                        readOnly: false,
                        textEditingController: emailController,
                        isPrefixIconrequired: true,
                        prefixIcon: CupertinoIcons.envelope,
                        lable: AppConst.kemail,
                        validator: (input) => input!.isValidEmail(input),
                      ),
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingSMALL),
                  Row(
                    children: [
                      SizedBox(width: AppDimensions.paddingLARGE),
                      Text(
                        AppConst.kpassword,
                        style: TextStyle(
                            fontSize: AppDimensions.body_16,
                            letterSpacing: 0.06.dp,
                            fontFamily: AppFont.kProductsanfont,
                            fontWeight: AppDimensions.fontMedium,
                            color: AppColorConst.kappprimaryColorRed),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingEXTRASMALL),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: CustomAppForm(isSuffixIconrequired: false,
                      readOnly: false,
                      obscureText: passwordObcure,
                      textEditingController: passwordController,
                      isPrefixIconrequired: true,
                      prefixIcon: CupertinoIcons.lock,
                      lable: AppConst.kpassword,
                      sufixWidget: IconButton(
                          onPressed: toogleObcure,
                          icon: Icon(passwordObcure
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye)),
                      textInputAction: TextInputAction.done,
                      validator: (input) => input!.isPasswordValid(input),
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingSMALL),
                  Row(
                    children: [
                      SizedBox(width: AppDimensions.paddingLARGE),
                      Text(
                        AppConst.kgender,
                        style: TextStyle(
                            fontSize: AppDimensions.body_16,
                            letterSpacing: 0.06.dp,
                            fontFamily: AppFont.kProductsanfont,
                            fontWeight: AppDimensions.fontMedium,
                            color: AppColorConst.kappprimaryColorRed),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingEXTRASMALL),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomAppForm(isSuffixIconrequired: false,
                        textEditingController: genderController,
                        isPrefixIconrequired: true,
                        readOnly: true,
                        prefixIcon: CupertinoIcons.person_3,
                        lable: "Select Gender",
                        validator: (input) => input!.isGenderValidate(input),
                        onTap: () async {
                          final selectedGender = await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Select Gender'),
                                titleTextStyle: TextStyle(
                                    fontSize: AppDimensions.body_16,
                                    letterSpacing: 0.06.dp,
                                    fontFamily: AppFont.kProductsanfont,
                                    fontWeight: AppDimensions.fontMedium,
                                    color: AppColorConst.kappprimaryColorRed),
                                content: Container(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: DropdownButtonFormField<String>(
                                    value: dropdownvalue,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                        genderController.text = newValue;
                                      });
                                      Navigator.of(context).pop(newValue);
                                    },
                                    items: items.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left:
                                                  6), // Add left padding for "Male" option
                                          child: Text(item),
                                        ),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide: BorderSide(
                                          color: AppColorConst
                                              .kappprimaryColorRed, // Change the underline color here
                                          width: 2.4,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide: BorderSide(
                                          color: AppColorConst
                                              .kappprimaryColorRed, // Change the underline color here
                                          width: 2.4,
                                        ),
                                      ),
                                    ),
                                    selectedItemBuilder:
                                        (BuildContext context) {
                                      return items.map<Widget>((String item) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left:
                                                  6), // Add left padding for selected item
                                          child: Text(item),
                                        );
                                      }).toList();
                                    },
                                    dropdownColor:
                                        Color.fromARGB(255, 255, 255, 255),
                                    icon: const Icon(Icons
                                        .arrow_drop_down), // Custom icon for the dropdown
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              );
                            },
                          );

                          if (selectedGender != null) {
                            setState(() {
                              genderController.text = selectedGender;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingSMALL),
                  Row(
                    children: [
                      SizedBox(width: AppDimensions.paddingLARGE),
                      Text(
                        AppConst.kappBarAge,
                        style: TextStyle(
                            fontSize: AppDimensions.body_16,
                            letterSpacing: 0.06.dp,
                            fontFamily: AppFont.kProductsanfont,
                            fontWeight: AppDimensions.fontMedium,
                            color: AppColorConst.kappprimaryColorRed),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingEXTRASMALL),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomAppForm(isSuffixIconrequired: false,
                        readOnly: false,
                        textEditingController: ageController,
                        keyboardType: TextInputType.number,
                        isPrefixIconrequired: true,
                        prefixIcon: CupertinoIcons.person,
                        lable: AppConst.kappBarAge,
                        onChanged: (p0) {
                          age = int.parse(p0);
                        },
                        validator: (input) => input!.isAgeValidate(input),
                      ),
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingSMALL),
                  Row(
                    children: [
                      SizedBox(width: AppDimensions.paddingLARGE),
                      Text(
                        AppConst.kphoneNumber,
                        style: TextStyle(
                            fontSize: AppDimensions.body_16,
                            letterSpacing: 0.06.dp,
                            fontFamily: AppFont.kProductsanfont,
                            fontWeight: AppDimensions.fontMedium,
                            color: AppColorConst.kappprimaryColorRed),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingEXTRASMALL),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomAppForm(isSuffixIconrequired: false,
                        readOnly: false,
                        keyboardType: TextInputType.number,
                        textEditingController: phoneNumberController,
                        isPrefixIconrequired: true,
                        prefixIcon: CupertinoIcons.phone,
                        lable: AppConst.kphoneNumber,
                        validator: (input) => input!.isPhoneValidate(input),
                      ),
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingSMALL),
                  Row(
                    children: [
                      SizedBox(width: AppDimensions.paddingLARGE),
                      Text(
                        AppConst.kappBarLocation,
                        style: TextStyle(
                            fontSize: AppDimensions.body_16,
                            letterSpacing: 0.06.dp,
                            fontFamily: AppFont.kProductsanfont,
                            fontWeight: AppDimensions.fontMedium,
                            color: AppColorConst.kappprimaryColorRed),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingEXTRASMALL),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomAppForm(isSuffixIconrequired: false,
                        readOnly: false,
                        textEditingController: locationController,
                        isPrefixIconrequired: true,
                        prefixIcon: CupertinoIcons.location,
                        lable: AppConst.kappBarLocation,
                        validator: (input) => input!.isAddressValid(input),
                      ),
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingSMALL),
                  Row(
                    children: [
                      SizedBox(width: AppDimensions.paddingLARGE),
                      Text(
                        AppConst.kappBarDOB,
                        style: TextStyle(
                            fontSize: AppDimensions.body_16,
                            letterSpacing: 0.06.dp,
                            fontFamily: AppFont.kProductsanfont,
                            fontWeight: AppDimensions.fontMedium,
                            color: AppColorConst.kappprimaryColorRed),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingEXTRASMALL),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomAppForm(isSuffixIconrequired: false,
                        readOnly: true,
                        textEditingController: dobController,
                        isPrefixIconrequired: true,
                        prefixIcon: CupertinoIcons.calendar,
                        lable: AppConst.kappBarDOB,
                        validator: (input) => input!.isDOBValidate(input),
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

                                  colorScheme: ColorScheme.light(
                                    primary: AppColorConst
                                        .kappprimaryColorRed, // Selected day background color
                                    onPrimary:
                                        Colors.white, // Selected day text color
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
                      ),
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingLARGE),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: ContinuousRectangleBorder(
                                side: const BorderSide(
                                  width: 0.8,
                                  color: AppColorConst.kappprimaryColorRed,
                                ),
                                borderRadius: BorderRadius.circular(22)),
                            backgroundColor: AppColorConst.kappprimaryColorRed,
                            elevation: 0,
                            fixedSize: Size(86.w, 7.h)),
                        onPressed: () => appLogin(),
                        child: ref.watch(loginSignUPloadingProvider)
                            ? CircularProgressIndicator.adaptive(
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white, //<-- SEE HERE
                                ),
                                backgroundColor: AppColorConst.kappWhiteColor)
                            : Text(
                                "Create Account",
                                style: TextStyle(
                                    letterSpacing: 0.02.dp,
                                    fontFamily: AppFont.lProductsanfont,
                                    fontWeight: AppDimensions.fontMedium,
                                    color: AppColorConst.kappWhiteColor),
                              )),
                  ),
                  SizedBox(height: 1.7.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: AppDimensions.paddingEXTRALARGE),
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontSize: 0.222.dp,
                            letterSpacing: 0.05.dp,
                            fontWeight: AppDimensions.fontNormal,
                            fontFamily: AppFont.kProductsanfont,
                            color: AppColorConst.kappprimaryColorRed),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () =>
                                  {normalNav(context, LoginScreen())},
                              child: Text(
                                "Join Now",
                                style: TextStyle(
                                    fontSize: 0.222.dp,
                                    letterSpacing: 0.05.dp,
                                    fontWeight: AppDimensions.fontMediumNormal,
                                    fontFamily: AppFont.kProductsanfont,
                                    color:
                                        AppColorConst.kappsecondaryColorBlack),
                              ),
                            ),
                            SizedBox(width: AppDimensions.paddingDEFAULT),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.7.h),
                    ],
                  ),
                ]),
          )),
    );
  }
}
