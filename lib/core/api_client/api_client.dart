import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/core/api_exception/dio_exception.dart';

import '../../auth/data/models/login_models/login_response_model.dart';

import '../api_const/api_const.dart';
import '../db_client/db_client.dart';

class ApiClient {
  final DbClient _dbClient;
  ApiClient(this._dbClient);
  Future request({
    required String path,
    String type = "get",
    Map<String, dynamic> data = const {},
  }) async {
    final String dbResult = await _dbClient.getData(dbKey: "token");
    String token = "";
    if (dbResult.isNotEmpty) {
      // var loginData = LoginResponseModel.fromJson(dbResult);
      // token = loginData.token;
      final LoginResponseModel loginResponseModel =
          LoginResponseModel.fromJson(dbResult);
      token = loginResponseModel.token;
    }

    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          "Accept": 'application/json',
          "Authorization": "Bearer ${token}"
        },
      ),
    );
    try {
      final result = type == "get"
          ? await dio.get(path)
          : type == "post"
              ? await dio.post(path, data: data)
              : await dio.put(path, data: data);
      return result.data;
    } on DioException catch (e) {
      throw DioException1.fromDioError(e);
    }
  }

  Future requestFormData(
      {required String path, required FormData formData}) async {
    final String dbResult = await _dbClient.getData(dbKey: "token");
    String token = "";
    if (dbResult.isNotEmpty) {
      var loginData = LoginResponseModel.fromJson(dbResult);
      token = loginData.token;
      // final LoginResponseModel loginResponseModel =
      //     LoginResponseModel.fromJson(dbResult);
      // token = loginResponseModel.token;
    }

    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          "Accept": 'application/json',
          "Authorization": "Bearer ${token}"
        },
      ),
    );
    try {
      final result = await dio.post(path, data: formData);
      log("formdata${formData.fields}");
      return result.data;
    } on DioException catch (e) {
      throw DioException1.fromDioError(e);
    }
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.read(dbClientProvider));
});
