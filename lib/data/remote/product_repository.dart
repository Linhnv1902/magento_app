import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/app_config.dart';
import 'package:magento_app/common/config/network/api_endpoints.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/cms_block_response_model.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/domain/models/products_response_model.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class ProductRepository {
  final Dio _dio;

  ProductRepository(this._dio);

  Future<ProductsResponseModel?> getProductsWithAttribute(
      {int pageSize = 10,
      int currentPage = 1,
      Map<String, dynamic>? filters,
      Map<String, dynamic>? sortOrders,
      String? fields}) async {
    Map<String, dynamic> _params = {
      searchKeyPageSize: pageSize,
      searchKeyCurrentPage: currentPage,
    };

    if (filters != null) {
      _params.addAll(filters);
    }

    if (sortOrders != null) {
      _params.addAll(sortOrders);
    }

    if (fields != null) {
      _params.addAll({searchKeyFields: fields});
    }

    debugPrint('=====$_params');

    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.getProducts}',
          queryParameters: _params,
          options: Options(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
          ));
      if (result.statusCode == 200) {
        final ProductsResponseModel response =
            ProductsResponseModel.fromJson(result.data);
        return response;
      }
      // showTopSnackBarError(Get.context!,
      //     result.statusMessage ?? TransactionConstants.unknownError.tr);
      return null;
    } catch (e) {
      //showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      debugPrint(e.toString());
      return null;
    }
  }

  String getSearchKey({
    int pageSize = 10,
    int currentPage = 1,
    String? conditionType,
    String? attributeCode,
    String? attributeValue,
    String? fields,
  }) {
    debugPrint('-----------$currentPage');
    String searchKey =
        '$searchKeyCurrentPage=$currentPage&$searchKeyPageSize=$pageSize';

    if (attributeCode != null)
      searchKey += '&${searchKeyFieldName}=$attributeCode';

    if (attributeValue != null)
      searchKey += '&${searchKeyFieldValue}=$attributeValue';

    if (conditionType != null)
      searchKey += '&${searchKeyConditionType}=$conditionType';

    if (fields != null) searchKey += '&${searchKeyFields}=$fields';

    debugPrint('-----------$searchKey');
    return searchKey;
  }

  Future<ProductModel?> getProductDetail({required String sku}) async {
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.getProducts}/$sku',
          options: Options(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
          ));
      if (result.statusCode == 200) {
        final ProductModel response = ProductModel.fromJson(result.data);
        return response;
      }
      //    showTopSnackBarError(Get.context!,
      //        result.statusMessage ?? TransactionConstants.unknownError.tr);
      return null;
    } catch (e) {
      //   showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      debugPrint(e.toString());
      return null;
    }
  }
}
