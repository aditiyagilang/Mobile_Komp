import 'package:get/get.dart';
import 'package:ujikom/app/routes/app_pages.dart';

class SplashscreenController extends GetxController {
  //TODO: Implement SplashscreenController

  void goToNextPage() {
    Get.offNamed(Routes.LOGIN);
  }
}
