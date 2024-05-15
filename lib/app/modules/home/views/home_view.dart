import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ujikom/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 1, 64),
        title: const Text(
          'Koleksi Punyaku',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              Get.back();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('user_uid');
              Get.offNamed(Routes.SPLASHSCREEN);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Obx(() {
            if (_homeController.isLoading.value) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemCount: _homeController.collectionData.length,
                itemBuilder: (context, index) {
                  var data = _homeController.collectionData[index];
                  return ListTile(
                    title: Text(data['title']),
                    subtitle: Text(data['description']),
                  );
                },
              );
            }
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            AlertDialog(
              title: Text("Tambah Koleksi"),
              content: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          String imageUrl =
                              await _homeController.uploadAndDisplayImage();
                          setState(() {});
                        },
                        child: Text("Pilih Gambar"),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _homeController.titleController,
                        decoration: InputDecoration(hintText: "Masukkan judul"),
                      ),
                      TextField(
                        controller: _homeController.priceController,
                        decoration: InputDecoration(hintText: "Masukkan harga"),
                      ),
                      TextField(
                        controller: _homeController.descriptionController,
                        decoration:
                            InputDecoration(hintText: "Masukkan deskripsi"),
                      ),
                    ],
                  );
                },
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    print("object");
                    _homeController.addDataToFirestore(
                      _homeController.titleController.text,
                      _homeController.priceController.text,
                      _homeController.descriptionController.text,
                    );

                  
                  },
                  child: Text("Tambah"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _homeController.clearControllers();
                    Get.back();
                  },
                  child: Text("Batal"),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
