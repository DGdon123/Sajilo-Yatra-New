import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/auth/data/models/reset_password_models/vehicle_owner_reset_password_request.dart';
import 'package:sajilo_yatra/auth/data/repositories/auth_repository.dart';
import 'package:sajilo_yatra/auth/presentation/login/views/main_login_screen.dart';

import '../../../../../utils/custom_navigation/app_nav.dart';
import '../../../../../utils/custom_snack_bar/custom_snack_bar.dart';
import '../../../../data/models/reset_password_models/vehicle_owner_reset_password_response.dart';

class VehicleResetController
    extends StateNotifier<AsyncValue<VehicleOwnerResetPasswordResponseModel>> {
  final AuthRepo authRepository;
  VehicleResetController({required this.authRepository})
      : super(AsyncValue.loading());

  vehicle_reset_password(
      {required BuildContext context,
      required VehicleOwnerResetPasswordRequestModel
          vresetPasswordRequestModel}) async {
    final result = await authRepository.vresetrep(vresetPasswordRequestModel);
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

final vehicleresetpasswordControllerProvider = StateNotifierProvider<
    VehicleResetController,
    AsyncValue<VehicleOwnerResetPasswordResponseModel>>((ref) {
  return VehicleResetController(
      authRepository: ref.read(authRepositoryProvider));
});
