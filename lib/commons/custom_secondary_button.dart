import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sajilo_yatra/const/app_colors_const.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';
import 'package:sajilo_yatra/const/app_fonts.dart';

class CustomSecondaryButton extends StatelessWidget {
  final double? heightProduct;
  final String text;
  final void Function() onPressed;
  final Icon? icon;
  final Color? gradient;
  const CustomSecondaryButton({
    Key? key,
    this.heightProduct,
    required this.text,
    required this.onPressed,
    this.icon,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.4,
      height: height * (heightProduct ?? 0.055),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
        border: Border.all(
          color: gradient ??
              AppColorConst
                  .kappscafoldbggrey, // Set your desired border color here
          width: 1.1, // Set the border width as needed
        ),
      ),
      child: MaterialButton(
          onPressed: () => onPressed(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ??
                  SizedBox(
                    width: width * 0,
                  ),
              if (icon != null) SizedBox(width: width * 0.02),
              Text(
                text,
                style: const TextStyle(
                  color: CupertinoColors.darkBackgroundGray,
                  fontSize: AppDimensions.body_15,
                  letterSpacing: 1,
                  fontFamily: AppFont.kProductsanfont,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )),
    );
  }
}
