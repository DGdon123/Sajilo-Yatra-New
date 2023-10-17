import 'package:flutter/material.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';

import '../const/app_colors_const.dart';
import '../const/app_fonts.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton(
      {required this.label,
      super.key,
      required this.onPressed,
      this.isLable = true,
      this.bottonBgColor = AppColorConst.kappscafoldbgyellow,
      this.lableColor = Colors.white});

  final String label;
  final void Function()? onPressed;
  final Color lableColor;
  final Color bottonBgColor;
  final bool isLable;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(0, 45),
          shape: ContinuousRectangleBorder(
              side: const BorderSide(
                  width: 0.8, color: AppColorConst.kappprimaryColorRed),
              borderRadius: BorderRadius.circular(55)),
          elevation: 0,
          backgroundColor: bottonBgColor,
        ),
        onPressed: onPressed,
        child: isLable
            ? Text(
                label,
                style: TextStyle(
                    fontFamily: AppFont.kProductsanfont,
                    color: lableColor,
                    fontWeight: AppDimensions.fontBold),
              )
            : Text(
                label,
                style: TextStyle(
                    fontFamily: AppFont.kProductsanfont,
                    color: lableColor,
                    fontWeight: AppDimensions.fontBold),
              ));
  }
}
