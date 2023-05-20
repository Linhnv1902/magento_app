import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/journey/addresses_list/address_controller.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<AddressController>());
  }
}