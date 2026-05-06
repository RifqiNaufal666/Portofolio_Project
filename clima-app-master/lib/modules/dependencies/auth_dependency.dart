import 'package:clima_app/modules/dependencies/res/dependency_injector.dart';
import 'package:clima_app/modules/features/auth/controllers/login_controller.dart';
import 'package:clima_app/modules/features/auth/controllers/option_menu_contoller.dart';
import 'package:clima_app/modules/features/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';

class AuthDependency extends DependencyInjector {
  @override
  void controller() {
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => OptionMenuContoller());
  }

  @override
  void repositories() {}
}
