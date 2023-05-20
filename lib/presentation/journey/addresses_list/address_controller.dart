import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddressController extends GetxController with MixinController {
  Rx<LoadedType> rxLoadedButton = LoadedType.finish.obs;

  final RefreshController productRefreshController =
      RefreshController(initialRefresh: false);
  final mainController = Get.find<MainController>();

  bool isCheckout = false;

  Future<void> onRefresh() async {
    // rxLoadedList.value = LoadedType.start;
    // currentPage.value = 1;
    // products.clear();
    // await getProductList();
    //  await onSearch(searchController.text.trim());
    await mainController.getUserProfile();
    productRefreshController.refreshCompleted();
    // rxLoadedList.value = LoadedType.finish;
  }

  @override
  void onInit() {
    super.onInit();
    isCheckout = Get.arguments ?? false;
  }
}
