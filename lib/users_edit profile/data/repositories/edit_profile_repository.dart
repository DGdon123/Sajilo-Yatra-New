import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/core/app_error/app_error.dart';
import 'package:sajilo_yatra/users_edit%20profile/data/data_source/edit_profile_data_source.dart';
import 'package:sajilo_yatra/users_edit%20profile/data/models/edit_profile_request_model.dart';
import 'package:sajilo_yatra/users_profile/data/data_source/profile_data_source.dart';
import 'package:sajilo_yatra/users_profile/data/models/profile_params_model.dart';
import 'package:sajilo_yatra/users_profile/data/models/profile_response_model.dart';

import '../models/edit_profile_response_model.dart';

abstract class EDitProfileRepository {
  Future<Either<AppError, EditProfileResponseModel>> getUserInfo2(
      EditProfileRequestModel free, ProfileParams profile);
}

class ProfileRepositoryImp implements EDitProfileRepository {
  final EditProfileDataSource profileDataSource;
  ProfileRepositoryImp(this.profileDataSource);

  @override
  Future<Either<AppError, EditProfileResponseModel>> getUserInfo2(
      EditProfileRequestModel free, ProfileParams profile) async {
    try {
      final result = await profileDataSource.loginRs(free, profile);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final editprofileRepositoryProvider = Provider<EDitProfileRepository>((ref) {
  return ProfileRepositoryImp(ref.read(editprofileDataProvider));
});
