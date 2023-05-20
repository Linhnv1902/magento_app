import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/usecases/cart_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/cart/cart_controller.dart';
import 'package:magento_app/presentation/journey/estimate_shipping/estimate_shipping_controller.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/journey/payment/payment_controller.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class CheckoutController extends GetxController with MixinController {
  Rx<LoadedType> rxLoadedList = LoadedType.finish.obs;

  Rx<LoadedType> rxLoadedButton = LoadedType.finish.obs;

  final mainController = Get.find<MainController>();
  final cartController = Get.find<CartController>();
  final shippingController = Get.find<EstimateShippingController>();
  final paymentController = Get.find<PaymentController>();
  final CartUseCase cartUseCase;

  CheckoutController({required this.cartUseCase});

  Future<void> saveInfo() async {
    rxLoadedButton.value = LoadedType.start;
    var paypalId;
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      rxLoadedButton.value = LoadedType.finish;
      return;
    }

    if ((paymentController.selectedMethod.value.code ?? '')
        .contains('paypal')) {
      await Get.toNamed(AppRoutes.paypal)?.then((value) => paypalId = value);
      debugPrint('------------$paypalId');

      if (paypalId == null) {
        rxLoadedButton.value = LoadedType.finish;
        return;
      }
    }

    final result = await cartUseCase.createOrder(
      payment: paymentController.selectedMethod.value,
      customer: mainController.rxCustomer.value!,
      address: shippingController.address!,
      paypalId: paypalId,
    );

    if (result != null) {
      debugPrint('cập nhật thành công');
      await cartController.createCart();
      showTopSnackBar(context,
          message: TransactionConstants.orderSuccessMessage.tr,
          type: SnackBarType.done);
      Get.offAllNamed(AppRoutes.main);
    }
    rxLoadedButton.value = LoadedType.finish;
  }
}
