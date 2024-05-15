import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ujikom/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool emailError = false.obs;
  final RxBool passwordError = false.obs;
  final RxString errorMessage = ''.obs;
  RxBool obsecuretext = false.obs;

  void toggleObsecureText() {
    obsecuretext.value = !obsecuretext.value;
  }

  bool isEmailValid() {
    final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailPattern.hasMatch(emailController.text);
  }

  Future<void> signInWithEmailAndPassword() async {
    // Reset errors
    emailError.value = false;
    passwordError.value = false;

    // Validasi email dan password tidak boleh kosong
    if (emailController.text.trim().isEmpty) {
      emailError.value = true;
    }
    if (passwordController.text.trim().isEmpty) {
      passwordError.value = true;
    }
    if (emailError.value || passwordError.value) {
      Get.snackbar(
        'Error',
        'Email dan password harus diisi',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Simpan UID pengguna ke dalam SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user_uid', userCredential.user!.uid);
      prefs.setString('new', "1");

      // Navigasi ke halaman utama setelah berhasil login
      Get.offNamed(Routes.HOME);
    } catch (error) {
      String errorMsg;
      if (error.toString().contains('user-not-found')) {
        errorMsg = 'Email tidak ditemukan';
      } else if (error.toString().contains('wrong-password')) {
        errorMsg = 'Password salah';
      } else {
        errorMsg = 'Terjadi kesalahan saat login';
      }
      Get.snackbar(
        'Error',
        errorMsg,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
