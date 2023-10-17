import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/db_client/db_client.dart';

import '../../../../../dashboard/presentation/views/dashboard_screen.dart';
import '../../../../data/models/login_models/login_request_model.dart';
import '../../../../data/models/login_models/login_response_model.dart';
import '../../../../data/repositories/auth_repository.dart';

import '../../views/main_login_screen.dart';
import 'auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  final AuthRepo authRepository;
  final DbClient dbClient;
  AuthController({required this.authRepository, required this.dbClient})
      : super(AuthState.loading()) {
    checkLogin();
  }
  checkLogin() async {
    // log("hit");
    final String result = await dbClient.getData(dbKey: "token");
    // log("${result}ss");
    return result.isEmpty
        ? state = const AuthState.loggedOut()
        : state = AuthState.loggedIn(LoginResponseModel.fromJson(result));
  }

  login(LoginRequestModel loginRequestModel, BuildContext context) async {
    final result = await authRepository.loginrep(loginRequestModel);
    return result.fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 500),
        content: Text(l.message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom == 0
                ? MediaQuery.of(context).size.height - 120
                : MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewInsets.bottom -
                    100,
            right: 20,
            left: 20),
      ));
    }, (r) async {
      await dbClient.setData(dbKey: "token", value: r.toJson().toString());
      state = AuthState.loggedIn(r);
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => Dashboard(),
            ),
            (route) => false);
      }
    });
  }

  logout(BuildContext context) async {
    await dbClient.reset();
    state = const AuthState.loggedOut();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false);
  }
}

final loginControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
      authRepository: ref.read(authRepositoryProvider),
      dbClient: ref.read(dbClientProvider));
});
