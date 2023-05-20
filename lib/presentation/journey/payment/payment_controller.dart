import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/customer_model.dart';
import 'package:magento_app/domain/models/estimate_shipping_methods_model.dart';
import 'package:magento_app/domain/models/save_shipping_method_response_model.dart';
import 'package:magento_app/domain/usecases/cart_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/cart/cart_controller.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/widgets/export.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PaymentController extends GetxController with MixinController {
  Rx<LoadedType> rxLoadedList = LoadedType.finish.obs;

  Rx<LoadedType> rxLoadedButton = LoadedType.finish.obs;
  RxList<PaymentMethods> methods = <PaymentMethods>[].obs;

  final RefreshController productRefreshController =
      RefreshController(initialRefresh: false);
  final mainController = Get.find<MainController>();
  final cartController = Get.find<CartController>();

  Rx<PaymentMethods> selectedMethod = PaymentMethods().obs;
  SaveShippingMethodResponseModel? shippingInfor;

  Future<void> getMethods() async {
    rxLoadedList.value = LoadedType.start;
    methods.clear();

    methods.addAll(shippingInfor?.paymentMethods ?? []);
    if (methods.isNotEmpty) {
      selectedMethod.value = methods.first;
    }

    rxLoadedList.value = LoadedType.finish;
  }

  updateSelectedMethod(PaymentMethods method) {
    selectedMethod.value = method;
  }

  Future<void> saveInfo() async {
    // rxLoadedButton.value = LoadedType.start;
    //
    // var connectivityResult = await Connectivity().checkConnectivity();
    // if (connectivityResult == ConnectivityResult.none) {
    //   showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
    //   rxLoadedButton.value = LoadedType.finish;
    //   return;
    // }
    //
    // final result = await cartUseCase.addShippingInformation(
    //     shippingMethod: selectedMethod.value,
    //     customer: mainController.rxCustomer.value!,
    //     address: address!);
    //
    // if (result != null) {
    //   debugPrint('cập nhật thành công');
    //   Get.toNamed(AppRoutes.payment, arguments: result);
    //   //  await accountUsecase.savePass(newPwdController.text.trim());
    //   // showTopSnackBar(context,
    //   //     message: TransactionConstants.successfully.tr,
    //   //     type: SnackBarType.done);
    //   // Get.back();
    // }
    rxLoadedButton.value = LoadedType.finish;
  }

  @override
  void onInit() {
    super.onInit();
    shippingInfor = Get.arguments;
  }

  @override
  void onReady() async {
    super.onReady();

    await getMethods();
  }
}
