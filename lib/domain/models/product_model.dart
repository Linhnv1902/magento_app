import 'package:magento_app/domain/models/custom_attributes_model.dart';

class ProductModel {
  int? id;
  String? sku;
  String? name;
  int? attributeSetId;
  int? price;
  int? status;
  int? visibility;
  String? typeId;
  String? createdAt;
  String? updatedAt;
  int? weight;
  ExtensionAttributes? extensionAttributes;
  List<ProductLinks>? productLinks;
  // List<Null>? options;
  List<MediaGalleryEntries>? mediaGalleryEntries;
//  List<Null>? tierPrices;
  List<CustomAttributes>? customAttributes;

  ProductModel(
      {this.id,
      this.sku,
      this.name,
      this.attributeSetId,
      this.price,
      this.status,
      this.visibility,
      this.typeId,
      this.weight,
      this.createdAt,
      this.updatedAt,
      this.extensionAttributes,
      this.productLinks,
      //   this.options,
      this.mediaGalleryEntries,
      //   this.tierPrices,
      this.customAttributes});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    name = json['name'];
    attributeSetId = json['attribute_set_id'];
    price = json['price'];
    status = json['status'];
    visibility = json['visibility'];
    typeId = json['type_id'];
    weight = json['weight'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    extensionAttributes = json['extension_attributes'] != null
        ? ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    if (json['product_links'] != null) {
      productLinks = <ProductLinks>[];
      json['product_links'].forEach((v) {
        productLinks!.add(ProductLinks.fromJson(v));
      });
    }
    // if (json['options'] != null) {
    //   options = new List<Null>();
    //   json['options'].forEach((v) {
    //     options.add(new Null.fromJson(v));
    //   });
    // }
    if (json['media_gallery_entries'] != null) {
      mediaGalleryEntries = <MediaGalleryEntries>[];
      json['media_gallery_entries'].forEach((v) {
        mediaGalleryEntries!.add(MediaGalleryEntries.fromJson(v));
      });
    }
    // if (json['tier_prices'] != null) {
    //   tierPrices = new List<Null>();
    //   json['tier_prices'].forEach((v) {
    //     tierPrices.add(new Null.fromJson(v));
    //   });
    // }
    if (json['custom_attributes'] != null) {
      customAttributes = <CustomAttributes>[];
      json['custom_attributes'].forEach((v) {
        customAttributes!.add(CustomAttributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sku'] = sku;
    data['name'] = name;
    data['attribute_set_id'] = attributeSetId;
    data['price'] = price;
    data['status'] = status;
    data['visibility'] = visibility;
    data['type_id'] = typeId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (extensionAttributes != null) {
      data['extension_attributes'] = extensionAttributes!.toJson();
    }
    if (productLinks != null) {
      data['product_links'] = productLinks!.map((v) => v.toJson()).toList();
    }
    // if (this.options != null) {
    //   data['options'] = this.options!.map((v) => v.toJson()).toList();
    // }
    if (mediaGalleryEntries != null) {
      data['media_gallery_entries'] =
          mediaGalleryEntries!.map((v) => v.toJson()).toList();
    }
    // if (this.tierPrices != null) {
    //   data['tier_prices'] = this.tierPrices.map((v) => v.toJson()).toList();
    // }
    if (customAttributes != null) {
      data['custom_attributes'] =
          customAttributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExtensionAttributes {
  List<int>? websiteIds;
  List<CategoryLinks>? categoryLinks;
  StockItem? stockItem;

  ExtensionAttributes({
    this.websiteIds,
    this.categoryLinks,
    this.stockItem,
  });

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    websiteIds = json['website_ids'].cast<int>();
    if (json['category_links'] != null) {
      categoryLinks = <CategoryLinks>[];
      json['category_links'].forEach((v) {
        categoryLinks!.add(CategoryLinks.fromJson(v));
      });
    }
    stockItem = json['stock_item'] != null
        ? StockItem.fromJson(json['stock_item'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['website_ids'] = websiteIds;
    if (categoryLinks != null) {
      data['category_links'] = categoryLinks!.map((v) => v.toJson()).toList();
    }
    if (stockItem != null) {
      data['stock_item'] = stockItem!.toJson();
    }
    return data;
  }
}

class CategoryLinks {
  int? position;
  String? categoryId;

  CategoryLinks({this.position, this.categoryId});

  CategoryLinks.fromJson(Map<String, dynamic> json) {
    position = json['position'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['position'] = position;
    data['category_id'] = categoryId;
    return data;
  }
}

class ProductLinks {
  String? sku;
  String? linkType;
  String? linkedProductSku;
  String? linkedProductType;
  int? position;

  ProductLinks(
      {this.sku,
      this.linkType,
      this.linkedProductSku,
      this.linkedProductType,
      this.position});

  ProductLinks.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    linkType = json['link_type'];
    linkedProductSku = json['linked_product_sku'];
    linkedProductType = json['linked_product_type'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sku'] = sku;
    data['link_type'] = linkType;
    data['linked_product_sku'] = linkedProductSku;
    data['linked_product_type'] = linkedProductType;
    data['position'] = position;
    return data;
  }
}

class StockItem {
  int? itemId;
  int? productId;
  int? stockId;
  int? qty;
  bool? isInStock;
  bool? isQtyDecimal;
  bool? showDefaultNotificationMessage;
  bool? useConfigMinQty;
  int? minQty;
  int? useConfigMinSaleQty;
  int? minSaleQty;
  bool? useConfigMaxSaleQty;
  int? maxSaleQty;
  bool? useConfigBackorders;
  int? backorders;
  bool? useConfigNotifyStockQty;
  int? notifyStockQty;
  bool? useConfigQtyIncrements;
  int? qtyIncrements;
  bool? useConfigEnableQtyInc;
  bool? enableQtyIncrements;
  bool? useConfigManageStock;
  bool? manageStock;
//  Null lowStockDate;
  bool? isDecimalDivided;
  int? stockStatusChangedAuto;

  StockItem(
      {this.itemId,
      this.productId,
      this.stockId,
      this.qty,
      this.isInStock,
      this.isQtyDecimal,
      this.showDefaultNotificationMessage,
      this.useConfigMinQty,
      this.minQty,
      this.useConfigMinSaleQty,
      this.minSaleQty,
      this.useConfigMaxSaleQty,
      this.maxSaleQty,
      this.useConfigBackorders,
      this.backorders,
      this.useConfigNotifyStockQty,
      this.notifyStockQty,
      this.useConfigQtyIncrements,
      this.qtyIncrements,
      this.useConfigEnableQtyInc,
      this.enableQtyIncrements,
      this.useConfigManageStock,
      this.manageStock,
      //   this.lowStockDate,
      this.isDecimalDivided,
      this.stockStatusChangedAuto});

  StockItem.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    productId = json['product_id'];
    stockId = json['stock_id'];
    qty = json['qty'];
    isInStock = json['is_in_stock'];
    isQtyDecimal = json['is_qty_decimal'];
    showDefaultNotificationMessage = json['show_default_notification_message'];
    useConfigMinQty = json['use_config_min_qty'];
    minQty = json['min_qty'];
    useConfigMinSaleQty = json['use_config_min_sale_qty'];
    minSaleQty = json['min_sale_qty'];
    useConfigMaxSaleQty = json['use_config_max_sale_qty'];
    maxSaleQty = json['max_sale_qty'];
    useConfigBackorders = json['use_config_backorders'];
    backorders = json['backorders'];
    useConfigNotifyStockQty = json['use_config_notify_stock_qty'];
    notifyStockQty = json['notify_stock_qty'];
    useConfigQtyIncrements = json['use_config_qty_increments'];
    qtyIncrements = json['qty_increments'];
    useConfigEnableQtyInc = json['use_config_enable_qty_inc'];
    enableQtyIncrements = json['enable_qty_increments'];
    useConfigManageStock = json['use_config_manage_stock'];
    manageStock = json['manage_stock'];
    //  lowStockDate = json['low_stock_date'];
    isDecimalDivided = json['is_decimal_divided'];
    stockStatusChangedAuto = json['stock_status_changed_auto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['product_id'] = productId;
    data['stock_id'] = stockId;
    data['qty'] = qty;
    data['is_in_stock'] = isInStock;
    data['is_qty_decimal'] = isQtyDecimal;
    data['show_default_notification_message'] = showDefaultNotificationMessage;
    data['use_config_min_qty'] = useConfigMinQty;
    data['min_qty'] = minQty;
    data['use_config_min_sale_qty'] = useConfigMinSaleQty;
    data['min_sale_qty'] = minSaleQty;
    data['use_config_max_sale_qty'] = useConfigMaxSaleQty;
    data['max_sale_qty'] = maxSaleQty;
    data['use_config_backorders'] = useConfigBackorders;
    data['backorders'] = backorders;
    data['use_config_notify_stock_qty'] = useConfigNotifyStockQty;
    data['notify_stock_qty'] = notifyStockQty;
    data['use_config_qty_increments'] = useConfigQtyIncrements;
    data['qty_increments'] = qtyIncrements;
    data['use_config_enable_qty_inc'] = useConfigEnableQtyInc;
    data['enable_qty_increments'] = enableQtyIncrements;
    data['use_config_manage_stock'] = useConfigManageStock;
    data['manage_stock'] = manageStock;
    //   data['low_stock_date'] = this.lowStockDate;
    data['is_decimal_divided'] = isDecimalDivided;
    data['stock_status_changed_auto'] = stockStatusChangedAuto;
    return data;
  }
}

class MediaGalleryEntries {
  int? id;
  String? mediaType;
  String? label;
  int? position;
  bool? disabled;
  List<String>? types;
  String? file;

  MediaGalleryEntries(
      {this.id,
      this.mediaType,
      this.label,
      this.position,
      this.disabled,
      this.types,
      this.file});

  MediaGalleryEntries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaType = json['media_type'];
    label = json['label'];
    position = json['position'];
    disabled = json['disabled'];
    types = json['types'].cast<String>();
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['media_type'] = mediaType;
    data['label'] = label;
    data['position'] = position;
    data['disabled'] = disabled;
    data['types'] = types;
    data['file'] = file;
    return data;
  }
}
