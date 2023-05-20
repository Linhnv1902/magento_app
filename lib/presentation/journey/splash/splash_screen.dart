import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/presentation/theme/export.dart';

import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Stack(
        children: [
          Center(
              child: Text(
            'SimiCart',
            style: ThemeText.bodyStrong.s24.orange,
          )),
        ],
      ),
    );
  }
}
