import 'package:dio/dio.dart';
import 'package:magento_app/common/config/network/api_endpoints.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/category_tree_model.dart';
import 'package:magento_app/domain/models/get_products_of_category_response_model.dart';

class CategoryRepository {
  final Dio _dio;

  CategoryRepository(this._dio);

  Future<CategoryTreeModel?> getCategoriesTree() async {
    try {
      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.getCategoriesTree}',
          options: Options(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
          ));
      final CategoryTreeModel response =
          CategoryTreeModel.fromJson(result.data);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<List<GetProductsOfCategoryResponseModel>?> getProsuctsOfCategory(
      int categoryId) async {
    try {
      final products = <GetProductsOfCategoryResponseModel>[];

      final result = await _dio.request(
          '${NetworkConfig.baseUrl}${ApiEndpoints.getCategoriesTree}/$categoryId/products',
          options: Options(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
          ));

      if (result.data is List) {
        for (var element in (result.data as List)) {
          final product = GetProductsOfCategoryResponseModel.fromJson(element);
          products.add(product);
        }
      }
      return products;
    } catch (e) {
      return null;
    }
  }

  // Future<String?> getCategoryImage() async {
  //   try {
  //     final result = await _dio.request(
  //         '${NetworkConfig.baseUrl}${ApiEndpoints.getCategoriesTree}',
  //         options: Options(
  //           method: 'GET',
  //           headers: <String, dynamic>{r'Authorization': NetworkConfig.token},
  //         ));
  //     final CategoryTreeModel response =
  //     CategoryTreeModel.fromJson(result.data);
  //     return response;
  //   } catch (e) {
  //     return null;
  //   }
  // }



}
