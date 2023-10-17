import 'package:flutter/material.dart';

import '../const/app_colors_const.dart';
import '../const/app_fonts.dart';

class CustomAppForm extends StatelessWidget {
  const CustomAppForm(
      {super.key,
      required this.textEditingController,
      this.textInputAction = TextInputAction.next,
      required this.lable,
      this.validator,
      this.maxLines = 1,
      this.isPrefixIconrequired = false,
      this.istextCapitilization = false,
      this.inputMaxLenght = 10,
      this.obscureText = false,
      this.ismaxLength = false,
      this.keyboardType = TextInputType.emailAddress,
      this.sufixWidget,
      this.prefixIcon,
      this.onTap,
      required this.readOnly,
      this.onChanged,
      required this.isSuffixIconrequired,
      this.suffixIcon});

  final String lable;
  final bool isPrefixIconrequired;
  final bool isSuffixIconrequired;
  final Widget? sufixWidget;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController textEditingController;
  final bool obscureText;
  final bool istextCapitilization;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool ismaxLength;
  final TextInputType? keyboardType;
  final int inputMaxLenght;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: TextFormField(
        onTap: onTap,
        onChanged: onChanged,
        readOnly: readOnly,
        maxLines: maxLines,
        keyboardType: keyboardType,
        maxLength: ismaxLength ? inputMaxLenght : null,
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: textEditingController,
        textCapitalization: istextCapitilization
            ? TextCapitalization.words
            : TextCapitalization.none,
        validator: validator,
        style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w100,
            fontFamily: AppFont.kProductsanfont),
        textInputAction: textInputAction,
        decoration: InputDecoration(
          counterText: "",
          suffixIcon: isSuffixIconrequired ? Icon(suffixIcon) : null,
          prefixIcon: isPrefixIconrequired ? Icon(prefixIcon) : null,
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1.1,
                  color: AppColorConst.kappprimaryColorRed,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(7)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1.1,
                  color: AppColorConst.kappprimaryColorRed,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(7)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1.1,
                  color: AppColorConst.kappprimaryColorRed,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(7)),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1.1,
                  color: AppColorConst.kappprimaryColorRed,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(7)),
          border: InputBorder.none,
          fillColor: const Color(0xffF9F9FC),
          filled: true,
          hintText: lable,
          hintStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w100,
              fontFamily: AppFont.kProductsanfont),
          // labelStyle:
          //     const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          // label: Text(
          //   lable,
          // ),
        ),
      ),
    );
  }
}
