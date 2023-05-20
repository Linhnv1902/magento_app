import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/network/api_endpoints.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/cms_block_response_model.dart';
import 'package:magento_app/domain/models/store_config_response_model.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class HomeRepository {
  final Dio _dio;

  HomeRepository(this._dio);

  Future<CmsBlockResponse> getHomeData() async {
    final result =
        await _dio.request('${NetworkConfig.baseUrl}${ApiEndpoints.cmsHome}',
            options: Options(
              method: 'GET',
              headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
            ));
    final CmsBlockResponse response = CmsBlockResponse.fromJson(result.data);
    debugPrint('-----------${jsonDecode(response.content ?? '')}');
    return response;
  }

  Future<StoreConfigResponseModel?> getStoreConfig() async {
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.getStoreConfig}',
          options: Options(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
          ));

      if (result.statusCode == 200) {
        final storeConfig =
            StoreConfigResponseModel.fromJson(result.data.first);
        return storeConfig;
      }

      // showTopSnackBarError(Get.context!,
      //     result.statusMessage ?? TransactionConstants.unknownError.tr);
      return null;
    } catch (e) {
   //   showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      debugPrint(e.toString());
      return null;
    }
  }
}
