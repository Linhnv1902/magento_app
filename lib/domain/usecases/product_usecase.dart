import 'package:magento_app/data/remote/product_repository.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/domain/models/products_response_model.dart';

class ProductUseCase {
  final ProductRepository productRepo;

  ProductUseCase({required this.productRepo});

  Future<ProductsResponseModel?> getProductsWithAttribute({
    int pageSize = 10,
    int currentPage = 1,
    Map<String, dynamic>? filters,
    Map<String, dynamic>? sortOrders,
    String? fields,
  }) async {
    return await productRepo.getProductsWithAttribute(
      pageSize: pageSize,
      currentPage: currentPage,
      filters: filters,
      sortOrders: sortOrders,
      fields: fields,
    );
  }

  Future<ProductModel?> getProductDetail({required String sku}) async {
    return productRepo.getProductDetail(sku: sku);
  }
}
