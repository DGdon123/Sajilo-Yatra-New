import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../const/app_fonts.dart';
import '../../../../../core/db_client/db_client.dart';

import '../../../../data/models/login_models/login_request_model.dart';
import '../../../../data/models/login_models/login_response_model.dart';
import '../../../../data/repositories/auth_repository.dart';

import '../../views/main_login_screen.dart';
import '../../views/users_login/user_login_screen.dart';

import 'auth_state.dart';

class VAuthController extends StateNotifier<AuthState> {
  final AuthRepo vauthRepository;
  final DbClient dbClient;
  VAuthController({required this.vauthRepository, required this.dbClient})
      : super(AuthState.loading()) {
    checkLogin();
  }
  Future<void> checkLogin() async {
    final String dbResult = await dbClient.getData(dbKey: "token");

    if (dbResult.isEmpty) {
      state = const AuthState.loggedOut();
    } else {
      try {
        final decodedData = json.decode(dbResult);
        final loginResponse = LoginResponseModel.fromJson(decodedData);
        state = AuthState.loggedIn(loginResponse);
      } catch (e) {
        state = const AuthState.loggedOut();
      }
    }
  }

  login(LoginRequestModel loginRequestModel, BuildContext context) async {
    final result = await vauthRepository.vloginrep(loginRequestModel);
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1000),
          content: Text(
            "Welcome to HRDC",
            style: const TextStyle(fontFamily: AppFont.kProductsanfont),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom == 0
                  ? MediaQuery.of(context).size.height - 100
                  : MediaQuery.of(context).size.height -
                      MediaQuery.of(context).viewInsets.bottom -
                      10,
              right: 20,
              left: 20),
        ));
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => Home(),
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

final vloginControllerProvider =
    StateNotifierProvider<VAuthController, AuthState>((ref) {
  return VAuthController(
      vauthRepository: ref.read(authRepositoryProvider),
      dbClient: ref.read(dbClientProvider));
});
