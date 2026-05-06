import 'package:clima_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:clima_app/modules/features/dashboard/params/params_create_file.dart';
import 'package:clima_app/modules/features/dashboard/repositories/dashboard_repository.dart';
import 'package:clima_app/modules/features/folders/args/args_create.dart';
import 'package:clima_app/shared/helpers/dialog_helpers.dart';
import 'package:get/get.dart';

class NewFileController extends GetxController {
  final DashboardController dashController;
  final DashboardRepository _repo;
  final ArgsCreateFile args;

  NewFileController(this.dashController, this._repo, this.args);

  static NewFileController get i => Get.find();

  final RxString name = ''.obs;
  final RxString linkUrl = ''.obs;

  @override
  void onReady() {
    super.onReady();

    name.value = args.data?.name ?? '';
    linkUrl.value = args.data?.linkUrl ?? '';
  }

  Future<void> createFile() async {
    try {
      DialogHelpers.loading();

      final res = await _repo.createFile(
        dashController.args.optionMenu,
        idFolder: dashController.folderSelected.value.id!,
        params: ParamsCreateFile(
          id: '',
          name: name.value,
          dateTime: DateTime.now().toIso8601String(),
          linkUrl: linkUrl.value,
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

  Future<void> editFile() async {
    try {
      DialogHelpers.loading();

      final res = await _repo.editFile(
        dashController.args.optionMenu,
        idFolder: dashController.folderSelected.value.id!,
        idFile: args.data!.id!,
        params: ParamsCreateFile(
          id: args.data!.id!,
          name: name.value,
          dateTime: args.data!.dateTime!.toIso8601String(),
          updateAt: DateTime.now().toIso8601String(),
          linkUrl: linkUrl.value,
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
