import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/users_edit%20profile/data/models/edit_profile_request_model.dart';
import 'package:sajilo_yatra/users_edit%20profile/data/models/edit_profile_response_model.dart';
import 'package:sajilo_yatra/users_profile/data/models/profile_params_model.dart';
import 'package:sajilo_yatra/users_profile/data/models/profile_response_model.dart';
import 'package:sajilo_yatra/users_profile/data/repositories/profile_repository.dart';

import '../../data/repositories/edit_profile_repository.dart';

class EditProfileController
    extends StateNotifier<AsyncValue<EditProfileResponseModel>> {
  final EDitProfileRepository profileRepo;
  final ProfileParams profileModel;
  EditProfileController({required this.profileModel, required this.profileRepo})
      : super(const AsyncValue.loading());
  getProfileDetials(EditProfileRequestModel free, BuildContext context) async {
    final result = await profileRepo.getUserInfo2(free, profileModel);
    return result.fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 500),
        content: Text(l.message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom == 0
                ? MediaQuery.of(context).size.height - 120
                : MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewInsets.bottom -
                    100,
            right: 20,
            left: 20),
      ));
    }, (r) async {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 500),
        content: const Text("Profile has been updated successfully"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom == 0
                ? MediaQuery.of(context).size.height - 120
                : MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewInsets.bottom -
                    100,
            right: 20,
            left: 20),
      ));
    });
  }
}

final editprofileControllerProvider = StateNotifierProvider.family.autoDispose<
    EditProfileController,
    AsyncValue<EditProfileResponseModel>,
    ProfileParams>((ref, profileModel) {
  return EditProfileController(
      profileRepo: ref.read(editprofileRepositoryProvider),
      profileModel: profileModel);
});
