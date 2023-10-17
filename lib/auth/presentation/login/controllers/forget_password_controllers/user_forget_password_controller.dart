import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/auth/data/models/forget_password_models/user_forgot_password_request_model.dart';
import 'package:sajilo_yatra/auth/data/models/forget_password_models/user_forgot_password_response_model.dart';
import 'package:sajilo_yatra/auth/data/repositories/auth_repository.dart';

import '../../../../../utils/custom_navigation/app_nav.dart';
import '../../../../../utils/custom_snack_bar/custom_snack_bar.dart';
import '../../views/users_forget_password/user_forget_password_token.dart';

class ForgetController
    extends StateNotifier<AsyncValue<ForgotPasswordResponseModel>> {
  final AuthRepo authRepository;
  ForgetController({required this.authRepository})
      : super(AsyncValue.loading());

  forgot_password(
      {required BuildContext context,
      required ForgotPasswordRequestModel forgotPasswordRequestModel}) async {
    final result = await authRepository.forgotrep(forgotPasswordRequestModel);
    return result.fold((l) {
      showCustomSnackBar(l.message, context);
      state = AsyncValue.error(l, StackTrace.fromString(l.message));
    }, (r) async {
      state = AsyncValue.data(r);
      if (context.mounted) {
        pushAndRemoveUntil(context, Forgot_Password_Token());
      }
    });
  }
}

final forgetpasswordControllerProvider = StateNotifierProvider<ForgetController,
    AsyncValue<ForgotPasswordResponseModel>>((ref) {
  return ForgetController(authRepository: ref.read(authRepositoryProvider));
});
