import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/category_tree_model.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/domain/models/search_criteria_model.dart';
import 'package:magento_app/domain/usecases/category_usecase.dart';
import 'package:magento_app/domain/usecases/product_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/widgets/snack_bar/app_snack_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum SortType {
  none,
  asc,
  desc,
}

class ProductController extends GetxController with MixinController {
  RxList<ProductModel> products = <ProductModel>[].obs;

  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;
  RxList<CategoryTreeModel> categories = <CategoryTreeModel>[].obs;
  final ProductUseCase productUseCase;
  final CategoryUseCase categoryUseCase;
  RxInt currentPage = 1.obs;
  RxBool canLoadMore = true.obs;
  final scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  // RxInt totalPurchaseOrder = 0.obs;
  RxBool shouldRefresh = false.obs;
  final RefreshController productRefreshController =
      RefreshController(initialRefresh: false);
  final mainController = Get.find<MainController>();
  Rx<CategoryTreeModel?> category = (null as CategoryTreeModel?).obs;

  Rx<SortType> sortByName = SortType.none.obs;
  Rx<SortType> sortByPrice = SortType.none.obs;

  bool searching = false;

  ProductController({
    required this.productUseCase,
    required this.categoryUseCase,
  });

  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeEndDrawer();
  }

  Future<void> onChangeSortByName() async {
    switch (sortByName.value) {
      case SortType.none:
        sortByName.value = SortType.asc;
        break;
      case SortType.asc:
        sortByName.value = SortType.desc;
        break;
      case SortType.desc:
        sortByName.value = SortType.none;
        break;
    }
    await onRefresh();
  }

  Future<void> onChangeSortByPrice() async {
    switch (sortByPrice.value) {
      case SortType.none:
        sortByPrice.value = SortType.asc;
        break;
      case SortType.asc:
        sortByPrice.value = SortType.desc;
        break;
      case SortType.desc:
        sortByPrice.value = SortType.none;
        break;
    }
    await onRefresh();
  }

  Future<void> getCategoriesTree() async {
    categories.clear();
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }

    final result = await categoryUseCase.getCategorysWithAttribute();
    if (result != null) {
      categories.addAll(result.childrenData ?? []);
      debugPrint('==========$categories');
    } else {
      showTopSnackBarError(context, TransactionConstants.unknownError.tr);
    }
  }

  Future<void> getProductList() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }

    final result = await productUseCase.getProductsWithAttribute(
      pageSize: 10,
      currentPage: currentPage.value,
      sortOrders: _getSortOrders(),
      filters: _getFilters(),
    );
    if (result != null) {
      products.addAll(result.items ?? []);
      currentPage.value = currentPage.value + 1;
      canLoadMore.value = products.value.length < (result.totalCount ?? 0);
    }
    productRefreshController.loadComplete();
  }

  Map<String, dynamic> _getSortOrders() {
    Map<String, dynamic> sortOrders = {};

    if (sortByPrice.value != SortType.none) {
      SortOrders sortPrice =
          SortOrders(field: 'price', direction: sortByPrice.value.name);
      sortOrders.addAll(sortPrice.toJson());
    }

    if (sortByName.value != SortType.none) {
      SortOrders sortName =
          SortOrders(field: 'name', direction: sortByName.value.name);
      sortOrders.addAll(sortName.toJson(index: 1));
    }

    return sortOrders;
  }

  Map<String, dynamic> _getFilters() {
    Map<String, dynamic> filters = {};
    int index1 = 0;
    int index2 = 0;

    if (searchController.text.trim().isNotEmpty) {
      Filters searchFilter = Filters(
        field: 'name',
        value: '%${searchController.text.trim()}%',
        conditionType: 'like',
      );
      filters.addAll(searchFilter.toJson(index1: index1, index2: index2));
      index1++;
    }

    if (category.value != null) {
      Filters categoryFilter = Filters(
        field: 'category_id',
        value: (category.value?.id ?? 0).toString(),
        conditionType: 'in',
      );
      filters.addAll(categoryFilter.toJson(index1: index1, index2: index2));
      index1++;
    }

    return filters;
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

  Future<void> filterByCategory(CategoryTreeModel? filterCat) async {
    category.value = filterCat;
    await onRefresh();
    closeDrawer();
  }

  @override
  void onInit() async {
    super.onInit();
    var arg = Get.arguments;
    debugPrint('=============$searching');
    if (arg is bool) {
      searching = arg;
    }
    if (arg is CategoryTreeModel) {
      category.value = arg;
    }
    if (arg is String) {
      searchController.text = arg;
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await onRefresh();
    await getCategoriesTree();
    if (searching) {
      FocusScope.of(context).requestFocus(searchFocusNode);
    }
  }
}
