import 'package:get/get.dart';
import 'package:magento_app/common/injector/locators/app_locator.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<MainController>());
  }
}
