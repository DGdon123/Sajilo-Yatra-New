import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/auth/data/models/reset_password_models/user_reset_password_request.dart';
import 'package:sajilo_yatra/auth/data/repositories/auth_repository.dart';
import 'package:sajilo_yatra/auth/presentation/login/views/main_login_screen.dart';

import '../../../../../utils/custom_navigation/app_nav.dart';
import '../../../../../utils/custom_snack_bar/custom_snack_bar.dart';
import '../../../../data/models/reset_password_models/user_reset_password_response.dart';

class ResetController
    extends StateNotifier<AsyncValue<ResetPasswordResponseModel>> {
  final AuthRepo authRepository;
  ResetController({required this.authRepository}) : super(AsyncValue.loading());

  reset_password(
      {required BuildContext context,
      required ResetPasswordRequestModel resetPasswordRequestModel}) async {
    final result = await authRepository.resetrep(resetPasswordRequestModel);
    return result.fold((l) {
      showCustomSnackBar(l.message, context);
      state = AsyncValue.error(l, StackTrace.fromString(l.message));
    }, (r) async {
      state = AsyncValue.data(r);
      if (context.mounted) {
        pushAndRemoveUntil(context, LoginScreen());
      }
    });
  }
}

final resetpasswordControllerProvider = StateNotifierProvider<ResetController,
    AsyncValue<ResetPasswordResponseModel>>((ref) {
  return ResetController(authRepository: ref.read(authRepositoryProvider));
});
