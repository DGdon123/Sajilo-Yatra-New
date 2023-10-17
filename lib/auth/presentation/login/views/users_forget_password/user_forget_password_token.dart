import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/auth/presentation/login/views/users_forget_password/user_forget_password_screen.dart';
import 'package:sajilo_yatra/core/api_const/api_const.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';
import 'package:sajilo_yatra/utils/form_validation/form_validation_extension.dart';
import '../../../../../commons/custom_form.dart';
import '../../../../../commons/richtext_widget.dart';
import '../../../../../const/app_colors_const.dart';
import '../../../../../const/app_const.dart';
import '../../../../../const/app_dimension.dart';
import '../../../../../const/app_fonts.dart';
import '../../../../../const/app_images_const.dart';
import '../../controllers/login_controllers/auth_state_helper.dart';
import '../users_reset_password/user_reset_password_screen.dart';

class Forgot_Password_Token extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHelloState();
}

class _MyHelloState extends ConsumerState<Forgot_Password_Token> {
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
    ApiConst.email = emailController.text.toString();
    normalNav(context, Reset_Password());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: forgotSignKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15.25.h),
                  Image.asset(
                    AppImagesConst.appMail,
                    height: 12.54.h,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 6.4.h),
                  Text(
                    AppConst.kcheckMail,
                    style: TextStyle(
                        fontSize: AppDimensions.body_24,
                        fontFamily: AppFont.pProductsanfont,
                        fontWeight: AppDimensions.fontBold,
                        color: AppColorConst.kappsecondaryColorBlack),
                  ),
                  SizedBox(height: 2.4.h),
                  Text(
                    "We have sent a token to your email. \nPaste the token below :-",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 0.21.h,
                        fontSize: AppDimensions.body_16,
                        letterSpacing: 0.01.dp,
                        fontFamily: AppFont.kProductsanfont,
                        fontWeight: AppDimensions.fontMediumNormal,
                        color: CupertinoColors.systemGrey),
                  ),
                  SizedBox(height: AppDimensions.paddingEXTRALARGE),
                  Row(
                    children: [
                      SizedBox(width: AppDimensions.paddingLARGE),
                      Text(
                        AppConst.kToken,
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
                        prefixIcon: Icons.key,
                        lable: AppConst.kToken,
                        validator: (input) => input!.isTokenValidate(input),
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
                                "Post Token",
                                style: TextStyle(
                                    letterSpacing: 0.02.dp,
                                    fontFamily: AppFont.lProductsanfont,
                                    fontWeight: AppDimensions.fontMedium,
                                    color: AppColorConst.kappWhiteColor),
                              )),
                  ),
                  SizedBox(height: 12.8.h),
                  RichTextWidget(
                    onTap: () {
                      normalNav(context, Forgot_Password());
                    },
                    firstText:
                        'Did not receive the token? Check your spam \nfilter, or',
                    secondText: 'try another email address',
                  )
                ]),
          )),
    );
  }
}

final loginProvider = Provider<Forgot_Password_Token>((ref) {
  return Forgot_Password_Token();
});
