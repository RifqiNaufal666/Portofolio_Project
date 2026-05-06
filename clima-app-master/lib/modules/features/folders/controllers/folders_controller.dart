import 'package:clima_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:clima_app/modules/features/dashboard/models/folders_res/folders_res.dart';
import 'package:clima_app/modules/features/dashboard/repositories/dashboard_repository.dart';
import 'package:clima_app/shared/helpers/dialog_helpers.dart';
import 'package:get/get.dart';

class FoldersController extends GetxController {
  final DashboardController dashController;
  final DashboardRepository _repo;

  FoldersController(this._repo, this.dashController);

  static FoldersController get i => Get.find();
  RxList<DataFolder> dataFolders = <DataFolder>[].obs;
  RxList<DataFolder> deleteFolders = <DataFolder>[].obs;

  @override
  void onReady() {
    super.onReady();
    getFolders();
    deleteFolders.value = [];
  }

  void onSelectItemMenu(int index, DataFolder data) {
    dashController.folderSelected.value = data;
    dashController.onSelectItemMenu(index);
  }

  void onSelectDeleteItem(DataFolder data) {
    if (deleteFolders.contains(data)) {
      deleteFolders.remove(data);
      return;
    }

    deleteFolders.add(data);
  }

  void onSelectDeleteAll() {
    if (deleteFolders.length == dataFolders.length) {
      deleteFolders.value = [];
      return;
    }

    deleteFolders.value = [...dataFolders];
  }

  Future<void> onDeleteFolders() async {
    try {
      DialogHelpers.loading();

      final res = await _repo.deleteFolders(
        dashController.args.optionMenu,
        itemsId: deleteFolders.map((e) => e.id!).toList(),
      );
      DialogHelpers.loadingClose();

      if (res == 200) {
        DialogHelpers.success(
          title: 'Gagal',
          desc: 'Berhasil menghapus folder',
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

  Future<void> getFolders() async {
    try {
      DialogHelpers.loading();

      dataFolders.value =
          await _repo.getFolders(dashController.args.optionMenu);

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
