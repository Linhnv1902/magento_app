import 'package:get/get.dart';
import 'package:magento_app/common/injector/locators/app_locator.dart';
import 'package:magento_app/presentation/journey/account/account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<AccountController>());
  }
}
