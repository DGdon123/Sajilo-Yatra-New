import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/core/api_exception/dio_exception.dart';
import 'package:sajilo_yatra/core/app_error/app_error.dart';
import 'package:sajilo_yatra/users_tickets/data/models/ticket_model_request.dart';
import 'package:sajilo_yatra/users_tickets/data/models/ticket_model_response.dart';
import '../data_source/ticket_data_source.dart';

abstract class TicketRepo {
  Future<Either<AppError, TicketModelResponse>> trepo(TicketModelRequest treq);
}

class TicketRepoImp implements TicketRepo {
  final TicketDataSource helloworld;

  TicketRepoImp(this.helloworld);
  @override
  Future<Either<AppError, TicketModelResponse>> trepo(
      TicketModelRequest treq) async {
    try {
      final tempo = await helloworld.tickets(treq);
      return Right(tempo);
    } on DioException1 catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final ticketRepositoryProvider = Provider<TicketRepo>((ref) {
  return TicketRepoImp(ref.read(ticketProvider));
});
