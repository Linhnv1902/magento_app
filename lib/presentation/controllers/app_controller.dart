import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/widgets/export.dart';
import 'mixin/export.dart';

class AppController extends SuperController with MixinController {
  late String uid;

  Rx<DateTime> rxCurrentBackPressTime = DateTime.now().obs;

  void exitApp(BuildContext context) {
    DateTime now = DateTime.now();
    if (now.difference(rxCurrentBackPressTime.value) >
        const Duration(seconds: 2)) {
      rxCurrentBackPressTime.value = now;
      showTopSnackBar(
        context,
        type: SnackBarType.done,
        message: TransactionConstants.pressBackAgain.tr,
      );
    } else {
      exit(0);
    }
  }

  @override
  void onDetached() {
    logger('---------App State onDetached');
  }

  @override
  void onInactive() {
    logger('---------App State onInactive');
  }

  @override
  void onPaused() {
    logger('---------App State onPaused');
  }

  @override
  void onResumed() {
    logger('---------App State onResumed');
  }
}
