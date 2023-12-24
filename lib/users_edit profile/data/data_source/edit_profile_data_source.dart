import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/core/api_client/api_client.dart';
import 'package:sajilo_yatra/core/api_const/api_const.dart';
import 'package:sajilo_yatra/users_edit%20profile/data/models/edit_profile_request_model.dart';
import 'package:sajilo_yatra/users_edit%20profile/data/models/edit_profile_response_model.dart';
import 'package:sajilo_yatra/users_profile/data/models/profile_params_model.dart';
import 'package:sajilo_yatra/users_profile/data/models/profile_response_model.dart';

abstract class EditProfileDataSource {
  Future<EditProfileResponseModel> loginRs(
      EditProfileRequestModel loginrequest, ProfileParams token);
}

class ProfileDataSourceImp implements EditProfileDataSource {
  final ApiClient apiClient;

  ProfileDataSourceImp(this.apiClient);

  @override
  Future<EditProfileResponseModel> loginRs(
      EditProfileRequestModel loginrequest, ProfileParams token) async {
    final response = await apiClient.request(
        type: "put",
        path: "${ApiConst.keditProfile}/${token.token}",
        data: loginrequest.toMap());

    return EditProfileResponseModel.fromMap(response["user"]);
  }
}

final editprofileDataProvider = Provider<EditProfileDataSource>((ref) {
  return ProfileDataSourceImp(ref.read(apiClientProvider));
});
