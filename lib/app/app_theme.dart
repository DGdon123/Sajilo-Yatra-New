import 'package:flutter/material.dart';

import '../const/app_colors_const.dart';
import '../const/app_fonts.dart';


class AppTheme {
  static ThemeData light() {
    return ThemeData(
        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColorConst.kappscafoldbggrey,
        ),
        scaffoldBackgroundColor: AppColorConst.kappWhiteColor,
        fontFamily: AppFont.kProductsanfont,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: AppColorConst.kappWhiteColor),
          backgroundColor: AppColorConst.kappprimaryColorRed,
          titleTextStyle: TextStyle(
            fontSize: 14,
            color: AppColorConst.kappWhiteColor,
            fontFamily: AppFont.kProductsanfont,
          ),
          elevation: 0,
        ));
  }
}
