import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/get_all_orders_response_model.dart';
import 'package:magento_app/domain/usecases/account_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/widgets/snack_bar/app_snack_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyOrdersController extends GetxController with MixinController {
  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;

  RxList<OrderDetail> orders = <OrderDetail>[].obs;

  final AccountUseCase accountUseCase;
  RxInt currentPage = 1.obs;
  RxBool canLoadMore = true.obs;
  final scrollController = ScrollController();

  // RxInt totalPurchaseOrder = 0.obs;
  RxBool shouldRefresh = false.obs;
  final RefreshController ordersRefreshController =
      RefreshController(initialRefresh: false);
  final mainController = Get.find<MainController>();

  MyOrdersController({required this.accountUseCase});

  Future<void> getAllOrders() async {
    // rxLoadedList.value = LoadedType.start;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }

    final result = await accountUseCase.getAllOrder(
      pageSize: 10,
      currentPage: currentPage.value,
      email: mainController.rxCustomer.value?.email ?? '',
    );
    if (result != null) {
      orders.addAll(result.items ?? []);
      // totalPurchaseOrder.value = (result).items?.total ?? 0;
      currentPage.value = currentPage.value + 1;
      canLoadMore.value = orders.value.length < (result.totalCount ?? 0);
    } else {
      // showTopSnackBarError(context, TransactionConstants.unknownError.tr);
    }
    //  displayPurchaseOrderList.value = purchaseOrderList;
    // rxLoadedList.value = LoadedType.finish;
    ordersRefreshController.loadComplete();
  }

  // goToDetail(ProductModel productModel) async {
  //   // final result = await Get.toNamed(AppRoute.purchaseOrderDetail, arguments: {
  //   //   'id': purchaseOrderEntity.id,
  //   //   'order_number': purchaseOrderEntity.orderNumber,
  //   //   'status_id': purchaseOrderEntity.status
  //   // });
  //   // if (result['is_canceled'] || result['is_deposited']) {
  //   //   if (result['is_deposited']) {
  //   //     shouldRefresh.value = true;
  //   //   }
  //   //   await getPurchaseOrderList();
  //   // }
  // }

  Future<void> onRefresh() async {
    rxLoadedList.value = LoadedType.start;
    currentPage.value = 1;
    orders.clear();
    await getAllOrders();
    //  await onSearch(searchController.text.trim());
    ordersRefreshController.refreshCompleted();
    rxLoadedList.value = LoadedType.finish;
  }

  @override
  void onInit() async {
    super.onInit();
    // Map? args = Get.arguments;
    // categoryId.value = args?['category_id'];
    // debugPrint('============${categoryId.value}');
  }

  @override
  void onReady() async {
    super.onReady();
    await onRefresh();
    //  await getAllOrders();
    // searchController.addListener(() {
    //   if (AppUtils.isNullEmpty(searchController.text.trim())) {
    //     displayPurchaseOrderList.value = purchaseOrderList;
    //   }
    // });
  }
}
