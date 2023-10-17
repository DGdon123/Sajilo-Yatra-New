import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sajilo_yatra/const/app_dimension.dart';

import '../const/app_colors_const.dart';
import '../const/app_fonts.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    Key? key,
    required this.onTap,
    required this.firstText,
    required this.secondText,
  }) : super(key: key);

  final Function()? onTap;
  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$firstText ",
                  style: TextStyle(
                    letterSpacing: 0.04.dp,
                    fontSize: AppDimensions.body_14,
                    color: CupertinoColors.systemGrey,
                    fontFamily: AppFont.jProductsanfont,
                  ),
                ),
                TextSpan(
                  text: secondText,
                  style: TextStyle(
                    height: 0.25.h,
                    letterSpacing: 0.04.dp,
                    fontSize: AppDimensions.body_14,
                    fontWeight: AppDimensions.fontBold,
                    color: AppColorConst.kappprimaryColorRed,
                    fontFamily: AppFont.lProductsanfont,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
