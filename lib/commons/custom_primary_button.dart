import 'package:flutter/material.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';
import 'package:sajilo_yatra/const/app_fonts.dart';

class CustomPrimaryButton extends StatelessWidget {
  final double? heightProduct;
  final String text;
  final void Function() onPressed;
  final Icon? icon;
  final Color? gradient;
  const CustomPrimaryButton({
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
      width: width * 0.34,
      height: height * (heightProduct ?? 0.055),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: gradient),
      child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
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
                  color: Colors.white,
                  fontSize: AppDimensions.body_16,
                  fontFamily: AppFont.lProductsanfont,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )),
    );
  }
}
