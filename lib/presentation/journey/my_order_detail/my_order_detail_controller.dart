import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/domain/models/get_all_orders_response_model.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';

class OrderDetailController extends GetxController with MixinController {
  OrderDetail? orderDetail;

  @override
  void onInit() async {
    super.onInit();
    orderDetail = Get.arguments;
  }
}
