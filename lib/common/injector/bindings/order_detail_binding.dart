import 'package:get/get.dart';
import 'package:magento_app/common/injector/locators/app_locator.dart';
import 'package:magento_app/presentation/journey/my_order_detail/my_order_detail_controller.dart';

class OrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<OrderDetailController>());
  }
}
