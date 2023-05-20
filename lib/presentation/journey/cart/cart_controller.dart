import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/cart_information_model.dart';
import 'package:magento_app/domain/usecases/cart_usecase.dart';
import 'package:magento_app/domain/usecases/product_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/addresses_list/address_screen.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/widgets/app_dialog.dart';
import 'package:magento_app/presentation/widgets/export.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartController extends GetxController with MixinController {
  final ProductUseCase productUseCase;
  final CartUseCase cartUseCase;

  RxBool buttonEnable = false.obs;
  String token = '';
  RxList<CartItem> items = <CartItem>[].obs;
  Rx<LoadedType> buttonState = LoadedType.finish.obs;

  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;

  Rx<CartInformationModel?> cartInfo = (null as CartInformationModel?).obs;

  final RefreshController cartRefreshController =
      RefreshController(initialRefresh: false);

  CartController({
    required this.productUseCase,
    required this.cartUseCase,
  });

  MainController mainController = Get.find<MainController>();
  RxBool isSelectedAll = false.obs;
  RxInt totalPrice = 0.obs;

  final couponController = TextEditingController();

  final couponFocusNode = FocusNode();

  RxString couponValidate = ''.obs;

  RxBool couponHasFocus = false.obs;

  void addCoupon() async {
    rxLoadedList.value = LoadedType.start;
    hideKeyboard();
    // errorText.value = '';

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      rxLoadedList.value = LoadedType.finish;
      return;
    }

    if (couponController.text.trim().isNotEmpty) {
      final result =
          await cartUseCase.addCoupon(code: couponController.text.trim());

      if (result) {
        debugPrint('đăng ký thành công');
        showTopSnackBar(context,
            message: TransactionConstants.successfully.tr,
            type: SnackBarType.done);
        //  Get.back();
      } else {
        showTopSnackBarError(context,
            'The coupon code isn\'t valid. Verify the code and try again.');
      }
    }

    rxLoadedList.value = LoadedType.finish;
  }

  onPressCreateOrder() async {
    Get.toNamed(AppRoutes.address, arguments: true);
    //buttonState.value = LoadedType.start;
    // List<int> ids = [];
    // for (ProductCartEntity product in selectedItems.value) {
    //   if (product.id != null) {
    //     ids.add(product.id!);
    //   }
    // }
    // final request = CreateNewOrderRequest(
    //     ids: ids,
    //     warehouseId: int.parse(
    //       selectedWarehouse.value.id ?? '0',
    //     ),
    //     orderType: selectedType.value);
    // final result = await mainController.requestApi(() => cartUsecase.createNewOrder(token, request.toJson), context!);
    // buttonState.value = ButtonState.active;
    // if (result.code! == 200) {
    //   Get.back();
    //   Get.back();
    //   log(result.code.toString());
    //   selectedItems.clear();
    //   isSelectedAll.value = false;
    //   await getProductsList();
    // } else {
    //   showTopSnackBarError(context!, 'Đã xảy ra lỗi. Vui lòng thử lại!');
    // }
  }

  Future<void> onRefresh() async {
    await getProductsList();
    cartRefreshController.refreshCompleted();
  }

  // onChangeSelect(CartItem item) {
  //   List<CartItem> selectedProducts = [];
  //   selectedProducts.addAll(selectedItems.value);
  //   if (selectedProducts.contains(item)) {
  //     selectedProducts.remove(item);
  //   } else {
  //     selectedProducts.add(item);
  //   }
  //   selectedItems.clear();
  //   selectedItems.value.addAll(selectedProducts);
  //   isSelectedAll.value = checkSelectAll();
  //   calculateTotalPrice();
  // }

  calculateTotalPrice() {
    int total = 0;
    items.value.forEach((element) {
      total += (element.price ?? 0) * (element.qty ?? 1);
    });
    totalPrice.value = total;
  }

  onPressDeleteItem(CartItem item) async {
    await showAppDialog(
        context, TransactionConstants.removeItemDialogMessage.tr,
        firstButtonText: TransactionConstants.ok.tr,
        messageTextAlign: TextAlign.start,
        dismissAble: true,
        firstButtonCallback: () async {
          try {
            rxLoadedList.value = LoadedType.start;
            final result =
                await cartUseCase.deleteItem(itemId: item.itemId.toString());
            debugPrint('---------$result');

            if (result) {
              // await getProductsList();

              List<CartItem> oldItems = [];
              oldItems.addAll(items.value);
              oldItems.remove(item);
              items.clear();
              items.value.addAll(oldItems);
              calculateTotalPrice();
              Get.find<MainController>().updateTotalOrder();
              // if (selectedItems.value.contains(item)) {
              //   List<CartItem> oldSelectedItems = [];
              //   oldSelectedItems.addAll(selectedItems.value);
              //   oldSelectedItems.remove(item);
              //   selectedItems.clear();
              //   selectedItems.value.addAll(oldSelectedItems);
              //   isSelectedAll.value = checkSelectAll();
              //
              // }
              Get.back();
              //await getProductsList();
              rxLoadedList.value = LoadedType.finish;
            }
          } catch (e) {
            showTopSnackBarError(context, TransactionConstants.unknownError.tr);
          }
        },
        secondButtonText: TransactionConstants.cancel.tr,
        secondButtonCallback: () => Get.back());
  }

  // clearAllSelectedList() {
  //   selectedItems.clear();
  //   isSelectedAll.value = false;
  //   totalPrice.value = 0;
  // }

  // clearAllItem() {
  //   // selectedItems.clear();
  //   // isSelectedAll.value = false;
  // }

  Future<void> getProductsList() async {
    rxLoadedList.value = LoadedType.start;
    items.clear();
    // selectedItems.clear();
    // isSelectedAll.value = false;
    final result = await cartUseCase.getCartItems();
    rxLoadedList.value = LoadedType.finish;
    if (result != null) {
      items.addAll(result);
    }
    calculateTotalPrice();
    Get.find<MainController>().updateTotalOrder();
  }

  // onChangeSelectAllItem() {
  //   if (selectedItems.value.length == items.value.length) {
  //     selectedItems.clear();
  //     isSelectedAll.value = false;
  //   } else {
  //     List<CartItem> selectedProducts = [];
  //     selectedProducts.addAll(items.value);
  //     selectedItems.clear();
  //     selectedItems.value.addAll(selectedProducts);
  //     isSelectedAll.value = true;
  //   }
  //   calculateTotalPrice();
  // }

  Future<void> getCartInfo() async {
    rxLoadedList.value = LoadedType.start;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      rxLoadedList.value = LoadedType.finish;
      return;
    }

    final result = await cartUseCase.getCartInfor();

    if (result != null) {
      cartInfo.value = result;
    }
    rxLoadedList.value = LoadedType.finish;
  }

  Future<void> createCart() async {
    rxLoadedList.value = LoadedType.start;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      rxLoadedList.value = LoadedType.finish;
      return;
    }

    final result = await cartUseCase.createCart();

    if (result != null) {
      await getCartInfo();
    }
    rxLoadedList.value = LoadedType.finish;
  }

  @override
  void onReady() async {
    super.onReady();

    //  await getCartInfo();
    if (cartInfo.value == null) {
      await createCart();
    }
    await getProductsList();
  }
}
