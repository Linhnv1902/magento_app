import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:dio/dio.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class DioInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    if(err.response?.statusCode == 401)
      {
        showTopSnackBarError(getx.Get.context!,
            ('Session Expired').toString());
        getx.Get.offAllNamed(AppRoutes.login);
      }
    debugPrint('------------${err.response.toString()}');
    showTopSnackBarError(getx.Get.context!,
        (jsonDecode(err.response.toString())['message'] ?? '').toString());
  }
}
