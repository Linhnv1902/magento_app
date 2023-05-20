class GetProductsOfCategoryResponseModel {
  String? sku;
  int? position;
  String? categoryId;

  GetProductsOfCategoryResponseModel(
      {this.sku, this.position, this.categoryId});

  GetProductsOfCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    position = json['position'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sku'] = sku;
    data['position'] = position;
    data['category_id'] = categoryId;
    return data;
  }
}
