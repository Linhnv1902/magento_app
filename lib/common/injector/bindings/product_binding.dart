import 'package:get/get.dart';
import 'package:magento_app/common/injector/locators/app_locator.dart';
import 'package:magento_app/presentation/journey/product/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<ProductController>());
  }
}