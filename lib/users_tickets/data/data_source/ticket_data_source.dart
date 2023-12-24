import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/users_tickets/data/models/ticket_model_request.dart';
import 'package:sajilo_yatra/users_tickets/data/models/ticket_model_response.dart';
import '../../../core/api_client/api_client.dart';
import '../../../core/api_const/api_const.dart';

abstract class TicketDataSource {
  Future<TicketModelResponse> tickets(TicketModelRequest ticketreq);
}

class TicketDataImp implements TicketDataSource {
  final ApiClient apiClient;

  TicketDataImp(this.apiClient);
  @override
  Future<TicketModelResponse> tickets(TicketModelRequest ticketreq) async {
    final response = await apiClient.request(
        type: "post", path: ApiConst.kuserTicket, data: ticketreq.toMap());

    return TicketModelResponse.fromMap(response);
  }
}

final ticketProvider = Provider<TicketDataSource>((ref) {
  return TicketDataImp(ref.read(apiClientProvider));
});
