import 'dart:developer';

import 'package:clima_app/modules/features/dashboard/models/files_res/files_res.dart';
import 'package:clima_app/modules/features/dashboard/models/folders_res/folders_res.dart';
import 'package:clima_app/modules/features/dashboard/params/params_create_file.dart';
import 'package:clima_app/modules/features/dashboard/params/params_create_folder.dart';
import 'package:clima_app/shared/enums/menus_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardRepository {
  FirebaseFirestore get instance => FirebaseFirestore.instance;
  User? get user => FirebaseAuth.instance.currentUser;

  Future<int> createFolder(
    OptionMenusEnum option, {
    required ParamsCreateFolder params,
  }) async {
    try {
      String collection =
          option == OptionMenusEnum.buletin ? 'buletin' : 'six_mouth';

      final res1 = await instance
          .collection('/default/${user?.uid}/reports/$collection/${user?.uid}')
          .add(params.toMap());

      await instance
          .doc(
              '/default/${user?.uid}/reports/$collection/${user?.uid}/${res1.id}')
          .update({'id': res1.id});

      return 200;
    } catch (_) {
      log(_.toString());

      rethrow;
    }
  }

  Future<int> editFolder(
    OptionMenusEnum option, {
    required String idFolder,
    required ParamsCreateFolder params,
  }) async {
    try {
      String collection =
          option == OptionMenusEnum.buletin ? 'buletin' : 'six_mouth';

      await instance
          .doc(
              '/default/${user?.uid}/reports/$collection/${user?.uid}/$idFolder')
          .update(params.toMap());

      return 200;
    } catch (_) {
      log(_.toString());
      rethrow;
    }
  }

  Future<int> editFile(
    OptionMenusEnum option, {
    required String idFolder,
    required String idFile,
    required ParamsCreateFile params,
  }) async {
    try {
      String collection =
          option == OptionMenusEnum.buletin ? 'buletin' : 'six_mouth';

      await instance
          .doc(
              '/default/${user?.uid}/reports/$collection/${user?.uid}/$idFolder/files/$idFile')
          .update(params.toMap());

      return 200;
    } catch (_) {
      log(_.toString());

      rethrow;
    }
  }

  Future<int> createFile(
    OptionMenusEnum option, {
    required String idFolder,
    required ParamsCreateFile params,
  }) async {
    try {
      String collection =
          option == OptionMenusEnum.buletin ? 'buletin' : 'six_mouth';

      final res1 = await instance
          .collection(
              '/default/${user?.uid}/reports/$collection/${user?.uid}/$idFolder/files')
          .add(params.toMap());

      await instance
          .doc(
              '/default/${user?.uid}/reports/$collection/${user?.uid}/$idFolder/files/${res1.id}')
          .update({'id': res1.id});

      return 200;
    } catch (_) {
      log(_.toString());

      rethrow;
    }
  }

  Future<int> deleteFiles(
    OptionMenusEnum option, {
    required String idFolder,
    required List<String> itemsId,
  }) async {
    try {
      String collection =
          option == OptionMenusEnum.buletin ? 'buletin' : 'six_mouth';

      final batch = instance.batch();

      final res = await instance
          .collection(
              '/default/${user?.uid}/reports/$collection/$idFolder/files')
          .get();

      for (var doc in res.docs) {
        if (itemsId.contains(doc.id)) {
          batch.delete(doc.reference);
        }
      }

      await batch.commit();

      return 200;
    } catch (_) {
      log(_.toString());

      rethrow;
    }
  }

  Future<int> deleteFolders(
    OptionMenusEnum option, {
    required List<String> itemsId,
  }) async {
    try {
      String collection =
          option == OptionMenusEnum.buletin ? 'buletin' : 'six_mouth';

      final batch = instance.batch();

      final res = await instance
          .collection('/default/${user?.uid}/reports/$collection')
          .get();

      for (var doc in res.docs) {
        if (itemsId.contains(doc.id)) {
          batch.delete(doc.reference);
        }
      }

      await batch.commit();

      return 200;
    } catch (_) {
      log(_.toString());

      rethrow;
    }
  }

  Future<List<DataFolder>> getFolders(OptionMenusEnum option) async {
    try {
      String collection =
          option == OptionMenusEnum.buletin ? 'buletin' : 'six_mouth';

      final res = await instance
          .collection('/default/${user?.uid}/reports/$collection/${user?.uid}')
          .orderBy('datetime')
          .get();

      return res.docs.map((e) => DataFolder.fromJson(e.data())).toList();
    } catch (_) {
      log(_.toString());

      rethrow;
    }
  }

  Future<List<DataFile>> getFiles(
    OptionMenusEnum option, {
    required String idFolder,
  }) async {
    try {
      String collection =
          option == OptionMenusEnum.buletin ? 'buletin' : 'six_mouth';

      final res = await instance
          .collection(
              '/default/${user?.uid}/reports/$collection/${user?.uid}/$idFolder/files')
          .orderBy('datetime')
          .get();

      return res.docs.map((e) => DataFile.fromJson(e.data())).toList();
    } catch (_) {
      log(_.toString());

      rethrow;
    }
  }
}
