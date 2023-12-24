import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/utils/bottom_bar/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/db_client/db_client.dart';
import 'package:logger/logger.dart';
import '../../../../../users_dashboard/presentation/views/dashboard_screen.dart';
import '../../../../data/models/login_models/login_request_model.dart';
import '../../../../data/models/login_models/login_response_model.dart';
import '../../../../data/repositories/auth_repository.dart';

import '../../views/main_login_screen.dart';
import 'auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  final AuthRepo authRepository;
  final DbClient dbClient;
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  AuthController({required this.authRepository, required this.dbClient})
      : super(const AuthState.loading()) {
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
        duration: const Duration(milliseconds: 1700),
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
      logger.d(r.id);
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();

// Save an String value to 'action' key.
      await prefs.setString('tokens', r.id);

      await dbClient.setData(dbKey: "token", value: r.toJson().toString());
      state = AuthState.loggedIn(r);
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => const BottomBar(),
            ),
            (route) => false);
      }
    });
  }

  logout(BuildContext context) async {
    await dbClient.removeData(dbKey: "token");
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
