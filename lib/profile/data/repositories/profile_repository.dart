import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/core/app_error/app_error.dart';
import 'package:sajilo_yatra/profile/data/data_source/profile_data_source.dart';
import 'package:sajilo_yatra/profile/data/models/profile_params_model.dart';
import 'package:sajilo_yatra/profile/data/models/profile_response_model.dart';

abstract class ProfileRepository {
  Future<Either<AppError, ProfileResponseModel>> getUserInfo(
      ProfileParams profile);
}

class ProfileRepositoryImp implements ProfileRepository {
  final ProfileDataSource profileDataSource;
  ProfileRepositoryImp(this.profileDataSource);
  @override
  Future<Either<AppError, ProfileResponseModel>> getUserInfo(
      ProfileParams profile) async {
    try {
      final result = await profileDataSource.profiledata(profile);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImp(ref.read(profileDataProvider));
});
