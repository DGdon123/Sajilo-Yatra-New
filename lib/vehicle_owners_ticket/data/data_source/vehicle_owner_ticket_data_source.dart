import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/vehicle_owners_ticket/data/models/vehicle_owner_ticket_response_model.dart';

import '../../../core/api_client/api_client.dart';
import '../../../core/api_const/api_const.dart';
import '../models/vehicle_owner_ticket_request_model.dart';

abstract class VehicleOwnerTicketDataSource {
  Future<VehicleOwnerTicketResponseModel> vehicleticket(
      VehicleOwnerTicketRequestModel vehticketreq);
}

class VehicleOwnerTicketDataImp implements VehicleOwnerTicketDataSource {
  final ApiClient apiClient;

  VehicleOwnerTicketDataImp(this.apiClient);
  @override
  Future<VehicleOwnerTicketResponseModel> vehicleticket(
      VehicleOwnerTicketRequestModel vehticketreq) async {
    final response = await apiClient.request(
        type: "post",
        path: ApiConst.kvehicleTicket,
        data: vehticketreq.toMap());

    return VehicleOwnerTicketResponseModel.fromMap(response);
  }
}

final vehticketProvider = Provider<VehicleOwnerTicketDataSource>((ref) {
  return VehicleOwnerTicketDataImp(ref.read(apiClientProvider));
});
