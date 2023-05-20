import 'package:get/get.dart';
import 'package:magento_app/common/injector/locators/app_locator.dart';
import 'package:magento_app/presentation/journey/paypal_payment/paypal_controller.dart';

class PaypalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<PaypalController>());
  }
}
