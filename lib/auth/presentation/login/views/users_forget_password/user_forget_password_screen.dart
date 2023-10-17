import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/auth/data/models/forget_password_models/user_forgot_password_request_model.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:sajilo_yatra/utils/form_validation/form_validation_extension.dart';
import '../../../../../commons/custom_form.dart';
import '../../../../../const/app_colors_const.dart';
import '../../../../../const/app_const.dart';

import '../../../../../const/app_dimension.dart';
import '../../../../../const/app_fonts.dart';
import '../../controllers/forget_password_controllers/user_forget_password_controller.dart';
import '../../controllers/login_controllers/auth_state_helper.dart';
import '../main_login_screen.dart';

class Forgot_Password extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<Forgot_Password> {
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> forgotSignKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.clear();

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
            "Reset Password",
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
                    "Enter the email associated with your account \nand we'll send an email with instructions to \nreset your password.",
                    style: TextStyle(
                        height: 0.21.h,
                        fontSize: AppDimensions.body_14,
                        letterSpacing: 0.06.dp,
                        fontFamily: AppFont.jProductsanfont,
                        fontWeight: AppDimensions.fontNormal,
                        color: CupertinoColors.systemGrey),
                  ),
                  SizedBox(height: AppDimensions.paddingEXTRALARGE),
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
                                "Send Instructions",
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
