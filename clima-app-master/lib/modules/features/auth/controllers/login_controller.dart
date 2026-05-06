import 'package:clima_app/configs/pages/app_routes.dart';
import 'package:clima_app/shared/helpers/dialog_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get i => Get.find();

  late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final RxString email = ''.obs, password = ''.obs;
  final RxBool visiblePassword = true.obs;

  void onLogin() async {
    if (email.value.isEmpty) {
      DialogHelpers.problem(
        title: 'Email Kosong',
        desc: 'Email belum dimasukan',
      );
      return;
    }

    if (!email.value.isEmail) {
      DialogHelpers.problem(
        title: 'Email Salah',
        desc: 'Masukan email yang valid',
      );
      return;
    }

    if (password.value.isEmpty) {
      DialogHelpers.problem(
        title: 'Password Kosong',
        desc: 'Password belum dimasukan',
      );

      return;
    }

    try {
      DialogHelpers.loading();

      UserCredential credential = await _login();

      DialogHelpers.loadingClose();

      if (credential.user == null) {
        return;
      }

      Get.toNamed(AppRoutes.optionMenu);
    } on FirebaseAuthException catch (_) {
      DialogHelpers.loadingClose();
      DialogHelpers.problem(
        title: 'Login Gagal',
        desc: _.message ?? 'Ups, sesuatu bermsalah!',
      );
    } on Exception catch (_) {
      DialogHelpers.loadingClose();
      DialogHelpers.problem(
        title: 'Login Gagal',
        desc: _.toString(),
      );
    }
  }

  Future<UserCredential> _login() async {
    return firebaseAuth.signInWithEmailAndPassword(
      email: email.value,
      password: password.value,
    );
  }
}
