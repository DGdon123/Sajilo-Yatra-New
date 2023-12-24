import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_yatra/offers/offers%20copy.dart';
import 'package:sajilo_yatra/offers/offers.dart';
import 'package:sajilo_yatra/vehicle_owners_dashboard/presentation/views/vehicle_owners_dashboard_screen.dart';
import '../../auth/presentation/login/views/main_login_screen.dart';
import '../../auth/presentation/login/views/users_forget_password/user_forget_password_screen.dart';
import '../../const/app_colors_const.dart';
import '../../users_dashboard/presentation/views/dashboard_screen.dart';
import '../nav_states/nav_notifier.dart';
import 'package:floating_navigation_bar/floating_navigation_bar.dart';

class VehicleBottomBar extends ConsumerStatefulWidget {
  const VehicleBottomBar({Key? key}) : super(key: key);

  @override
  ConsumerState<VehicleBottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<VehicleBottomBar> {
  List<Widget> pages = [
    const VehicleOwnerDashboard(),
    const Offers1(),
    Forgot_Password(),
  ];

  @override
  Widget build(BuildContext context) {
    var navIndex = ref.watch(navProvider);

    return Scaffold(
      body: pages[navIndex.index],
      bottomNavigationBar: FloatingNavigationBar(
        barHeight: 80.0,
        barWidth: MediaQuery.of(context).size.width - 40.0,
        iconColor: Colors.white,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
        iconSize: 20.0,
        indicatorColor: Colors.white,
        indicatorHeight: 5,
        indicatorWidth: 14.0,
        items: [
          NavBarItems(
            icon: Icons.widgets_outlined,
            title: "Home",
          ),
          NavBarItems(
            icon: Icons.history_outlined,
            title: "Offers",
          ),
          NavBarItems(
            icon: Icons.widgets_rounded,
            title: "Orders",
          ),
        ],
        backgroundColor: AppColorConst.kappprimaryColorRed,
        onChanged: (int value) {
          ref.read(navProvider.notifier).onIndexChanged(value);
        },
      ),
    );
  }
}
