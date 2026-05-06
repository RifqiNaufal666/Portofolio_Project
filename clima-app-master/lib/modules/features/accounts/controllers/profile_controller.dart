import 'dart:io';

import 'package:clima_app/configs/pages/app_routes.dart';
import 'package:clima_app/shared/extension/spacing_widget.dart';
import 'package:clima_app/shared/helpers/dialog_helpers.dart';
import 'package:clima_app/shared/widgets/buttons/app_button.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends GetxController {
  static ProfileController get i => Get.find();

  late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  User? get user => FirebaseAuth.instance.currentUser;

  final RxString name = ''.obs;
  final Rx<File> fileImage = File('').obs;

  Future<void> selectImage() async {
    ImagePicker picker = ImagePicker();

    await Get.bottomSheet(Padding(
      padding: 12.0.allEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            label: 'Kamera',
            onPressed: () async {
              try {
                if (await Permission.camera.isPermanentlyDenied) {
                  openAppSettings();
                  return;
                }

                if (!(await Permission.camera.request()).isGranted) return;

                final res = await picker.pickImage(source: ImageSource.camera);

                if (res?.path.isEmpty ?? true) return;

                fileImage.value = File(res!.path);
                Get.back();
              } catch (_) {
                Get.back();
                DialogHelpers.problem(
                  title: 'Gagal',
                  desc: 'Gagal ambil gambar',
                );
              }
            },
          ),
          AppButton(
            label: 'Galeri',
            onPressed: () async {
              try {
                if (Platform.isIOS) {
                  if (await Permission.photos.isPermanentlyDenied) {
                    openAppSettings();
                    return;
                  }

                  if (!(await Permission.photos.request()).isGranted) return;
                } else {
                  final androidInfo = await DeviceInfoPlugin().androidInfo;

                  if (androidInfo.version.sdkInt <= 32) {
                    if (await Permission.storage.isPermanentlyDenied) {
                      openAppSettings();
                      return;
                    }

                    if (!(await Permission.storage.request()).isGranted) return;
                  } else {
                    if (await Permission.photos.isPermanentlyDenied) {
                      openAppSettings();
                      return;
                    }

                    if (!(await Permission.photos.request()).isGranted) return;
                  }
                }

                final res = await picker.pickImage(source: ImageSource.gallery);

                if (res?.path.isEmpty ?? true) return;

                fileImage.value = File(res!.path);

                Get.back();
              } catch (_) {
                Get.back();
                DialogHelpers.problem(
                  title: 'Gagal',
                  desc: 'Gagal ambil gambar',
                );
              }
            },
          ),
        ],
      ),
    ));

    update();
  }

  Future<void> updateProfile() async {
    try {
      DialogHelpers.loading();

      if (name.isNotEmpty) {
        await user?.updateDisplayName(name.value);
      }

      if (fileImage.value.path.isNotEmpty) {
        await firebaseStorage
            .ref(user?.uid)
            .child(user?.displayName ?? '-')
            .putFile(fileImage.value);

        String url = await firebaseStorage
            .ref(user?.uid)
            .child(user?.displayName ?? '-')
            .getDownloadURL();

        await user?.updatePhotoURL(url);

        Future.delayed(const Duration(seconds: 2));
        update();
      }

      DialogHelpers.loadingClose();

      name.value = '';
      fileImage.value = File('');
    } catch (e) {
      DialogHelpers.loadingClose();
      DialogHelpers.problem(
        title: 'Gagal',
        desc: e.toString(),
      );
    }
  }

  Future<void> onLogout() async {
    DialogHelpers.confirmation(
      title: 'Logout',
      desc: 'Keluar dari App?',
      textOk: 'Keluar',
      textCancel: 'Batal',
      onOk: _logout,
    );
  }

  Future<void> _logout() async {
    Get.back();

    try {
      DialogHelpers.loading();
      await firebaseAuth.signOut();
      DialogHelpers.loadingClose();

      Get.offAllNamed(AppRoutes.login);
    } on Exception catch (_) {
      DialogHelpers.loadingClose();
    }
  }
}
