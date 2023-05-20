import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/presentation/journey/paypal_payment/paypal_controller.dart';
import 'package:magento_app/presentation/widgets/export.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PaypalScreen extends GetView<PaypalController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PaypalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Obx(() {
      if (controller.checkoutUrl.value != null) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            leading: GestureDetector(
              child: const Icon(Icons.arrow_back_ios),
              onTap: () => Get.back(),
            ),
          ),
          body: WebView(
            initialUrl: controller.checkoutUrl.value,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
              if (request.url.contains(controller.returnURL)) {
                final uri = Uri.parse(request.url);
                final payerID = uri.queryParameters['PayerID'];
                if (payerID != null) {
                  controller.cartUseCase
                      .executePayment(
                          Uri.parse(controller.executeUrl.value ?? ''),
                          payerID,
                          controller.accessToken.value)
                      .then((id) {
                    Get.back(result: id);
                  });
                } else {
                  Get.back();
                }
                //  Get.back();
              }
              // if (request.url.contains(controller.cancelURL)) {
              //  Get.back();
              // }
              return NavigationDecision.navigate;
            },
          ),
          // sb-napaw15891962@personal.example.com
          // 6*g)qF<S
        );
      } else {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                }),
            backgroundColor: Colors.black12,
            elevation: 0.0,
          ),
          body: const Center(child: AppLoadingWidget()),
        );
      }
    });
  }
}
