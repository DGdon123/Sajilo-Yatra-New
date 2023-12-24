import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/core/api_exception/dio_exception.dart';
import 'package:sajilo_yatra/users_rentals/data/models/rental_request_model.dart';
import 'package:sajilo_yatra/users_rentals/data/models/rental_response_model.dart';

import '../../../core/app_error/app_error.dart';
import '../data_source/rental_data_source.dart';

abstract class RentalRepo {
  Future<Either<AppError, RentalResponseModel>> rrepo(RentalRequestModel treq);
}

class RentalRepoImp implements RentalRepo {
  final RentalDataSource helloworld;

  RentalRepoImp(this.helloworld);
  @override
  Future<Either<AppError, RentalResponseModel>> rrepo(
      RentalRequestModel rreq) async {
    try {
      final tempo = await helloworld.rentals(rreq);
      return Right(tempo);
    } on DioException1 catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final rentalRepositoryProvider = Provider<RentalRepo>((ref) {
  return RentalRepoImp(ref.read(rentalProvider));
});
