import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';

mixin MixinController {
  late BuildContext context;
  Rx<LoadedType> rxLoadedType = LoadedType.finish.obs;
  Timer? timerLoading;

  void startLoading({int? timeout}) {
    rxLoadedType.value = LoadedType.start;
    timerLoading = Timer(Duration(seconds: timeout ?? 60), finishLoading);
  }

  void finishLoading() {
    rxLoadedType.value = LoadedType.finish;
  }

  void setStatusBarStyle({StatusBarStyleType statusBarStyleType = StatusBarStyleType.dark}) {
    StatusBarStyle().setStatusBarStyle(StyleOfStatusBarContent(statusBarStyleType));
  }
}
