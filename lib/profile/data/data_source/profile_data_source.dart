import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/core/api_client/api_client.dart';
import 'package:sajilo_yatra/core/api_const/api_const.dart';
import 'package:sajilo_yatra/profile/data/models/profile_params_model.dart';
import 'package:sajilo_yatra/profile/data/models/profile_response_model.dart';

abstract class ProfileDataSource {
  Future<ProfileResponseModel> profiledata(ProfileParams hello);
}

class ProfileDataSourceImp implements ProfileDataSource {
  final ApiClient apiClient;

  ProfileDataSourceImp(this.apiClient);
  @override
  Future<ProfileResponseModel> profiledata(ProfileParams hello) async {
    final response =
        await apiClient.request(type: "get", path: ApiConst.kauthExpress);

    // Handle the response format
    final dynamic parsedResponse =
        json.decode(response); // Assuming the response is in JSON format

    return ProfileResponseModel.fromMap(parsedResponse);
  }
}

final profileDataProvider = Provider<ProfileDataSource>((ref) {
  return ProfileDataSourceImp(ref.read(apiClientProvider));
});
