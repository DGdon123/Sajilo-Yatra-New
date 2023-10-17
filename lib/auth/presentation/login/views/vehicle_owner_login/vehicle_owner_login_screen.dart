import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/auth/presentation/login/views/vehicle_owners_forget_password/vehicle_owner_forget_password_screen.dart';
import 'package:sajilo_yatra/utils/form_validation/form_validation_extension.dart';

import '../../../../../commons/custom_form.dart';
import '../../../../../const/app_colors_const.dart';
import '../../../../../const/app_const.dart';
import '../../../../../const/app_dimension.dart';
import '../../../../../const/app_fonts.dart';
import '../../../../../utils/custom_navigation/app_nav.dart';
import '../../../../data/models/login_models/login_request_model.dart';

import '../../controllers/login_controllers/auth_state_helper.dart';
import '../../controllers/login_controllers/vehicle_owner_login_controller.dart';
import '../vehicle_owner_register/vehicle_owner_register.dart';

class VHome extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<VHome> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginSignKey = GlobalKey<FormState>();
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
    LoginRequestModel loginRequestModel = LoginRequestModel(
      email: emailController.text,
      password: passwordController.text,
    );
    if (loginSignKey.currentState!.validate()) {
      ref.read(loginloadingProvider.notifier).update((state) => true);
      await ref
          .read(vloginControllerProvider.notifier)
          .login(loginRequestModel, context);
    }

    ref.read(loginloadingProvider.notifier).update((state) => false);
    // normalNav(context, const AssignClassScreen());
  }

  @override
  Widget build(BuildContext context) {
    final passwordObcure = ref.watch(loginscreenPasswordObscureProvider);

    return Form(
      key: loginSignKey,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                        child: ref.watch(loginloadingProvider)
                            ? CircularProgressIndicator.adaptive(
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white, //<-- SEE HERE
                                ),
                                backgroundColor: AppColorConst.kappWhiteColor)
                            : Text(
                                AppConst.kLogin,
                                style: TextStyle(
                                    letterSpacing: 0.02.dp,
                                    fontFamily: AppFont.lProductsanfont,
                                    fontWeight: AppDimensions.fontMedium,
                                    color: AppColorConst.kappWhiteColor),
                              )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 16),
                          width: 23.w,
                          height: 0.05.h,
                          color: const Color(0xff2222222)),
                      TextButton(
                        onPressed: () {
                          normalNav(context, VehicleOwner_Forgot_Password());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 11),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              AppConst.kforgotPassword,
                              style: TextStyle(
                                  fontSize: 0.22.dp,
                                  fontFamily: AppFont.kProductsanfont,
                                  color: CupertinoColors.darkBackgroundGray),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 16),
                          width: 23.w,
                          height: 0.05.h,
                          color: const Color(0xff2222222)),
                    ],
                  ),
                  SizedBox(height: 5.7.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: AppDimensions.paddingEXTRALARGE),
                      Text(
                        "Not registered yet?",
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
                                  {normalNav(context, VRegister())},
                              child: Text(
                                "Create an Account",
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
                    ],
                  ),
                ]),
          )),
    );
  }
}
