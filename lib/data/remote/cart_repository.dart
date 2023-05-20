import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';
import 'package:magento_app/common/config/network/api_endpoints.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/common/utils/translations/app_translations.dart';
import 'package:magento_app/domain/models/cart_information_model.dart';
import 'package:magento_app/domain/models/customer_model.dart';
import 'package:magento_app/domain/models/estimate_shipping_methods_model.dart';
import 'package:magento_app/domain/models/review_model.dart';
import 'package:magento_app/domain/models/save_shipping_method_response_model.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class CartRepository {
  final Dio _dio;

  CartRepository(this._dio);

  Future<CartInformationModel?> getCartInfor(String token) async {
    try {
      final result =
          await _dio.request('${NetworkConfig.baseUrl}${ApiEndpoints.cart}',
              options: Options(
                method: 'GET',
                headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
              ));
      if (result.statusCode == 200) {
        return CartInformationModel.fromJson(result.data);
      }
      // if (result.statusCode == 404) {
      //   return null;
      // }
      // showTopSnackBarError(Get.context!,
      //     result.statusMessage ?? TransactionConstants.unknownError.tr);
      return null;
    } catch (e) {
      //   showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      debugPrint(e.toString());
      return null;
    }
  }

  Future<int?> createCart(String token) async {
    try {
      final result =
          await _dio.request('${NetworkConfig.baseUrl}${ApiEndpoints.cart}',
              options: Options(
                method: 'POST',
                headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
              ));
      if (result.statusCode == 200) {
        return result.data;
      }
      showTopSnackBarError(Get.context!,
          result.statusMessage ?? TransactionConstants.unknownError.tr);
      return null;
    } catch (e) {
      //    showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> addToCart({
    required String sku,
    required int qty,
    required String token,
    required String image,
  }) async {
    try {
      final result =
          await _dio.request('${NetworkConfig.baseUrl}${ApiEndpoints.cartItem}',
              data: {
                "cartItem": {
                  "sku": sku,
                  "qty": qty,
                  "product_option": {
                    "extension_attributes": {
                      "custom_options": [
                        {
                          "option_id": "image",
                          "option_value": image,
                        }
                      ]
                    }
                  }
                }
              },
              options: Options(
                method: 'POST',
                headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
              ));
      if (result.statusCode == 200) {
        return true;
      }
      showTopSnackBarError(Get.context!,
          result.statusMessage ?? TransactionConstants.unknownError.tr);
      return false;
    } catch (e) {
      //    showTopSnackBarError(Get.context!, TransactionConstants.unknownError.tr);
      debugPrint(e.toString());
      return false;
    }
  }

  Future<List<CartItem>?> getCartItems(String token) async {
    try {
      final products = <CartItem>[];

      final result =
          await _dio.request('${NetworkConfig.baseUrl}${ApiEndpoints.cartItem}',
              options: Options(
                method: 'GET',
                headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
              ));

      if (result.statusCode == 200 && result.data is List) {
        for (var element in (result.data as List)) {
          final product = CartItem.fromJson(element);
          products.add(product);
        }
      }
      return products;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteItem(
      {required String token, required String itemId}) async {
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.cartItem}/$itemId',
          options: Options(
            method: 'DELETE',
            headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
          ));

      if (result.statusCode == 200) {
        return result.data;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addCoupon({required String token, required String code}) async {
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.coupons(code: code)}',
          options: Options(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
          ));

      if (result.statusCode == 200 && result.data is bool) {
        return result.data;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createReview({
    required String title,
    required String detail,
    required String customerName,
    required int rating,
    required int productId,
  }) async {
    try {
      final param = {
        "review": {
          "title": title,
          "detail": detail,
          "nickname": customerName,
          "ratings": [
            {"rating_name": "Rating", "value": rating},
          ],
          "review_entity": "product",
          "review_status": 2,
          "entity_pk_value": productId
        }
      };

      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.addReview}',
          data: param,
          options: Options(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
          ));

      if (result.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<List<ReviewModel>?> getReview({required String sku}) async {
    try {
      final reviews = <ReviewModel>[];

      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.producReview(sku: sku)}',
          options: Options(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
          ));

      if (result.statusCode == 200 && result.data is List) {
        for (var element in (result.data as List)) {
          final review = ReviewModel.fromJson(element);
          reviews.add(review);
        }
      }
      return reviews;
    } catch (e) {
      return null;
    }
  }

  Future<List<EstimateShippingMethodsModel>> getEstimateShippingMethods(
      {required String token, required int addressId}) async {
    try {
      final methods = <EstimateShippingMethodsModel>[];

      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.cart}/estimate-shipping-methods-by-address-id',
          data: {"addressId": addressId},
          options: Options(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
          ));

      if (result.statusCode == 200 && result.data is List) {
        for (var element in (result.data as List)) {
          final method = EstimateShippingMethodsModel.fromJson(element);
          methods.add(method);
        }
      }
      return methods;
    } catch (e) {
      return [];
    }
  }

  Future<SaveShippingMethodResponseModel?> addShippingInformation(
      {required String token,
      required EstimateShippingMethodsModel shippingMethod,
      required CustomerModel customer,
      required Addresses address}) async {
    try {
      final data = {
        "addressInformation": {
          "shipping_address": {
            "region": address.region?.region ?? "",
            "region_id": address.region?.regionId ?? 43,
            "region_code": address.region?.regionCode ?? "",
            "country_id": address.countryId ?? "VN",
            "street": address.street ??
                [
                  address.city ?? '',
                ],
            "postcode": address.postcode ?? "000084",
            "city": address.city,
            "firstname": address.firstname,
            "lastname": address.lastname,
            "email": customer.email,
            "telephone": address.telephone,
          },
          "shipping_carrier_code": shippingMethod.carrierCode,
          "shipping_method_code": shippingMethod.methodCode,
        }
      };

      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.cart}/shipping-information',
          data: data,
          options: Options(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
          ));

      if (result.statusCode == 200) {
        return SaveShippingMethodResponseModel.fromJson(result.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> createOrder({
    required String token,
    required PaymentMethods payment,
    required CustomerModel customer,
    required Addresses address,
    String? paypalId,
  }) async {
    try {
      final data = {
        "paymentMethod": {
          "method": (payment.code ?? '').contains('paypal')
              ? 'paypal_express_bml'
              : payment.code,
          "additional_data": {"paypal_express_payment_payload": paypalId}
        },
        "billing_address": {
          "email": customer.email,
          "region": address.region?.region ?? "",
          "region_id": address.region?.regionId ?? 43,
          "region_code": address.region?.regionCode ?? "",
          "country_id": address.countryId ?? "VN",
          "street": address.street ??
              [
                address.city ?? '',
              ],
          "postcode": address.postcode ?? "000084",
          "city": address.city,
          "firstname": address.firstname,
          "lastname": address.lastname,
          "telephone": address.telephone,
        }
      };

      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.cart}/payment-information',
          data: data,
          options: Options(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': 'Bearer $token'},
          ));

      if (result.statusCode == 200) {
        return result.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// for getting the access token from Paypal
  Future<String?> getAccessToken() async {
    try {
      var client =
          BasicAuthClient(NetworkConfig.clientId, NetworkConfig.secret);

      var response = await client.post(Uri.parse(
          '${NetworkConfig.domain}/v1/oauth2/token?grant_type=client_credentials'));
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>?> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post(
          Uri.parse("${NetworkConfig.domain}/v1/payments/payment"),
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $accessToken'
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        showTopSnackBarError(
            Get.context!, TransactionConstants.unknownError.tr);
        Get.back();
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// for executing the payment transaction
  Future<String?> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $accessToken'
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return body["id"];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
