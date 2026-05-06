import 'package:clima_app/configs/constant/app_radius.dart';
import 'package:clima_app/configs/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hit;
  final bool outline;
  final bool transparent;
  final EdgeInsets? contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final BorderRadius? borderRadius;
  final TextEditingController? controller;
  final TextStyle? errorStyle;
  final void Function(String)? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    required this.label,
    required this.hit,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.contentPadding,
    this.borderRadius,
    this.errorStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.outline = true,
    this.transparent = false,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: transparent ? Colors.transparent : AppColors.white,
        borderRadius: borderRadius ?? AppRadius.r18,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hit,
          contentPadding: contentPadding,
          prefixIcon: prefixIcon,
          suffix: suffix,
          suffixIcon: suffixIcon,
          errorStyle: errorStyle,
          border: outline
              ? OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primary),
                  borderRadius: borderRadius ?? AppRadius.r18,
                )
              : UnderlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primary),
                  borderRadius: borderRadius ?? AppRadius.r18,
                ),
          enabledBorder: outline
              ? OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.primary2,
                  ),
                  borderRadius: borderRadius ?? AppRadius.r18,
                )
              : UnderlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primary),
                  borderRadius: borderRadius ?? AppRadius.r18,
                ),
          focusedBorder: outline
              ? OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                  borderRadius: borderRadius ?? AppRadius.r18,
                )
              : UnderlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primary),
                  borderRadius: borderRadius ?? AppRadius.r18,
                ),
        ),
      ),
    );
  }
}
