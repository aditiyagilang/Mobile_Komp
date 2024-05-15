import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ujikom/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController copasswordController = TextEditingController();

  final RxBool emailError = false.obs;
  final RxBool usernameError = false.obs;
  final RxBool passwordError = false.obs;
  final RxBool copasswordError = false.obs;
  RxBool obsecuretext = true.obs;
  RxBool obsecuretext2 = true.obs;

  void toggleObsecureText() {
    obsecuretext.value = !obsecuretext.value;
  }

  void toggleObsecureText2() {
    obsecuretext2.value = !obsecuretext2.value;
  }

  bool isEmailValid() {
    final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailPattern.hasMatch(emailController.text);
  }

  Future<void> registerUser() async {
    if (emailController.text.trim().isEmpty ||
        usernameController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        copasswordController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'All fields are required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (passwordController.text.trim() != copasswordController.text.trim()) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
    
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await userCredential.user!.sendEmailVerification();

   
      await _firestore.collection('user').doc(userCredential.user!.uid).set({
        'id': userCredential.user!.uid,
        'email': emailController.text.trim(),
        'username': usernameController.text.trim(),
        'password': passwordController.text.trim(),
      });

  
      Get.snackbar(
        'Success',
        'Registration successful. Please verify your email to login.',
        snackPosition: SnackPosition.BOTTOM,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('new', "1");
    } catch (error) {
  
      Get.snackbar(
        'Error',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    copasswordController.dispose();
    super.onClose();
  }
}
