import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/category_tree_model.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/domain/models/search_criteria_model.dart';
import 'package:magento_app/domain/usecases/category_usecase.dart';
import 'package:magento_app/domain/usecases/product_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/product/product_controller.dart';
import 'package:magento_app/presentation/widgets/snack_bar/app_snack_bar.dart';

class CategoryController extends GetxController with MixinController {
  RxList<CategoryTreeModel> categories = <CategoryTreeModel>[].obs;
  RxInt selectedIndex = 0.obs;
  List<String> categoryImages = [
    '/wysiwyg/new/new-eco.jpg',
    '/wysiwyg/womens/womens-erin.jpg',
    '/wysiwyg/mens/mens-category-tees.jpg',
    '/wysiwyg/gear/gear-equipment.jpg',
    '/wysiwyg/womens/womens-t-shirts.png',
    '/wysiwyg/sale/sale-gear.jpg',
    '/wysiwyg/sale/sale-free-shipping.png',
    '/wysiwyg/sale/sale-20-off.png',
  ];

  Rx<LoadedType> rxLoadedLeftList = LoadedType.start.obs;
  Rx<LoadedType> rxLoadedRightList = LoadedType.start.obs;
  RxList<CategoryTreeModel> subCategories = <CategoryTreeModel>[].obs;
  RxList<ProductModel> productsOfCategory = <ProductModel>[].obs;

  final CategoryUseCase categoryUseCase;
  final ProductUseCase productUseCase;

  CategoryController({
    required this.categoryUseCase,
    required this.productUseCase,
  });

  Future<void> getCategoriesTree() async {
    rxLoadedLeftList.value = LoadedType.start;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      rxLoadedLeftList.value = LoadedType.finish;
      return;
    }

    final result = await categoryUseCase.getCategorysWithAttribute();
    if (result != null) {
      categories.value = result.childrenData ?? [];

      // for (var category in categories.value) {
      //   final image = await getCategoryImage(category.id);
      //   categoryImages.value.add(image ?? '/wysiwyg/sale/sale-mens.jpg');
      // }
    } else {
      showTopSnackBarError(context, TransactionConstants.unknownError.tr);
    }
    rxLoadedLeftList.value = LoadedType.finish;
  }

  Future<void> onViewProductList(CategoryTreeModel categoryTreeModel) async {
    Get.toNamed(AppRoutes.product, arguments: categoryTreeModel);
    await Get.find<ProductController>().onRefresh();
  }

  Future<void> onSelectCategory(int newIndex) async {
    rxLoadedRightList.value = LoadedType.start;
    selectedIndex.value = newIndex;
    subCategories.clear();
    subCategories.addAll(categories[selectedIndex.value].childrenData ?? []);
    await getProductOfSelectedCategory(categories[selectedIndex.value].id);
    rxLoadedRightList.value = LoadedType.finish;
  }

  Future<void> getProductOfSelectedCategory(int? categoryId) async {
    productsOfCategory.clear();

    if (categoryId == null) return;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      // rxLoadedRightList.value = LoadedType.finish;
      return;
    }

    Filters categoryFilter = Filters(
      field: 'category_id',
      value: categoryId.toString(),
      conditionType: 'in',
    );

    final result = await productUseCase.getProductsWithAttribute(
      pageSize: 2,
      currentPage: 1,
      filters: categoryFilter.toJson(),
    );
    debugPrint('--------777--$result');
    if (result != null) {
      debugPrint('--------777--$result');
      if ((result.items ?? []).isNotEmpty) {
        // final products = <ProductModel>[];
        //
        // for (int i = 0; i < 2; i++) {
        //   final product = await getProductDetail(result[i].sku);
        //   if (product != null) {
        //     products.add(product);
        //     debugPrint('----------------123---$products');
        //   }
        // }

        productsOfCategory.value.addAll(result.items ?? []);
        debugPrint('----------------453---$productsOfCategory');
        // for (var category in categories.value) {
        //   final image = await getCategoryImage(category.id);
        //   categoryImages.value.add(image ?? '/wysiwyg/sale/sale-mens.jpg');
        // }
      }
    } else {
      showTopSnackBarError(context, TransactionConstants.unknownError.tr);
    }
  }

  Future<ProductModel?> getProductDetail(String? productSku) async {
    // rxLoadedList.value = LoadedType.start;

    if (productSku != null) {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        showTopSnackBarError(
            context, TransactionConstants.noConnectionError.tr);
        return null;
      }

      final result = await productUseCase.getProductsWithAttribute(
        pageSize: 1,
        fields: 'items[id,name,media_gallery_entries]',
        filters: Filters(field: 'sku', value: productSku, conditionType: 'eq')
            .toJson(),
      );
      if (result != null) {
        //   debugPrint('----------------123---$products');
        return result.items?.first;
      } else {
        showTopSnackBarError(context, TransactionConstants.unknownError.tr);
        return null;
      }
    }
    //  rxLoadedList.value = LoadedType.finish;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getCategoriesTree();
    await onSelectCategory(0);
  }
}
