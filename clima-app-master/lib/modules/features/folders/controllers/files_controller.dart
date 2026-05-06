import 'package:clima_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:clima_app/modules/features/dashboard/models/files_res/files_res.dart';
import 'package:clima_app/modules/features/dashboard/repositories/dashboard_repository.dart';
import 'package:clima_app/shared/helpers/dialog_helpers.dart';
import 'package:get/get.dart';

class FilesController extends GetxController {
  final DashboardController dashController;
  final DashboardRepository _repo;

  FilesController(this.dashController, this._repo);

  static FilesController get i => Get.find();

  final RxBool searchEnable = false.obs;
  final RxList<DataFile> dataFiles = <DataFile>[].obs;
  final RxList<DataFile> deleteFiles = <DataFile>[].obs;

  @override
  void onReady() {
    super.onReady();

    getFiles();
    deleteFiles.value = [];
  }

  void onSelectItemMenu(int index) {
    dashController.onSelectItemMenu(index);
  }

  void onSelectDeleteItem(DataFile data) {
    if (deleteFiles.contains(data)) {
      deleteFiles.remove(data);
      return;
    }

    deleteFiles.add(data);
  }

  void onSelectDeleteAll() {
    if (deleteFiles.length == dataFiles.length) {
      deleteFiles.value = [];
      return;
    }

    deleteFiles.value = [...dataFiles];
  }

  Future<void> onDeleteFiles() async {
    try {
      DialogHelpers.loading();

      final res = await _repo.deleteFiles(
        dashController.args.optionMenu,
        idFolder: dashController.folderSelected.value.id!,
        itemsId: deleteFiles.map((e) => e.id!).toList(),
      );
      DialogHelpers.loadingClose();

      if (res == 200) {
        DialogHelpers.success(
          title: 'Gagal',
          desc: 'Berhasil menghapus file',
        );
      }
    } catch (e) {
      DialogHelpers.loadingClose();
      DialogHelpers.problem(
        title: 'Gagal',
        desc: e.toString(),
      );
    }
  }

  Future<void> getFiles() async {
    try {
      DialogHelpers.loading();

      dataFiles.value = await _repo.getFiles(
        dashController.args.optionMenu,
        idFolder: dashController.folderSelected.value.id!,
      );

      DialogHelpers.loadingClose();
    } catch (e) {
      DialogHelpers.loadingClose();
      DialogHelpers.problem(
        title: 'Gagal Memuat Data',
        desc: e.toString(),
      );
    }
  }
}
