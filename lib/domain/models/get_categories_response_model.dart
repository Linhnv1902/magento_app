import 'package:magento_app/domain/models/custom_attributes_model.dart';
import 'package:magento_app/domain/models/search_criteria_model.dart';

class GetCategoriesResponseModel {
  List<CategoryModel>? items;
  SearchCriteria? searchCriteria;
  int? totalCount;

  GetCategoriesResponseModel(
      {this.items, this.searchCriteria, this.totalCount});

  GetCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <CategoryModel>[];
      json['items'].forEach((v) {
        items!.add(CategoryModel.fromJson(v));
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

class CategoryModel {
  int? id;
  int? parentId;
  String? name;
  int? position;
  int? level;
  String? children;
  String? createdAt;
  String? updatedAt;
  String? path;
  bool? includeInMenu;
  List<CustomAttributes>? customAttributes;
  bool? isActive;

  CategoryModel({
    this.id,
    this.parentId,
    this.name,
    this.position,
    this.level,
    this.children,
    this.createdAt,
    this.updatedAt,
    this.path,
    this.includeInMenu,
    this.customAttributes,
    this.isActive,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    position = json['position'];
    level = json['level'];
    children = json['children'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    path = json['path'];
    includeInMenu = json['include_in_menu'];
    if (json['custom_attributes'] != null) {
      customAttributes = <CustomAttributes>[];
      json['custom_attributes'].forEach((v) {
        customAttributes!.add(CustomAttributes.fromJson(v));
      });
    }
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['name'] = name;
    data['position'] = position;
    data['level'] = level;
    data['children'] = children;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['path'] = path;
    data['include_in_menu'] = includeInMenu;
    if (customAttributes != null) {
      data['custom_attributes'] =
          customAttributes!.map((v) => v.toJson()).toList();
    }
    data['is_active'] = isActive;
    return data;
  }
}
