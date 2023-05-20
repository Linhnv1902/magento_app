class CategoryTreeModel {
  int? id;
  int? parentId;
  String? name;
  bool? isActive;
  int? position;
  int? level;
  int? productCount;
  List<CategoryTreeModel>? childrenData;

  CategoryTreeModel(
      {this.id,
      this.parentId,
      this.name,
      this.isActive,
      this.position,
      this.level,
      this.productCount,
      this.childrenData});

  CategoryTreeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    isActive = json['is_active'];
    position = json['position'];
    level = json['level'];
    productCount = json['product_count'];
    if (json['children_data'] != null) {
      childrenData = <CategoryTreeModel>[];
      json['children_data'].forEach((v) {
        childrenData!.add(CategoryTreeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['name'] = name;
    data['is_active'] = isActive;
    data['position'] = position;
    data['level'] = level;
    data['product_count'] = productCount;
    if (childrenData != null) {
      data['children_data'] = childrenData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
