import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dartz/dartz.dart';
import 'package:sajilo_yatra/auth/data/models/forget_password_models/user_forgot_password_request_model.dart';
import 'package:sajilo_yatra/auth/data/models/forget_password_models/user_forgot_password_response_model.dart';
import 'package:sajilo_yatra/auth/data/models/register_models/vehicle_owner_register_response.dart';
import 'package:sajilo_yatra/auth/data/models/register_models/vehicle_owner_request_model.dart';
import 'package:sajilo_yatra/auth/data/models/reset_password_models/user_reset_password_request.dart';
import 'package:sajilo_yatra/auth/data/models/reset_password_models/user_reset_password_response.dart';
import 'package:sajilo_yatra/core/api_exception/dio_exception.dart';

import '../../../core/app_error/app_error.dart';
import '../data_sources/auth_data_sources.dart';
import '../models/forget_password_models/vehicle_owner_forgot_password_request_model copy.dart';
import '../models/forget_password_models/vehicle_owner_forgot_password_response_model.dart';
import '../models/login_models/login_error_model.dart';
import '../models/login_models/login_request_model.dart';
import '../models/login_models/login_response_model.dart';
import '../models/register_models/user_register_request_model.dart';
import '../models/register_models/user_register_response_model.dart';
import '../models/reset_password_models/vehicle_owner_reset_password_request.dart';
import '../models/reset_password_models/vehicle_owner_reset_password_response.dart';

abstract class AuthRepo {
  Future<Either<AppError, LoginResponseModel>> loginrep(
      LoginRequestModel loginreq);
  Future<Either<AppError, RegisterResponseModel>> registerrep(
      RegisterRequestModel registerreq);
  Future<Either<AppError, ForgotPasswordResponseModel>> forgotrep(
      ForgotPasswordRequestModel forgetreq);
  Future<Either<AppError, VehicleOwnerForgotPasswordResponseModel>> vforgotrep(
      VehicleOwnerForgotPasswordRequestModel veforgetreq);
  Future<Either<AppError, VehicleOwnerRegisterResponseModel>> vregisterrep(
      VehicleOwnerRegisterRequestModel vregisterreq);
  Future<Either<AppError, ResetPasswordResponseModel>> resetrep(
      ResetPasswordRequestModel resetreq);
  Future<Either<AppError, VehicleOwnerResetPasswordResponseModel>> vresetrep(
      VehicleOwnerResetPasswordRequestModel vresetreq);
  Future<Either<AppError, LoginErrorModel>> errorRep();
  Future<Either<AppError, LoginResponseModel>> vloginrep(
      LoginRequestModel vloginreq);
}

class AuthRepoImp implements AuthRepo {
  final AuthDataSources helloworld;

  AuthRepoImp(this.helloworld);

  @override
  Future<Either<AppError, LoginResponseModel>> loginrep(
      LoginRequestModel loginreq) async {
    try {
      final tempo = await helloworld.loginRs(loginreq);
      return Right(tempo);
    } on DioException1 catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, LoginResponseModel>> vloginrep(
      LoginRequestModel vloginreq) async {
    try {
      final tempo = await helloworld.vloginRs(vloginreq);
      return Right(tempo);
    } on DioException1 catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, LoginErrorModel>> errorRep() async {
    try {
      final tempo = await helloworld.error();
      return Right(tempo);
    } on DioException1 catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, RegisterResponseModel>> registerrep(
      RegisterRequestModel registerreq) async {
    try {
      final tempo = await helloworld.registerRs(registerreq);
      return Right(tempo);
    } on DioException1 catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, VehicleOwnerRegisterResponseModel>> vregisterrep(
      VehicleOwnerRegisterRequestModel vregisterreq) async {
    try {
      final tempo = await helloworld.vregister(vregisterreq);
      return Right(tempo);
    } on DioException1 catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, ForgotPasswordResponseModel>> forgotrep(
      ForgotPasswordRequestModel forgetreq) async {
    try {
      final tempo = await helloworld.forgot(forgetreq);
      return Right(tempo);
    } on DioException1 catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, ResetPasswordResponseModel>> resetrep(
      ResetPasswordRequestModel resetreq) async {
    try {
      final tempo = await helloworld.reset(resetreq);
      return Right(tempo);
    } on DioException1 catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, VehicleOwnerForgotPasswordResponseModel>> vforgotrep(
      VehicleOwnerForgotPasswordRequestModel veforgetreq) async {
    try {
      final tempo = await helloworld.vforgot(veforgetreq);
      return Right(tempo);
    } on DioException1 catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, VehicleOwnerResetPasswordResponseModel>> vresetrep(
      VehicleOwnerResetPasswordRequestModel vresetreq) async {
    try {
      final tempo = await helloworld.vreset(vresetreq);
      return Right(tempo);
    } on DioException1 catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final authRepositoryProvider = Provider<AuthRepo>((ref) {
  return AuthRepoImp(ref.read(loginProvider));
});
