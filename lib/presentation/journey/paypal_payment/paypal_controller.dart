import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/usecases/cart_usecase.dart';
import 'package:get/get.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/cart/cart_controller.dart';
import 'package:magento_app/presentation/journey/estimate_shipping/estimate_shipping_controller.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/journey/payment/payment_controller.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class PaypalController extends GetxController with MixinController {
  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;

  final CartUseCase cartUseCase;

  Rx<String?> checkoutUrl = (null as String?).obs;
  Rx<String?> executeUrl = (null as String?).obs;
  Rx<String?> accessToken = (null as String?).obs;
  final shippingController = Get.find<EstimateShippingController>();
  final paymentController = Get.find<PaymentController>();

  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';
  final mainController = Get.find<MainController>();

  PaypalController({required this.cartUseCase});

  Map<String, dynamic> getOrderParams() {
    final shippingController = Get.find<EstimateShippingController>();
    final paymentController = Get.find<PaymentController>();
    final cartController = Get.find<CartController>();
    List items = [];

    cartController.items.value.forEach((element) {
      items.add({
        "name": element.name,
        "quantity": element.qty,
        "price": element.price,
        "currency": defaultCurrency["currency"]
      });
    });

    // checkout invoice details
    String tax =
        (paymentController.shippingInfor?.totals?.taxAmount ?? 0).toString();
    String subTotalAmount =
        ((paymentController.shippingInfor?.totals?.subtotal ?? 0)).toString();
    String totalAmount =
        (paymentController.shippingInfor?.totals?.baseGrandTotal ?? 0)
            .toString();
    String shippingCost =
        (paymentController.shippingInfor?.totals?.shippingAmount ?? 0)
            .toString();
    int shippingDiscountCost = 0;
    String userFirstName = shippingController.address?.firstname ?? '';
    String userLastName = shippingController.address?.lastname ?? '';
    String addressCity = shippingController.address?.city ?? '';
    String addressStreet = shippingController.address?.street?.first ?? '';
    String addressZipCode = '44000';
    String addressCountry = shippingController.address?.countryId ?? '';
    String addressState = '';
    String addressPhoneNumber = shippingController.address?.telephone ?? '';

    debugPrint('----$totalAmount----$subTotalAmount----$shippingCost');
    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "tax": tax,
              "shipping": shippingCost,
              "handling_fee": "0",
              "insurance": "0",
              "shipping_discount": "0"
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": userFirstName + " " + userLastName,
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  Future<void> initPayment() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }

    try {
      accessToken.value = await cartUseCase.getAccessToken();

      final transactions = getOrderParams();
      final res = await cartUseCase.createPaypalPayment(
          transactions, accessToken.value ?? '');
      if (res != null) {
        checkoutUrl.value = res["approvalUrl"];
        executeUrl.value = res["executeUrl"];
      }
    } catch (ex) {
      showTopSnackBarError(context, ex.toString());
    }
  }

  @override
  void onInit() {
    initPayment();
  }
}
