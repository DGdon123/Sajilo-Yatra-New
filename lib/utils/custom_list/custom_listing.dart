import 'package:flutter/material.dart';
import 'package:sajilo_yatra/const/app_colors_const.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';
import 'package:sajilo_yatra/const/app_fonts.dart';
import 'package:sajilo_yatra/helpers/ui_helper.dart';

class CustomListing extends StatelessWidget {
  final String text;

  const CustomListing({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 10,
              ),
              height: UiHelper.displayHeight(context) * 0.02,
              width: UiHelper.displayWidth(context) * 0.039,
              decoration: const BoxDecoration(
                color: AppColorConst.kappprimaryColorRed,
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: AppDimensions.paddingDEFAULT,
        ),
        Text(
          text,
          textAlign: TextAlign.justify,
          style: const TextStyle(
              letterSpacing: 0.3,
              fontFamily: AppFont.lProductsanfont,
              color: Color(0xFF222222),
              fontSize: AppDimensions.body_14),
        ),
      ],
    );
  }
}
