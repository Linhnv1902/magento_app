import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/category_tree_model.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/domain/usecases/account_usecase.dart';
import 'package:magento_app/domain/usecases/category_usecase.dart';
import 'package:magento_app/domain/usecases/home_usecase.dart';
import 'package:magento_app/domain/usecases/product_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/widgets/snack_bar/app_snack_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController with MixinController {
  RxList<ProductModel> hotItems = <ProductModel>[].obs;

  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;
  RxList<CategoryTreeModel> categories = <CategoryTreeModel>[].obs;
  final HomeUseCase homeUseCase;
  final ProductUseCase productUseCase;
  final CategoryUseCase categoryUseCase;
  final AccountUseCase accountUseCase;
  // final CartUseCase cartUseCase;

  final mainController = Get.find<MainController>();

  RxList<ProductModel> products = <ProductModel>[].obs;

  // Rx<LoadedType> rxLoadedList = LoadedType.start.obs;
  //RxList<CategoryTreeModel> categories = <CategoryTreeModel>[].obs;
  // final ProductUseCase productUseCase;
  // final CategoryUseCase categoryUseCase;
  RxInt currentPage = 1.obs;
  RxBool canLoadMore = true.obs;
  final scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  // RxInt totalPurchaseOrder = 0.obs;
  RxBool shouldRefresh = false.obs;
  final RefreshController productRefreshController =
      RefreshController(initialRefresh: false);
  // final mainController = Get.find<MainController>();
  // Rx<CategoryTreeModel?> category = (null as CategoryTreeModel?).obs;

  HomeController({
    required this.homeUseCase,
    required this.productUseCase,
    required this.categoryUseCase,
    required this.accountUseCase,
    //  required this.cartUseCase,
  });

  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  Future<void> getStoreConfig() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }
    final result = await homeUseCase.getStoreConfig();
    if (result != null) {
      mainController.storeConfig.value = result;
    } else {
      showTopSnackBarError(context, TransactionConstants.unknownError.tr);
    }
  }

  // Future<void> getCategoriesTree() async {
  //   categories.clear();
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.none) {
  //     showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
  //     return;
  //   }
  //   final result = await categoryUseCase.getCategorysWithAttribute();
  //   if (result != null) {
  //     categories.addAll(result.childrenData ?? []);
  //   } else {
  //     showTopSnackBarError(context, TransactionConstants.unknownError.tr);
  //   }
  // }

  // Future<void> getHotItems() async {
  //   hotItems.clear();
  //   final result = await productUseCase.getProductsWithAttribute();
  //   if (result != null) {
  //     hotItems.value = result.items ?? [];
  //   } else {
  //     // showTopSnackBarError(context, TransactionConstants.unknownError);
  //   }
  // }

  Future<void> getProductList() async {
    // rxLoadedList.value = LoadedType.start;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }

    final result = await productUseCase.getProductsWithAttribute(
      pageSize: 10,
      currentPage: currentPage.value,
      // sortOrders: _getSortOrders(),
      //filters: _getFilters(),
    );
    if (result != null) {
      products.addAll(result.items ?? []);
      // totalPurchaseOrder.value = (result).items?.total ?? 0;
      currentPage.value = currentPage.value + 1;
      canLoadMore.value = products.value.length < (result.totalCount ?? 0);
    } else {
      // showTopSnackBarError(context, TransactionConstants.unknownError.tr);
    }
    //  displayPurchaseOrderList.value = purchaseOrderList;
    // rxLoadedList.value = LoadedType.finish;
    productRefreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    rxLoadedList.value = LoadedType.start;
    currentPage.value = 1;
    products.clear();
    await getProductList();
    //  await onSearch(searchController.text.trim());
    productRefreshController.refreshCompleted();
    rxLoadedList.value = LoadedType.finish;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    rxLoadedList.value = LoadedType.start;
    await getStoreConfig();
    //  await getCategoriesTree();
    await onRefresh();
    //  await loginWithUsername();
    rxLoadedList.value = LoadedType.finish;
  }
}
