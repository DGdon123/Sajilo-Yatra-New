import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/core/api_exception/dio_exception.dart';
import 'package:sajilo_yatra/core/app_error/app_error.dart';
import 'package:sajilo_yatra/vehicle_owners_ticket/data/models/vehicle_owner_ticket_response_model.dart';
import 'package:sajilo_yatra/vehicle_owners_ticket/data/models/vehicle_owner_ticket_request_model.dart';

import '../data_source/vehicle_owner_ticket_data_source.dart';

abstract class VehicleTicketRepo {
  Future<Either<AppError, VehicleOwnerTicketResponseModel>> ticketrepo(
      VehicleOwnerTicketRequestModel tride);
}

class VehicleTicketRepoImp implements VehicleTicketRepo {
  final VehicleOwnerTicketDataSource helloworld;

  VehicleTicketRepoImp(this.helloworld);
  @override
  Future<Either<AppError, VehicleOwnerTicketResponseModel>> ticketrepo(
      VehicleOwnerTicketRequestModel tride) async {
    try {
      final tempo = await helloworld.vehicleticket(tride);
      return Right(tempo);
    } on DioException1 catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final vehticketRepositoryProvider = Provider<VehicleTicketRepo>((ref) {
  return VehicleTicketRepoImp(ref.read(vehticketProvider));
});
