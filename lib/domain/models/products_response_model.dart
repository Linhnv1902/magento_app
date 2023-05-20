import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/domain/models/search_criteria_model.dart';

class ProductsResponseModel {
  List<ProductModel>? items;
  SearchCriteria? searchCriteria;
  int? totalCount;

  ProductsResponseModel({this.items, this.searchCriteria, this.totalCount});

  ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ProductModel>[];
      json['items'].forEach((v) {
        items!.add(ProductModel.fromJson(v));
      });
    }
    searchCriteria = json['search_criteria'] != null
        ? SearchCriteria.fromJson(json['search_criteria'])
        : null;
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (searchCriteria != null) {
      data['search_criteria'] = searchCriteria!.toJson();
    }
    data['total_count'] = totalCount;
    return data;
  }
}

// class CustomAttributes {
//   String attributeCode;
//   String value;
//
//   CustomAttributes({this.attributeCode, this.value});
//
//   CustomAttributes.fromJson(Map<String, dynamic> json) {
//     attributeCode = json['attribute_code'];
//     value = json['value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['attribute_code'] = this.attributeCode;
//     data['value'] = this.value;
//     return data;
//   }
// }
