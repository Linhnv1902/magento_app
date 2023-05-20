import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/journey/estimate_shipping/estimate_shipping_controller.dart';

class EstimateShippingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<EstimateShippingController>());
  }
}
