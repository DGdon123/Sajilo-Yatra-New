import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/users_edit%20profile/data/models/edit_profile_response_model.dart';
import 'package:sajilo_yatra/users_tickets/data/models/ticket_model_request.dart';
import 'package:sajilo_yatra/users_tickets/data/models/ticket_model_response.dart';
import 'package:sajilo_yatra/users_tickets/data/repositories/ticket_repositories.dart';
import 'package:sajilo_yatra/utils/custom_navigation/app_nav.dart';

import '../../../auth/presentation/login/views/main_login_screen.dart';

class TicketController extends StateNotifier<AsyncValue<TicketModelResponse>> {
  final TicketRepo ticketRepo;

  TicketController({required this.ticketRepo})
      : super(const AsyncValue.loading());

  getTicketDetails(
      {required BuildContext context,
      required TicketModelRequest registerRequestModel}) async {
    final result = await ticketRepo.trepo(registerRequestModel);
    return result.fold((l) {
      state = AsyncValue.error(l, StackTrace.fromString(l.message));
    }, (r) async {
      state = AsyncValue.data(r);
      if (context.mounted) {
        pushAndRemoveUntil(context, const LoginScreen());
      }
    });
  }
}

final ticketControllerProvider =
    StateNotifierProvider<TicketController, AsyncValue<TicketModelResponse>>(
        (ref) {
  return TicketController(ticketRepo: ref.read(ticketRepositoryProvider));
});
