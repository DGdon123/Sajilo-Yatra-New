import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import '../../auth/presentation/login/views/main_login_screen.dart';
import '../../auth/presentation/login/views/users_forget_password/user_forget_password_screen.dart';
import '../../const/app_colors_const.dart';
import '../../dashboard/presentation/views/dashboard_screen.dart';
import '../nav_states/nav_notifier.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  static final List<Widget> _widgetOptions = [
    const Dashboard(),
    const LoginScreen(),
    Forgot_Password(),
  ];

  @override
  Widget build(BuildContext context) {
    var navIndex = ref.watch(navProvider);

    return Scaffold(
      body: Center(
        child: _widgetOptions[navIndex.index],
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        snakeViewColor: CupertinoColors.systemGrey3,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30), // Adjust the radius as needed
        ),
        backgroundColor: AppColorConst.kappprimaryColorRed,
        snakeShape: SnakeShape.rectangle,
        padding: const EdgeInsets.symmetric(horizontal: 31.0, vertical: 9.5),
        selectedItemColor: CupertinoColors.white,
        unselectedItemColor: CupertinoColors.white,
        currentIndex: navIndex.index,
        onTap: (index) {
          setState(() {
            ref.read(navProvider.notifier).onIndexChanged(index);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.alarm),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subject_rounded),
            label: 'Orders',
          ),
        ],
      ),
    );
  }
}
