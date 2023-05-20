import 'package:magento_app/data/remote/category_repository.dart';
import 'package:magento_app/domain/models/category_tree_model.dart';
import 'package:magento_app/domain/models/get_products_of_category_response_model.dart';

class CategoryUseCase {
  final CategoryRepository categoryRepo;

  CategoryUseCase({required this.categoryRepo});

  Future<CategoryTreeModel?> getCategorysWithAttribute() async {
    return await categoryRepo.getCategoriesTree();
  }

  Future<List<GetProductsOfCategoryResponseModel>?> getProsuctsOfCategory(
      int categoryId) async {
    return await categoryRepo.getProsuctsOfCategory(categoryId);
  }
}
