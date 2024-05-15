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
                 return InkWell(
  onTap: () {

    var clickedData = _homeController.collectionData[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(clickedData['title']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                clickedData['image'],
                height: 100,
              ),
              Text(clickedData['price']),
              Text(clickedData['description']),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Tambahkan logika untuk menghapus data
                // Misalnya:
                _homeController.deleteData(clickedData['id']);
                Get.back();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                // Tambahkan logika untuk tombol close
                Get.back();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  },
  child: ListTile(
    title: Column(
      children: [
        Image.network(
          data['image'],
          height: 100,
        ),
        Text(data['title']),
        Text(data['price']),
      ],
    ),
    subtitle: Text(data['description']),
  ),
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
                    _homeController.addDataToFirestore(
                      _homeController.titleController.text,
                      _homeController.priceController.text,
                      _homeController.descriptionController.text,
                    );
                    Get.back();
                  },
                  child: Text("Tambah"),
                ),
                ElevatedButton(
                  onPressed: () {
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
