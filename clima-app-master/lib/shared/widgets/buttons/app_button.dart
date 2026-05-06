import 'package:clima_app/configs/constant/app_radius.dart';
import 'package:clima_app/configs/themes/app_colors.dart';
import 'package:clima_app/shared/extension/spacing_widget.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? label;
  final double? width;
  final double? height;
  final double? sizeFont;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderRadius? borderRadius;
  final bool enable;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.label,
    this.width,
    this.height,
    this.sizeFont,
    this.fontWeight,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    required this.onPressed,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: enable ? onPressed : null,
        style: ElevatedButton.styleFrom(
          foregroundColor: foregroundColor ?? AppColors.primary,
          backgroundColor: backgroundColor ?? AppColors.white,
          padding: 6.0.verticalEdge,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? AppRadius.r10,
          ),
        ),
        child: Text(
          label ?? '',
          style: TextStyle(
            fontSize: sizeFont,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
