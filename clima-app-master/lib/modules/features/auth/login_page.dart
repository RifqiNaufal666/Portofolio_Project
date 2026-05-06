import 'package:clima_app/configs/constant/asset_const.dart';
import 'package:clima_app/configs/themes/app_colors.dart';
import 'package:clima_app/modules/features/auth/controllers/login_controller.dart';
import 'package:clima_app/shared/extension/spacing_widget.dart';
import 'package:clima_app/shared/widgets/buttons/app_gradient_button.dart';
import 'package:clima_app/shared/widgets/fields/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends GetWidget<LoginController> {
  const LoginPage({super.key});

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
          29.0.verticalSpace,
          Image.asset(
            LogoAssets.label,
            width: 230.0.w,
          ),
          29.0.verticalSpace,
          Padding(
            padding: 14.0.horizontalEdge,
            child: AppTextField(
              label: 'Email',
              hit: 'Masukan email',
              keyboardType: TextInputType.emailAddress,
              errorStyle: const TextStyle(height: 0),
              onChanged: (p0) => controller.email.value = p0,
            ),
          ),
          8.0.verticalSpace,
          Padding(
            padding: 14.0.horizontalEdge,
            child: Obx(() {
              return AppTextField(
                label: 'Password',
                hit: 'Masukan password',
                obscureText: controller.visiblePassword.value,
                keyboardType: TextInputType.visiblePassword,
                errorStyle: const TextStyle(height: 0),
                onChanged: (p0) => controller.password.value = p0,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.visiblePassword.value =
                        !controller.visiblePassword.value;
                  },
                  icon: controller.visiblePassword.value
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              );
            }),
          ),
          28.0.verticalSpace,
          Padding(
            padding: 14.0.horizontalEdge,
            child: AppGradientButton(
              sizeFont: 28.0.sp,
              label: 'Login',
              fontWeight: FontWeight.w600,
              onPressed: controller.onLogin,
            ),
          ),
        ],
      ),
    );
  }
}
