import 'package:clima_app/modules/dependencies/res/dependency_injector.dart';
import 'package:clima_app/modules/features/dashboard/repositories/dashboard_repository.dart';
import 'package:clima_app/modules/features/folders/controllers/new_file_controller.dart';
import 'package:clima_app/modules/features/folders/controllers/new_folder_controller.dart';
import 'package:get/get.dart';

class FoldersDependency extends DependencyInjector {
  @override
  void controller() {
    Get.lazyPut(() => NewFolderController(sh(), sh(), args()));
    Get.lazyPut(() => NewFileController(sh(), sh(), args()));
  }

  @override
  void repositories() {
    Get.lazyPut(() => DashboardRepository());
  }
}
