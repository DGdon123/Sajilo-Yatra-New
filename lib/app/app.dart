import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/app/splash_screen.dart';
import 'package:sajilo_yatra/utils/bottom_bar/bottom_bar.dart';
import 'package:sajilo_yatra/utils/bottom_bar/vehicle_bottom_bar.dart';

import '../auth/presentation/login/controllers/login_controllers/user_login_controller.dart';

import '../auth/presentation/login/controllers/login_controllers/vehicle_owner_login_controller.dart';
import '../auth/presentation/login/views/main_login_screen.dart';

import '../auth/presentation/login/views/vehicle_owner_reset/vehicle_owner_reset_password_screen.dart';
import 'app_theme.dart';

class MyApplication extends ConsumerWidget {
  const MyApplication({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLoggedInState = ref.watch(loginControllerProvider);
    final vehicleOwnerLoggedInState = ref.watch(vloginControllerProvider);
    return ResponsiveSizer(builder:
        (BuildContext context, Orientation orientation, ScreenType screenType) {
      return FutureBuilder(
          future: Init.instance.initialize(),
          builder: (context, AsyncSnapshot snapshot) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: AppTheme.light(),
                home: userLoggedInState.when(
                  loggedIn: (userData) {
                    return const BottomBar();
                  },
                  loggedOut: () {
                    return vehicleOwnerLoggedInState.when(
                      loggedIn: (vehicleOwnerData) {
                        return const VehicleBottomBar();
                      },
                      loggedOut: () {
                        return const LoginScreen();
                      },
                      loading: () {
                        return const CircularProgressIndicator.adaptive();
                      },
                    );
                  },
                  loading: () {
                    return const CircularProgressIndicator.adaptive();
                  },
                ));
          });
    });
  }
}
