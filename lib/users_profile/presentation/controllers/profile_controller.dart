import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/users_profile/data/models/profile_params_model.dart';
import 'package:sajilo_yatra/users_profile/data/models/profile_response_model.dart';
import 'package:sajilo_yatra/users_profile/data/repositories/profile_repository.dart';

class ProfileController
    extends StateNotifier<AsyncValue<ProfileResponseModel>> {
  final ProfileRepository profileRepo;
  final ProfileParams profileModel;
  ProfileController({required this.profileModel, required this.profileRepo})
      : super(const AsyncValue.loading()) {
    getProfileDetials();
  }
  getProfileDetials() async {
    final result = await profileRepo.getUserInfo(profileModel);

    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final profileControllerProvider = StateNotifierProvider.family.autoDispose<
    ProfileController,
    AsyncValue<ProfileResponseModel>,
    ProfileParams>((ref, profileModel) {
  return ProfileController(
      profileRepo: ref.read(profileRepositoryProvider),
      profileModel: profileModel);
});
