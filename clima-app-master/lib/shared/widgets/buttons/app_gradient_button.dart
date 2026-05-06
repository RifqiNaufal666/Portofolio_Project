import 'package:clima_app/configs/constant/app_radius.dart';
import 'package:clima_app/configs/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppGradientButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? sizeFont;
  final FontWeight? fontWeight;
  final VoidCallback onPressed;
  final String label;

  const AppGradientButton({
    super.key,
    this.width,
    this.height,
    this.sizeFont,
    this.fontWeight,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.primary.withOpacity(0.15),
      borderRadius: AppRadius.r10,
      onTap: onPressed,
      child: Ink(
        padding: const EdgeInsets.only(
          top: 10.0,
        ).r,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.secondary,
              AppColors.white,
              AppColors.white,
              AppColors.primary,
            ],
          ),
          borderRadius: AppRadius.r10,
        ),
        child: Container(
          constraints: BoxConstraints(
            minWidth: width ?? 88.0,
            minHeight: height ?? 36.0,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.mirza(
              fontSize: sizeFont,
              fontWeight: fontWeight,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
