import 'package:clima_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:clima_app/modules/features/dashboard/params/params_create_folder.dart';
import 'package:clima_app/modules/features/dashboard/repositories/dashboard_repository.dart';
import 'package:clima_app/modules/features/folders/args/args_create.dart';
import 'package:clima_app/shared/helpers/dialog_helpers.dart';
import 'package:get/get.dart';

class NewFolderController extends GetxController {
  final DashboardController dashController;
  final DashboardRepository _repo;
  final ArgsCreateFolder args;

  NewFolderController(this.dashController, this._repo, this.args);

  static NewFolderController get i => Get.find();

  final RxString name = ''.obs;

  @override
  void onReady() {
    super.onReady();

    name.value = args.data?.name ?? '';
  }

  Future<void> createFolder() async {
    try {
      DialogHelpers.loading();

      final res = await _repo.createFolder(
        dashController.args.optionMenu,
        params: ParamsCreateFolder(
          id: null,
          name: name.value,
          dateTime: DateTime.now().toIso8601String(),
        ),
      );

      DialogHelpers.loadingClose();

      if (res == 200) {
        DialogHelpers.problem(
          title: 'Berhail',
          desc: 'Berhasil menyimpan data',
          onOk: () => Get.close(2),
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

  Future<void> editFolder() async {
    try {
      DialogHelpers.loading();

      final res = await _repo.editFolder(
        dashController.args.optionMenu,
        idFolder: dashController.folderSelected.value.id!,
        params: ParamsCreateFolder(
          id: args.data?.id,
          name: name.value,
          dateTime: DateTime.now().toIso8601String(),
        ),
      );

      DialogHelpers.loadingClose();

      if (res == 200) {
        DialogHelpers.problem(
          title: 'Berhail',
          desc: 'Berhasil menyimpan data',
          onOk: () => Get.close(2),
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
}
