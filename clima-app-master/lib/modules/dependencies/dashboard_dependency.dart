import 'package:clima_app/modules/dependencies/res/dependency_injector.dart';
import 'package:clima_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:clima_app/modules/features/dashboard/repositories/dashboard_repository.dart';
import 'package:clima_app/modules/features/folders/controllers/files_controller.dart';
import 'package:clima_app/modules/features/folders/controllers/folders_controller.dart';
import 'package:get/get.dart';

class DashboardDependency extends DependencyInjector {
  @override
  void controller() {
    Get.lazyPut(() => DashboardController(args()));
    Get.lazyPut(() => FoldersController(sh(), sh()));
    Get.lazyPut(() => FilesController(sh(), sh()));
  }

  @override
  void repositories() {
    Get.lazyPut(() => DashboardRepository());
  }
}
