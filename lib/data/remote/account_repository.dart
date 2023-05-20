import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:magento_app/common/config/network/api_endpoints.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/common/utils/app_utils.dart';
import 'package:magento_app/domain/models/customer_model.dart';
import 'package:magento_app/domain/models/get_all_orders_response_model.dart';
import 'package:magento_app/domain/models/get_messages_response_model.dart';

class AccountRepository {
  final Dio _dio;

  AccountRepository(this._dio);

  Future<String?> login({
    required String username,
    required String password,
  }) async {
    final params = {
      'username': username,
      'password': password,
    };
    try {
      final result =
          await _dio.request('${NetworkConfig.baseUrl}${ApiEndpoints.login}',
              data: params,
              options: Options(
                method: 'POST',
              ));
      if (result.statusCode == 200) {
        return result.data;
      }
      // showTopSnackBarError(Get.context!,
      //     result.statusMessage ?? TransactionConstants.unknownError.tr);
      return null;
    } catch (e) {
      // showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      debugPrint(e.toString());
      return null;
    }
  }

  Future<CustomerModel?> getCustomerInfor(String token) async {
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.getCustomerInfor}',
          options: Options(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
          ));
      if (result.statusCode == 200) {
        return CustomerModel.fromJson(result.data);
      }
      // showTopSnackBarError(Get.context!,
      //     result.statusMessage ?? TransactionConstants.unknownError.tr);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      //showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      return null;
    }
  }

  Future<bool> register({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final params = {
      "customer": {
        "email": username,
        "firstname": firstName,
        "lastname": lastName
      },
      "password": password
    };
    try {
      final result =
          await _dio.request('${NetworkConfig.baseUrl}${ApiEndpoints.customer}',
              data: params,
              options: Options(
                method: 'POST',
              ));
      if (result.statusCode == 200) {
        return true;
      }
      debugPrint('-----------${result.toString()}');
      // showTopSnackBarError(Get.context!,
      //     result.data ?? TransactionConstants.unknownError.tr);
      return false;
    } catch (e) {
      debugPrint(e.toString());
      //  showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      return false;
    }
  }

  Future<CustomerModel?> updateCustomer(
      {required CustomerModel customer}) async {
    final params = {
      "customer": {...customer.toUpdateCustomer()},
    };
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.customer}/${customer.id ?? 0}',
          data: params,
          options: Options(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
          ));
      if (result.statusCode == 200) {
        return CustomerModel.fromJson(result.data);
      }
      // showTopSnackBarError(Get.context!,
      //     result.statusMessage ?? TransactionConstants.unknownError.tr);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      //   showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      return null;
    }
  }

  Future<bool> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
  }) async {
    final params = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    };
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.changePassword}',
          data: params,
          options: Options(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
          ));
      if (result.statusCode == 200) {
        return true;
      }
      // showTopSnackBarError(Get.context!,
      //     result.statusMessage ?? TransactionConstants.unknownError.tr);
      return false;
    } catch (e) {
      debugPrint(e.toString());
      //  showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      return false;
    }
  }

  Future<GetOrdersResponseModel?> getAllOrder({
    int pageSize = 10,
    int currentPage = 1,
    required String email,
  }) async {
    Map<String, dynamic> _params = {
      searchKeyPageSize: pageSize,
      searchKeyCurrentPage: currentPage,
      'searchCriteria[filterGroups][0][filters][0][field]': 'customer_email',
      'searchCriteria[filterGroups][0][filters][0][value]': email,
    };

    debugPrint('=====$_params');

    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.orders}',
          queryParameters: _params,
          options: Options(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
          ));
      if (result.statusCode == 200) {
        final GetOrdersResponseModel response =
            GetOrdersResponseModel.fromJson(result.data);
        return response;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<GetMessagesResponse?> getAllMessage({
    required String customerId,
  }) async {
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.getAllMessage}',
          queryParameters: {'customer_id': customerId},
          options: Options(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
          ));
      if (result.statusCode == 200) {
        final GetMessagesResponse response =
            GetMessagesResponse.fromJson(result.data);
        return response;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> sendMessage({
    required String customerId,
    required String message,
  }) async {
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.sendMessage}',
          queryParameters: {'customer_id': customerId},
          data: {
            "message": {
              "customer_id": customerId,
              "body_msg": message,
              "ip": "42.114.234.144",
              "current_url": "gửi từ diện thoại"
            }
          },
          options: Options(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
          ));
      if (result.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
