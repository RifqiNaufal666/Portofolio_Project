import 'package:clima_app/configs/constant/app_const.dart';
import 'package:clima_app/configs/pages/app_pages.dart';
import 'package:clima_app/configs/pages/app_routes.dart';
import 'package:clima_app/configs/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConst.appDesignSizePhone,
      child: GetMaterialApp(
        title: 'Klimatologi Access App',
        theme: AppTheme.ligth,
        getPages: AppPages.pages(),
        initialRoute: AppRoutes.splash,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, child) {
          ScreenUtil.init(
            context,
            designSize: AppConst.appDesignSizePhone,
            minTextAdapt: true,
          );

          return child!;
        },
      ),
    );
  }
}
