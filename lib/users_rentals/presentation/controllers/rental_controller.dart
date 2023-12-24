import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/auth/presentation/login/views/main_login_screen.dart';
import 'package:sajilo_yatra/users_rentals/data/models/rental_request_model.dart';
import 'package:sajilo_yatra/users_rentals/data/models/rental_response_model.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';

import '../../data/repositories/rental_repositories.dart';

class RentalController extends StateNotifier<AsyncValue<RentalResponseModel>> {
  final RentalRepo rentalRepo;

  RentalController({required this.rentalRepo})
      : super(const AsyncValue.loading());

  getRentalDetails(
      {required BuildContext context,
      required RentalRequestModel registerRequestModel}) async {
    final result = await rentalRepo.rrepo(registerRequestModel);
    return result.fold((l) {
      state = AsyncValue.error(l, StackTrace.fromString(l.message));
    }, (r) async {
      state = AsyncValue.data(r);
      if (context.mounted) {
        pushAndRemoveUntil(context, const LoginScreen());
      }
    });
  }
}

final rentalControllerProvider =
    StateNotifierProvider<RentalController, AsyncValue<RentalResponseModel>>(
        (ref) {
  return RentalController(rentalRepo: ref.read(rentalRepositoryProvider));
});
