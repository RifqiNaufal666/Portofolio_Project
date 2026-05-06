import 'package:clima_app/modules/features/dashboard/models/files_res/files_res.dart';
import 'package:clima_app/modules/features/dashboard/models/folders_res/folders_res.dart';
import 'package:clima_app/shared/enums/create_enum.dart';

class ArgsCreateFile {
  final CreateEnum mode;
  final DataFile? data;

  ArgsCreateFile.create()
      : mode = CreateEnum.create,
        data = null;

  ArgsCreateFile.edit({required this.data}) : mode = CreateEnum.edit;
}

class ArgsCreateFolder {
  final CreateEnum mode;
  final DataFolder? data;

  ArgsCreateFolder.create()
      : mode = CreateEnum.create,
        data = null;

  ArgsCreateFolder.edit({required this.data}) : mode = CreateEnum.edit;
}
