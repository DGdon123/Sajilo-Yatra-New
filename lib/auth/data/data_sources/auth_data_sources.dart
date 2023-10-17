import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/auth/data/models/forget_password_models/user_forgot_password_request_model.dart';
import 'package:sajilo_yatra/auth/data/models/forget_password_models/user_forgot_password_response_model.dart';
import 'package:sajilo_yatra/auth/data/models/forget_password_models/vehicle_owner_forgot_password_request_model%20copy.dart';
import 'package:sajilo_yatra/auth/data/models/register_models/vehicle_owner_register_response.dart';
import 'package:sajilo_yatra/auth/data/models/reset_password_models/user_reset_password_request.dart';
import 'package:sajilo_yatra/auth/data/models/reset_password_models/user_reset_password_response.dart';

import 'package:sajilo_yatra/core/api_client/api_client.dart';

import '../../../core/api_const/api_const.dart';
import '../models/forget_password_models/vehicle_owner_forgot_password_response_model.dart';
import '../models/login_models/express_model.dart';
import '../models/login_models/login_error_model.dart';
import '../models/login_models/login_request_model.dart';
import '../models/login_models/login_response_model.dart';
import '../models/register_models/user_register_request_model.dart';
import '../models/register_models/user_register_response_model.dart';
import '../models/register_models/vehicle_owner_request_model.dart';
import '../models/reset_password_models/vehicle_owner_reset_password_request.dart';
import '../models/reset_password_models/vehicle_owner_reset_password_response.dart';

abstract class AuthDataSources {
  Future<LoginResponseModel> loginRs(LoginRequestModel loginrequest);
  Future<RegisterResponseModel> registerRs(
      RegisterRequestModel registerrequest);
  Future<LoginErrorModel> error();
  Future<LoginResponseModel> vloginRs(LoginRequestModel loginrequest);
  Future<ForgotPasswordResponseModel> forgot(
      ForgotPasswordRequestModel forgotrequest);
  Future<VehicleOwnerForgotPasswordResponseModel> vforgot(
      VehicleOwnerForgotPasswordRequestModel vforgotrequest);
  Future<ResetPasswordResponseModel> reset(
      ResetPasswordRequestModel resetrequest);
  Future<VehicleOwnerResetPasswordResponseModel> vreset(
      VehicleOwnerResetPasswordRequestModel vresetrequest);

  Future<Express> hello();
  Future<VehicleOwnerRegisterResponseModel> vregister(
      VehicleOwnerRegisterRequestModel vehicleregisterrequest);
}

class AuthImpl implements AuthDataSources {
  final ApiClient apiClient;

  AuthImpl(this.apiClient);

  @override
  Future<LoginResponseModel> loginRs(LoginRequestModel loginrequest) async {
    final response = await apiClient.request(
        type: "post", path: ApiConst.kauthSignIn, data: loginrequest.toMap());

    return LoginResponseModel.fromMap(response["user"]);
  }

  @override
  Future<Express> hello() async {
    final response =
        await apiClient.request(type: "get", path: ApiConst.kauthExpress);

    // Handle the response format
    final dynamic parsedResponse =
        json.decode(response); // Assuming the response is in JSON format

    return Express.fromMap(parsedResponse);
  }

  @override
  Future<LoginResponseModel> vloginRs(LoginRequestModel loginrequest) async {
    final response = await apiClient.request(
        type: "post", path: ApiConst.kauthVSignin, data: loginrequest.toMap());

    return LoginResponseModel.fromMap(response["vehicle_owner"]);
  }

  @override
  Future<LoginErrorModel> error() async {
    final response =
        await apiClient.request(type: "post", path: ApiConst.kauthVSignin);

    return LoginErrorModel.fromMap(response["message"]);
  }

  @override
  Future<RegisterResponseModel> registerRs(
      RegisterRequestModel registerrequest) async {
    final response = await apiClient.request(
        type: "post",
        path: ApiConst.kauthRegister,
        data: registerrequest.toMap());

    return RegisterResponseModel.fromMap(response["user"]);
  }

  @override
  Future<VehicleOwnerRegisterResponseModel> vregister(
      VehicleOwnerRegisterRequestModel vehicleregisterrequest) async {
    final response = await apiClient.request(
        type: "post",
        path: ApiConst.kauthVRegister,
        data: vehicleregisterrequest.toMap());

    return VehicleOwnerRegisterResponseModel.fromMap(response["vehicle_owner"]);
  }

  @override
  Future<ForgotPasswordResponseModel> forgot(
      ForgotPasswordRequestModel forgotrequest) async {
    final response = await apiClient.request(
        type: "post",
        path: ApiConst.kforgetPassword,
        data: forgotrequest.toMap());

    return ForgotPasswordResponseModel.fromMap(response);
  }

  @override
  Future<ResetPasswordResponseModel> reset(
      ResetPasswordRequestModel resetrequest) async {
    final response = await apiClient.request(
        type: "put",
        path: "${ApiConst.kauthResetPassword}/${ApiConst.email}",
        data: resetrequest.toMap());

    return ResetPasswordResponseModel.fromMap(response);
  }

  @override
  Future<VehicleOwnerForgotPasswordResponseModel> vforgot(
      VehicleOwnerForgotPasswordRequestModel vforgotrequest) async {
    final response = await apiClient.request(
        type: "post",
        path: ApiConst.kvehicleforgetPassword,
        data: vforgotrequest.toMap());

    return VehicleOwnerForgotPasswordResponseModel.fromMap(response);
  }

  @override
  Future<VehicleOwnerResetPasswordResponseModel> vreset(
      VehicleOwnerResetPasswordRequestModel vresetrequest) async {
    final response = await apiClient.request(
        type: "put",
        path: "${ApiConst.kvehicleResetPassword}/${ApiConst.vehicle_email}",
        data: vresetrequest.toMap());

    return VehicleOwnerResetPasswordResponseModel.fromMap(response);
  }
}

final loginProvider = Provider<AuthDataSources>((ref) {
  return AuthImpl(ref.read(apiClientProvider));
});
