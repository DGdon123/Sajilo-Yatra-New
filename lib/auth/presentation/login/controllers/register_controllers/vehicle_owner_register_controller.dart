import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sajilo_yatra/auth/data/models/register_models/vehicle_owner_register_response.dart';
import 'package:sajilo_yatra/auth/data/models/register_models/vehicle_owner_request_model.dart';
import 'package:sajilo_yatra/auth/data/repositories/auth_repository.dart';
import 'package:sajilo_yatra/auth/presentation/login/views/main_login_screen.dart';

import '../../../../../utils/custom_navigation/app_nav.dart';
import '../../../../../utils/custom_snack_bar/custom_snack_bar.dart';

class VehicleOwnerRegisterController
    extends StateNotifier<AsyncValue<VehicleOwnerRegisterResponseModel>> {
  final AuthRepo authRepository;
  VehicleOwnerRegisterController({required this.authRepository})
      : super(AsyncValue.loading());

  vregister(
      {required BuildContext context,
      required VehicleOwnerRegisterRequestModel
          vehicleOwnerRegisterRequestModel}) async {
    final result =
        await authRepository.vregisterrep(vehicleOwnerRegisterRequestModel);
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

final vehicleownerregisterControllerProvider = StateNotifierProvider<
    VehicleOwnerRegisterController,
    AsyncValue<VehicleOwnerRegisterResponseModel>>((ref) {
  return VehicleOwnerRegisterController(
      authRepository: ref.read(authRepositoryProvider));
});
