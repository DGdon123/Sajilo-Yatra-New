import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/auth/data/models/forget_password_models/vehicle_owner_forgot_password_response_model.dart';
import 'package:sajilo_yatra/auth/data/repositories/auth_repository.dart';

import '../../../../../utils/custom_navigation/app_nav.dart';
import '../../../../../utils/custom_snack_bar/custom_snack_bar.dart';
import '../../../../data/models/forget_password_models/vehicle_owner_forgot_password_request_model copy.dart';
import '../../views/vehicle_owners_forget_password/vehicle_owner_forget_password_token_screen.dart';

class VehicleOwnerForgetController
    extends StateNotifier<AsyncValue<VehicleOwnerForgotPasswordResponseModel>> {
  final AuthRepo authRepository;
  VehicleOwnerForgetController({required this.authRepository})
      : super(AsyncValue.loading());

  vehicle_forgot_password(
      {required BuildContext context,
      required VehicleOwnerForgotPasswordRequestModel
          vehicleforgotPasswordRequestModel}) async {
    final result =
        await authRepository.vforgotrep(vehicleforgotPasswordRequestModel);
    return result.fold((l) {
      showCustomSnackBar(l.message, context);
      state = AsyncValue.error(l, StackTrace.fromString(l.message));
    }, (r) async {
      state = AsyncValue.data(r);
      if (context.mounted) {
        pushAndRemoveUntil(context, Vehicle_Forgot_Password_Token());
      }
    });
  }
}

final vehicleforgetpasswordControllerProvider = StateNotifierProvider<
    VehicleOwnerForgetController,
    AsyncValue<VehicleOwnerForgotPasswordResponseModel>>((ref) {
  return VehicleOwnerForgetController(
      authRepository: ref.read(authRepositoryProvider));
});
