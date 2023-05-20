import 'package:get/get.dart';
import 'package:magento_app/common/injector/locators/app_locator.dart';
import 'package:magento_app/presentation/journey/my_orders/my_orders_controller.dart';

class MyOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<MyOrdersController>());
  }
}