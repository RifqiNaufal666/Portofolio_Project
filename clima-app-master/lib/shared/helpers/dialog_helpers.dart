import 'package:clima_app/configs/constant/asset_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DialogHelpers {
  DialogHelpers._();

  static Future<T?> loading<T>({Future<T> Function()? asyncFunction}) {
    return Get.dialog(
      SizedBox(
        height: 24.0.h,
        width: 24.0.h,
        child: Image.asset(
          LogoAssets.logoLabel,
          height: 24.0.h,
          width: 24.0.h,
        ),
      ),
    );
  }

  static void loadingClose({int? times}) {
    Get.close(times ?? 1);
  }

  static Future<T?> success<T>({
    required String title,
    required String desc,
    String? textCancel,
    String? textOk,
    VoidCallback? onOk,
  }) async {
    return Get.defaultDialog(
      title: title,
      middleText: desc,
      textCancel: textCancel,
      textConfirm: textOk ?? 'Oke',
      onConfirm: onOk ?? Get.back,
      radius: 12.0.r,
    );
  }

  static Future<T?> problem<T>({
    required String title,
    required String desc,
    String? textCancel,
    String? textOk,
    VoidCallback? onOk,
  }) async {
    return Get.defaultDialog(
      title: title,
      middleText: desc,
      textCancel: textCancel,
      textConfirm: textOk ?? 'Oke',
      onConfirm: onOk ?? Get.back,
      radius: 12.0.r,
    );
  }

  static Future<T?> confirmation<T>({
    required String title,
    required String desc,
    String? textCancel,
    String? textOk,
    VoidCallback? onOk,
    VoidCallback? onCancel,
  }) async {
    return Get.defaultDialog(
      title: title,
      middleText: desc,
      textCancel: textCancel,
      textConfirm: textOk ?? 'Oke',
      onConfirm: onOk ?? Get.back,
      onCancel: onCancel,
      radius: 12.0.r,
    );
  }
}
