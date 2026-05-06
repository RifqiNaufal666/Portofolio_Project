import 'package:clima_app/configs/constant/asset_const.dart';
import 'package:clima_app/configs/themes/app_colors.dart';
import 'package:clima_app/shared/extension/spacing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        shadowColor: AppColors.bgBlue,
        title: Padding(
          padding: 61.0.verticalREdge,
          child: Text(
            'FAQ',
            style: GoogleFonts.inter(
              fontSize: 15.0.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 1.0.h,
            thickness: 1.0.h,
            color: AppColors.primary,
          ),
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    12.0.verticalSpace,
                    Image.asset(ImgAssets.faq),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
