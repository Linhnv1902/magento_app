import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/journey/category/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<CategoryController>());
  }
}
