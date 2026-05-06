import 'package:clima_app/configs/constant/app_radius.dart';
import 'package:clima_app/configs/themes/app_colors.dart';
import 'package:clima_app/shared/extension/spacing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? sizeFont;
  final BorderRadiusGeometry? borderRadius;
  final FontWeight? fontWeight;
  final Color? bgColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final String? label;
  final Icon? suffixIcon;
  final bool center;
  final Icon? prefixIcon;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  const AppTextButton({
    super.key,
    this.width,
    this.textColor,
    this.onPressed,
    this.padding,
    this.textStyle,
    this.center = true,
    this.bgColor,
    this.height,
    this.borderRadius,
    this.sizeFont,
    this.fontWeight,
    this.label,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: bgColor ?? AppColors.white,
          padding: 6.0.verticalEdge,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? AppRadius.r10,
          ),
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Row(
            mainAxisSize: center ? MainAxisSize.min : MainAxisSize.max,
            children: [
              if (suffixIcon != null) ...[
                suffixIcon!,
                if (label != null) 8.0.horizontalSpace,
              ],
              if (label != null)
                Text(
                  label!,
                  style: textStyle?.copyWith(
                        color: textColor,
                        fontSize: sizeFont,
                        fontWeight: fontWeight,
                      ) ??
                      TextStyle(
                        color: textColor,
                        fontSize: sizeFont,
                        fontWeight: fontWeight,
                      ),
                ),
              if (prefixIcon != null) ...[
                if (label != null) 8.0.horizontalSpace,
                prefixIcon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
