import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void clearControllers() {
    titleController.clear();
    priceController.clear();
    descriptionController.clear();
  }

  var collectionData = [].obs;
  var isLoading = false.obs;
  late Uri _imageUrl;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('koleksi').get();
      collectionData.value =
          querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch data: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadAndDisplayImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        File imageFile = File(pickedFile.path);
        final path = "files/" +
            DateTime.now().millisecondsSinceEpoch.toString() +
            ".jpg";
        final ref = FirebaseStorage.instance.ref().child(path);

        await ref.putFile(imageFile);

        String downloadUrl = await ref.getDownloadURL();

        _imageUrl =
            Uri.parse(downloadUrl); // Simpan URL gambar ke dalam _imageUrl

        Get.snackbar(
          'Upload Berhasil',
          'Gambar berhasil diupload',
          backgroundColor: const Color.fromARGB(255, 245, 95, 145),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } catch (e) {
        print('Error uploading image: $e');
        Get.snackbar(
          'Error',
          'Terjadi kesalahan saat mengunggah gambar',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      print('No image selected.');
    }
  }

  Future<void> addDataToFirestore(
      String title, String price, String description) async {
    try {
      // Unggah gambar terlebih dahulu
      await uploadAndDisplayImage();

      // Tambahkan data ke Firestore setelah mendapatkan URL gambar
      await _firestore.collection('koleksi').add({
        'title': title,
        'price': price,
        'description': description,
        'image': _imageUrl.toString(), // Gunakan URL gambar dari _imageUrl
      });

      fetchData();
      Get.snackbar(
        'Success',
        'Data added successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Membersihkan controller setelah data ditambahkan
      clearControllers();
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to add data: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
