import 'package:clima_app/configs/networks/firebase_options.dart';
import 'package:clima_app/configs/pages/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  static SplashController get i => Get.find();
  late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(const Duration(seconds: 1));

    if (firebaseAuth.currentUser != null) {
      Get.offAllNamed(AppRoutes.optionMenu);
      return;
    }

    Get.offAllNamed(AppRoutes.login);
  }
}
