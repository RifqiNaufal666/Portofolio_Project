import 'package:clima_app/modules/dependencies/res/dependency_injector.dart';
import 'package:clima_app/modules/features/accounts/controllers/profile_controller.dart';
import 'package:get/get.dart';

class AccountsDependency extends DependencyInjector {
  @override
  void controller() {
    Get.lazyPut(() => ProfileController());
  }

  @override
  void repositories() {}
}
