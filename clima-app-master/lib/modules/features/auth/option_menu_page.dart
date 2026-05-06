import 'package:clima_app/configs/constant/asset_const.dart';
import 'package:clima_app/configs/pages/app_routes.dart';
import 'package:clima_app/configs/themes/app_colors.dart';
import 'package:clima_app/modules/features/auth/controllers/option_menu_contoller.dart';
import 'package:clima_app/modules/features/dashboard/args/args_dashboard.dart';
import 'package:clima_app/shared/enums/menus_enum.dart';
import 'package:clima_app/shared/extension/spacing_widget.dart';
import 'package:clima_app/shared/widgets/buttons/app_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OptionMenuPage extends GetWidget<OptionMenuContoller> {
  const OptionMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            LogoAssets.logo,
            width: 190.0.w,
          ),
          60.0.verticalSpace,
          Image.asset(
            LogoAssets.label,
            width: 230.0.w,
          ),
          60.0.verticalSpace,
          Padding(
            padding: 14.0.horizontalEdge,
            child: AppGradientButton(
              sizeFont: 28.0.sp,
              label: 'E-Buletin',
              fontWeight: FontWeight.w600,
              onPressed: () {
                Get.offAllNamed(
                  AppRoutes.dashboard,
                  arguments: ArgsDashboard(
                    optionMenu: OptionMenusEnum.buletin,
                  ),
                );
              },
            ),
          ),
          40.0.verticalSpace,
          Padding(
            padding: 14.0.horizontalEdge,
            child: AppGradientButton(
              sizeFont: 28.0.sp,
              label: 'Prakiraan 6 Bulanan',
              fontWeight: FontWeight.w600,
              onPressed: () {
                Get.offAllNamed(
                  AppRoutes.dashboard,
                  arguments: ArgsDashboard(
                    optionMenu: OptionMenusEnum.sixMouth,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
