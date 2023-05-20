import 'package:get/get.dart';
import 'package:magento_app/common/injector/locators/app_locator.dart';
import 'package:magento_app/presentation/journey/message/message_controller.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<MessageController>());
  }
}
