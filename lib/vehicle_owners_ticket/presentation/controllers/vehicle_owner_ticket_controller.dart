import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/vehicle_owners_ticket/data/models/vehicle_owner_ticket_response_model.dart';
import 'package:sajilo_yatra/vehicle_owners_ticket/data/models/vehicle_owner_ticket_request_model.dart';
import '../../../utils/custom_navigation/app_nav.dart';
import '../../../vehicle_owners_dashboard/presentation/views/vehicle_owners_dashboard_screen.dart';
import '../../data/repositories/vehicle_owner_ticket_repositories.dart';

class VehicleTicketController
    extends StateNotifier<AsyncValue<VehicleOwnerTicketResponseModel>> {
  final VehicleTicketRepo ticketRepo;

  VehicleTicketController({required this.ticketRepo})
      : super(const AsyncValue.loading());

  getvehicleTicketDetails(
      {required BuildContext context,
      required VehicleOwnerTicketRequestModel ticketRequestModel}) async {
    final result = await ticketRepo.ticketrepo(ticketRequestModel);
    return result.fold((l) {
      state = AsyncValue.error(l, StackTrace.fromString(l.message));
    }, (r) async {
      state = AsyncValue.data(r);
      if (context.mounted) {
        pushAndRemoveUntil(context, const VehicleOwnerDashboard());
      }
    });
  }
}

final vehticketControllerProvider = StateNotifierProvider<
    VehicleTicketController,
    AsyncValue<VehicleOwnerTicketResponseModel>>((ref) {
  return VehicleTicketController(
      ticketRepo: ref.read(vehticketRepositoryProvider));
});
