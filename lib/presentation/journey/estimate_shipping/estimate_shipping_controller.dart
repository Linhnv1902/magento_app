import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/customer_model.dart';
import 'package:magento_app/domain/models/estimate_shipping_methods_model.dart';
import 'package:magento_app/domain/usecases/cart_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/cart/cart_controller.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/widgets/export.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EstimateShippingController extends GetxController with MixinController {
  Rx<LoadedType> rxLoadedList = LoadedType.finish.obs;

  Rx<LoadedType> rxLoadedButton = LoadedType.finish.obs;
  RxList<EstimateShippingMethodsModel> methods =
      <EstimateShippingMethodsModel>[].obs;

  final RefreshController productRefreshController =
      RefreshController(initialRefresh: false);
  final mainController = Get.find<MainController>();
  final cartController = Get.find<CartController>();

  Rx<EstimateShippingMethodsModel> selectedMethod =
      EstimateShippingMethodsModel().obs;

  final CartUseCase cartUseCase;

  Addresses? address;

  EstimateShippingController({required this.cartUseCase});

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

  Future<void> getMethods() async {
    rxLoadedList.value = LoadedType.start;
    methods.clear();
    final result = await cartUseCase.getEstimateShippingMethods(
        addressId: address?.id ?? 0);

    methods.value = result;
    if (methods.isNotEmpty) {
      selectedMethod.value = methods.first;
    }

    rxLoadedList.value = LoadedType.finish;
  }

  updateSelectedMethod(EstimateShippingMethodsModel method) {
    selectedMethod.value = method;
  }

  Future<void> saveInfo() async {
    rxLoadedButton.value = LoadedType.start;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      rxLoadedButton.value = LoadedType.finish;
      return;
    }

    final result = await cartUseCase.addShippingInformation(
        shippingMethod: selectedMethod.value,
        customer: mainController.rxCustomer.value!,
        address: address!);

    if (result != null) {
      debugPrint('cập nhật thành công');
      Get.toNamed(AppRoutes.payment, arguments: result);
      //  await accountUsecase.savePass(newPwdController.text.trim());
      // showTopSnackBar(context,
      //     message: TransactionConstants.successfully.tr,
      //     type: SnackBarType.done);
      // Get.back();
    }
    rxLoadedButton.value = LoadedType.finish;
  }

  @override
  void onInit() {
    super.onInit();
    address = Get.arguments;
  }

  @override
  void onReady() async {
    super.onReady();

    await getMethods();
  }
}
