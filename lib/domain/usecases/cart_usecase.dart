import 'package:magento_app/data/local_repository.dart';
import 'package:magento_app/data/remote/cart_repository.dart';
import 'package:magento_app/domain/models/cart_information_model.dart';
import 'package:magento_app/domain/models/customer_model.dart';
import 'package:magento_app/domain/models/estimate_shipping_methods_model.dart';
import 'package:magento_app/domain/models/review_model.dart';
import 'package:magento_app/domain/models/save_shipping_method_response_model.dart';

class CartUseCase {
  final CartRepository cartRepo;
  final LocalRepository localRepo;

  CartUseCase({required this.cartRepo, required this.localRepo});

  String? getToken() {
    return localRepo.getToken();
  }

  Future<CartInformationModel?> getCartInfor() async {
    String? token = getToken();

    return token == null ? null : (await cartRepo.getCartInfor(token));
  }

  Future<int?> createCart() async {
    String? token = getToken();

    return token == null ? null : (await cartRepo.createCart(token));
  }

  Future<bool> addCoupon({required String code}) async {
    String? token = getToken();

    return token == null
        ? false
        : (await cartRepo.addCoupon(token: token, code: code));
  }

  Future<bool> addToCart({
    required String sku,
    required int qty,
    required String image,
  }) async {
    String? token = getToken();

    return token == null
        ? false
        : (await cartRepo.addToCart(
            sku: sku,
            qty: qty,
            token: token,
            image: image,
          ));
  }

  Future<List<CartItem>?> getCartItems() async {
    String? token = getToken();

    return token == null ? null : (await cartRepo.getCartItems(token));
  }

  Future<bool> deleteItem({required String itemId}) async {
    String? token = getToken();

    return token == null
        ? false
        : (await cartRepo.deleteItem(
            token: token,
            itemId: itemId,
          ));
  }

  Future<List<EstimateShippingMethodsModel>> getEstimateShippingMethods(
      {required int addressId}) async {
    String? token = getToken();

    return token == null
        ? []
        : await cartRepo.getEstimateShippingMethods(
            token: token,
            addressId: addressId,
          );
  }

  Future<SaveShippingMethodResponseModel?> addShippingInformation(
      {required EstimateShippingMethodsModel shippingMethod,
      required CustomerModel customer,
      required Addresses address}) async {
    String? token = getToken();

    return token == null
        ? null
        : await cartRepo.addShippingInformation(
            token: token,
            address: address,
            customer: customer,
            shippingMethod: shippingMethod,
          );
  }

  Future<String?> createOrder({
    required PaymentMethods payment,
    required CustomerModel customer,
    required Addresses address,
    String? paypalId,
  }) async {
    String? token = getToken();

    return token == null
        ? null
        : await cartRepo.createOrder(
            token: token,
            address: address,
            customer: customer,
            payment: payment,
            paypalId: paypalId,
          );
  }

  Future<String?> getAccessToken() async {
    return await cartRepo.getAccessToken();
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>?> createPaypalPayment(
      transactions, accessToken) async {
    return await cartRepo.createPaypalPayment(transactions, accessToken);
  }

  /// for executing the payment transaction
  Future<String?> executePayment(url, payerId, accessToken) async {
    return await cartRepo.executePayment(url, payerId, accessToken);
  }

  Future<List<ReviewModel>?> getReview({required String sku}) async {
    return await cartRepo.getReview(sku: sku);
  }

  Future<bool> createReview({
    required String title,
    required String detail,
    required String customerName,
    required int rating,
    required int productId,
  }) async {
    return await cartRepo.createReview(
      title: title,
      detail: detail,
      customerName: customerName,
      rating: rating,
      productId: productId,
    );
  }
}
