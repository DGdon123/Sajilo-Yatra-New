import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/utils/form_validation/form_validation_extension.dart';
import '../../../../../commons/custom_form.dart';
import '../../../../../const/app_colors_const.dart';
import '../../../../../const/app_const.dart';

import '../../../../../const/app_dimension.dart';
import '../../../../../const/app_fonts.dart';
import '../../../../data/models/reset_password_models/vehicle_owner_reset_password_request.dart';
import '../../controllers/login_controllers/auth_state_helper.dart';
import '../../controllers/reset_password_controllers/vehicle_owner_reset_password_controller.dart';

class VehicleOwner_Reset_Password extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<VehicleOwner_Reset_Password> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> forgotSignKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
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
    VehicleOwnerResetPasswordRequestModel vresetPasswordRequestModel =
        VehicleOwnerResetPasswordRequestModel(
            password: passwordController.text);
    if (forgotSignKey.currentState!.validate()) {
      ref.read(resetpasswordloadingProvider.notifier).update((state) => true);
      await ref
          .read(vehicleresetpasswordControllerProvider.notifier)
          .vehicle_reset_password(
              context: context,
              vresetPasswordRequestModel: vresetPasswordRequestModel);
    }

    ref.read(resetpasswordloadingProvider.notifier).update((state) => false);
    // normalNav(context, const AssignClassScreen());
  }

  String? confirm(String? value) {
    if (value != emailController.text) {
      return 'Password does not match';
    }
    if (value!.isEmpty) {
      return 'Password field cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*()]'))) {
      return 'Password must contain at least one special character (!@#%^&*())';
    }
    // Add any additional password validation logic here
    return null;
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
                  Navigator.pop(context);
                },
              );
            },
          ),
          title: Text(
            "Create new Password",
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
          key: forgotSignKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 3.2.h),
                  Text(
                    "Your new password must be different \nfrom previous used passwords.",
                    style: TextStyle(
                        height: 0.21.h,
                        fontSize: AppDimensions.body_16,
                        letterSpacing: 0.06.dp,
                        fontFamily: AppFont.lProductsanfont,
                        fontWeight: AppDimensions.fontNormal,
                        color: CupertinoColors.systemGrey),
                  ),
                  SizedBox(height: AppDimensions.paddingEXTRALARGE),
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomAppForm(isSuffixIconrequired: false,
                        readOnly: false,
                        obscureText: passwordObcure,
                        textEditingController: emailController,
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
                  ),
                  SizedBox(height: AppDimensions.paddingSMALL),
                  Row(
                    children: [
                      SizedBox(width: AppDimensions.paddingLARGE),
                      Text(
                        AppConst.kcofirmPassword,
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
                        validator: confirm,
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
                                "Reset Password",
                                style: TextStyle(
                                    letterSpacing: 0.02.dp,
                                    fontFamily: AppFont.lProductsanfont,
                                    fontWeight: AppDimensions.fontMedium,
                                    color: AppColorConst.kappWhiteColor),
                              )),
                  ),
                ]),
          )),
    );
  }
}
