import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/category_tree_model.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/domain/models/review_model.dart';
import 'package:magento_app/domain/usecases/cart_usecase.dart';
import 'package:magento_app/domain/usecases/product_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/cart/cart_controller.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/widgets/snack_bar/app_snack_bar.dart';

class ProductDetailController extends GetxController with MixinController {
  Rx<ProductModel> product = ProductModel().obs;

  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;
  Rx<LoadedType> rxLoadedButton = LoadedType.finish.obs;
  RxList<CategoryTreeModel> categories = <CategoryTreeModel>[].obs;
  RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final ProductUseCase productUseCase;
  final CartUseCase cartUseCase;

  //final mainController = Get.find<MainController>();
  String? sku;
  RxInt quantity = 1.obs;
  RxInt rating = 5.obs;
  final titleController = TextEditingController();
  final detailController = TextEditingController();

  final titleFocusNode = FocusNode();
  final detailFocusNode = FocusNode();

  RxString errorText = ''.obs;

  RxString titleValidate = ''.obs;
  RxString detailValidate = ''.obs;

  RxBool buttonEnable = false.obs;
  RxBool titleHasFocus = false.obs;
  RxBool detailHasFocus = false.obs;

  ProductDetailController({
    required this.productUseCase,
    required this.cartUseCase,
    //  required this.categoryUseCase,
  });

  void checkButtonEnable() {
    if (titleController.text.isNotEmpty && detailController.text.isNotEmpty) {
      buttonEnable.value = true;
    } else {
      buttonEnable.value = false;
    }
  }

  void onChangedTitle() {
    checkButtonEnable();
    titleValidate.value = '';
  }

  void onTapTitleTextField() {
    detailHasFocus.value = false;
    titleHasFocus.value = true;
  }

  void onEditingCompleteTitle() {
    titleHasFocus.value = false;
    detailHasFocus.value = true;
    FocusScope.of(context).requestFocus(detailFocusNode);
  }

  void onChangedDetail() {
    checkButtonEnable();
    detailValidate.value = '';
  }

  void onTapDetailTextField() {
    titleHasFocus.value = false;
    detailHasFocus.value = true;
  }

  void onEditingCompleteDetail() {
    detailHasFocus.value = false;
    FocusScope.of(context).unfocus();
    if (buttonEnable.value) {
      addReview();
    }
  }

  void onPressedReview() {
    detailHasFocus.value = false;
    titleHasFocus.value = false;
    if (buttonEnable.value) {
      addReview();
    }
  }

  void addReview() async {
    rxLoadedButton.value = LoadedType.start;
    hideKeyboard();
    errorText.value = '';
    // titleValidate.value = AppValidator.validateEmail(emailController);
    // detailValidate.value = AppValidator.validatePassword(passwordController);

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      rxLoadedButton.value = LoadedType.finish;
      return;
    }

    if (titleValidate.value.isEmpty && detailValidate.value.isEmpty) {
      final result = await cartUseCase.createReview(
          title: titleController.text.trim(),
          detail: detailController.text.trim(),
          customerName:
              Get.find<MainController>().rxCustomer.value?.lastname ?? '',
          rating: rating.value,
          productId: product.value.id ?? 1);

      try {
        if (result) {
          showTopSnackBar(context,
              message: TransactionConstants.successfully.tr,
              type: SnackBarType.done);
          titleController.clear();
          detailController.clear();
          rating.value = 5;
          await getReviewList();
        }
      } catch (e) {
        debugPrint(e.toString());
        showTopSnackBarError(context, TransactionConstants.unknownError.tr);
      }
    }

    rxLoadedButton.value = LoadedType.finish;
  }

  void increaseQuantity() {
    if ((product.value.extensionAttributes?.stockItem?.qty ?? 1) >
        quantity.value) {
      quantity.value = quantity.value + 1;
    }
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value = quantity.value - 1;
    }
  }

  Future<void> getProductDetail() async {
    rxLoadedList.value = LoadedType.start;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }

    if (sku == null) return;

    final result = await productUseCase.getProductDetail(sku: sku!);
    if (result != null) {
      product.value = result;
    }

    rxLoadedList.value = LoadedType.finish;
  }

  Future<void> getReviewList() async {
    rxLoadedList.value = LoadedType.start;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }

    if (sku == null) return;

    final result = await cartUseCase.getReview(sku: sku!);
    if (result != null) {
      reviews.value = result;
    }

    rxLoadedList.value = LoadedType.finish;
  }

  Future<void> addToCart() async {
    rxLoadedList.value = LoadedType.start;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }

    if (sku == null) return;

    final result = await cartUseCase.addToCart(
        sku: sku!,
        qty: quantity.value,
        image: product.value.mediaGalleryEntries?.first.file ?? '');
    if (result) {
      showTopSnackBar(context,
          message: TransactionConstants.successfully.tr,
          type: SnackBarType.done);
      await Get.find<CartController>().getProductsList();
      Get.find<MainController>().updateTotalOrder();
      await getProductDetail();
    }

    rxLoadedList.value = LoadedType.finish;
  }

  @override
  void onInit() async {
    super.onInit();
    sku = Get.arguments;
  }

  @override
  void onReady() async {
    super.onReady();
    await getProductDetail();
    await getReviewList();
  }
}
