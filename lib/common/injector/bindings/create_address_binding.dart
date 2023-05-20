import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/journey/create_address/create_address_controller.dart';

class CreateAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<CreateNewAddressController>());
  }
}
