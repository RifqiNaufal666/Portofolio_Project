import 'package:clima_app/modules/features/dashboard/args/args_dashboard.dart';
import 'package:clima_app/modules/features/dashboard/models/folders_res/folders_res.dart';
import 'package:clima_app/modules/features/folders/controllers/files_controller.dart';
import 'package:clima_app/modules/features/folders/controllers/folders_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  DashboardController(this.args);

  static DashboardController get i => Get.find();

  final ArgsDashboard args;

  final FirebaseAuth instance = FirebaseAuth.instance;
  User? get currentUser => instance.currentUser;

  final RxInt selectedIndex = 1.obs;
  final RxBool moreEnable = false.obs;
  final RxBool deleteMode = false.obs;
  final RxBool editMode = false.obs;
  final RxBool selectAll = false.obs;
  final Rx<DataFolder> folderSelected = const DataFolder().obs;

  void onSelectItemMenu(int index) {
    selectedIndex.value = index;

    if (index == 2) {
      if (Get.isRegistered<FilesController>()) {
        FilesController.i.onInit();
      }
    }

    if (index == 0) {
      if (Get.isRegistered<FoldersController>()) {
        FoldersController.i.onInit();
      }
    }
  }
}
