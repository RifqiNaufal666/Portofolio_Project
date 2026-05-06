import 'package:clima_app/configs/constant/asset_const.dart';
import 'package:clima_app/modules/features/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetWidget<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImgAssets.splashBg,
      fit: BoxFit.fill,
    );
  }
}
