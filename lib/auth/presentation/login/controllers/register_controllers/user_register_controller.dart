import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/auth/data/models/register_models/user_register_request_model.dart';
import 'package:sajilo_yatra/auth/data/models/register_models/user_register_response_model.dart';
import 'package:sajilo_yatra/auth/data/repositories/auth_repository.dart';
import 'package:sajilo_yatra/auth/presentation/login/views/main_login_screen.dart';

import '../../../../../utils/custom_navigation/app_nav.dart';
import '../../../../../utils/custom_snack_bar/custom_snack_bar.dart';

class RegisterController
    extends StateNotifier<AsyncValue<RegisterResponseModel>> {
  final AuthRepo authRepository;
  RegisterController({required this.authRepository})
      : super(AsyncValue.loading());

  register(
      {required BuildContext context,
      required RegisterRequestModel registerRequestModel}) async {
    final result = await authRepository.registerrep(registerRequestModel);
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

final registerControllerProvider = StateNotifierProvider<RegisterController,
    AsyncValue<RegisterResponseModel>>((ref) {
  return RegisterController(authRepository: ref.read(authRepositoryProvider));
});
