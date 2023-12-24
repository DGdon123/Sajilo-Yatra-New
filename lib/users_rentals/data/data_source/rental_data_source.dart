import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/users_rentals/data/models/rental_request_model.dart';
import 'package:sajilo_yatra/users_rentals/data/models/rental_response_model.dart';

import '../../../core/api_client/api_client.dart';
import '../../../core/api_const/api_const.dart';

abstract class RentalDataSource {
  Future<RentalResponseModel> rentals(RentalRequestModel rentalreq);
}

class RentalDataImp implements RentalDataSource {
  final ApiClient apiClient;

  RentalDataImp(this.apiClient);
  @override
  Future<RentalResponseModel> rentals(RentalRequestModel rentalreq) async {
    final response = await apiClient.request(
        type: "post", path: ApiConst.kuserRental, data: rentalreq.toMap());

    return RentalResponseModel.fromMap(response);
  }
}

final rentalProvider = Provider<RentalDataSource>((ref) {
  return RentalDataImp(ref.read(apiClientProvider));
});
