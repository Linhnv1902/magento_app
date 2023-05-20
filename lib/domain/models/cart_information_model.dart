import 'package:magento_app/domain/models/customer_model.dart';

class CartInformationModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  bool? isVirtual;
  List<CartItem>? items;
  int? itemsCount;
  int? itemsQty;
  CustomerModel? customer;
  // BillingAddress billingAddress;
  int? origOrderId;
  Currency? currency;
  bool? customerIsGuest;
  bool? customerNoteNotify;
  int? customerTaxClassId;
  int? storeId;
//  ExtensionAttributes extensionAttributes;

  CartInformationModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.isVirtual,
    this.items,
    this.itemsCount,
    this.itemsQty,
    this.customer,
    //    this.billingAddress,
    this.origOrderId,
    this.currency,
    this.customerIsGuest,
    this.customerNoteNotify,
    this.customerTaxClassId,
    this.storeId,
    //  this.extensionAttributes,
  });

  CartInformationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    isVirtual = json['is_virtual'];
    if (json['items'] != null) {
      items = <CartItem>[];
      json['items'].forEach((v) {
        items!.add(CartItem.fromJson(v));
      });
    }
    itemsCount = json['items_count'];
    itemsQty = json['items_qty'];
    customer = json['customer'] != null
        ? new CustomerModel.fromJson(json['customer'])
        : null;
    // billingAddress = json['billing_address'] != null
    //     ? new BillingAddress.fromJson(json['billing_address'])
    //     : null;
    origOrderId = json['orig_order_id'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    customerIsGuest = json['customer_is_guest'];
    customerNoteNotify = json['customer_note_notify'];
    customerTaxClassId = json['customer_tax_class_id'];
    storeId = json['store_id'];
    // extensionAttributes = json['extension_attributes'] != null
    //     ? new ExtensionAttributes.fromJson(json['extension_attributes'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['is_virtual'] = this.isVirtual;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['items_count'] = this.itemsCount;
    data['items_qty'] = this.itemsQty;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    // if (this.billingAddress != null) {
    //   data['billing_address'] = this.billingAddress.toJson();
    // }
    data['orig_order_id'] = this.origOrderId;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    data['customer_is_guest'] = this.customerIsGuest;
    data['customer_note_notify'] = this.customerNoteNotify;
    data['customer_tax_class_id'] = this.customerTaxClassId;
    data['store_id'] = this.storeId;
    // if (this.extensionAttributes != null) {
    //   data['extension_attributes'] = this.extensionAttributes.toJson();
    // }
    return data;
  }
}

class CartItem {
  int? itemId;
  String? sku;
  int? qty;
  String? name;
  int? price;
  String? productType;
  String? quoteId;
  ProductOption? productOption;
  ExtensionAttributes? extensionAttributes;

  CartItem(
      {this.itemId,
      this.sku,
      this.qty,
      this.name,
      this.price,
      this.productType,
      this.quoteId,
      this.productOption,
      this.extensionAttributes});

  CartItem.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    sku = json['sku'];
    qty = json['qty'];
    name = json['name'];
    price = json['price'];
    productType = json['product_type'];
    quoteId = json['quote_id'];
    productOption = json['product_option'] != null
        ? new ProductOption.fromJson(json['product_option'])
        : null;
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['sku'] = this.sku;
    data['qty'] = this.qty;
    data['name'] = this.name;
    data['price'] = this.price;
    data['product_type'] = this.productType;
    data['quote_id'] = this.quoteId;
    if (this.productOption != null) {
      data['product_option'] = this.productOption!.toJson();
    }
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes!.toJson();
    }
    return data;
  }
}

class ProductOption {
  ExtensionAttributes? extensionAttributes;

  ProductOption({this.extensionAttributes});

  ProductOption.fromJson(Map<String, dynamic> json) {
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes!.toJson();
    }
    return data;
  }
}

class ExtensionAttributes {
  List<CustomOptions>? customOptions;

  ExtensionAttributes({this.customOptions});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    if (json['custom_options'] != null) {
      customOptions = <CustomOptions>[];
      json['custom_options'].forEach((v) {
        customOptions!.add(new CustomOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customOptions != null) {
      data['custom_options'] =
          this.customOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomOptions {
  String? optionId;
  String? optionValue;

  CustomOptions({this.optionId, this.optionValue});

  CustomOptions.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    optionValue = json['option_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_id'] = this.optionId;
    data['option_value'] = this.optionValue;
    return data;
  }
}

// class ExtensionAttributes {
//   List<Discounts> discounts;
//
//   ExtensionAttributes({this.discounts});
//
//   ExtensionAttributes.fromJson(Map<String, dynamic> json) {
//     if (json['discounts'] != null) {
//       discounts = new List<Discounts>();
//       json['discounts'].forEach((v) {
//         discounts.add(new Discounts.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.discounts != null) {
//       data['discounts'] = this.discounts.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Discounts {
//   DiscountData discountData;
//   String ruleLabel;
//   int ruleId;
//
//   Discounts({this.discountData, this.ruleLabel, this.ruleId});
//
//   Discounts.fromJson(Map<String, dynamic> json) {
//     discountData = json['discount_data'] != null
//         ? new DiscountData.fromJson(json['discount_data'])
//         : null;
//     ruleLabel = json['rule_label'];
//     ruleId = json['rule_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.discountData != null) {
//       data['discount_data'] = this.discountData.toJson();
//     }
//     data['rule_label'] = this.ruleLabel;
//     data['rule_id'] = this.ruleId;
//     return data;
//   }
// }
//
// class DiscountData {
//   double amount;
//   double baseAmount;
//   double originalAmount;
//   double baseOriginalAmount;
//
//   DiscountData(
//       {this.amount,
//         this.baseAmount,
//         this.originalAmount,
//         this.baseOriginalAmount});
//
//   DiscountData.fromJson(Map<String, dynamic> json) {
//     amount = json['amount'];
//     baseAmount = json['base_amount'];
//     originalAmount = json['original_amount'];
//     baseOriginalAmount = json['base_original_amount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['amount'] = this.amount;
//     data['base_amount'] = this.baseAmount;
//     data['original_amount'] = this.originalAmount;
//     data['base_original_amount'] = this.baseOriginalAmount;
//     return data;
//   }
// }
// class BillingAddress {
//   int id;
//   Null region;
//   Null regionId;
//   Null regionCode;
//   Null countryId;
//   List<String> street;
//   Null telephone;
//   Null postcode;
//   Null city;
//   Null firstname;
//   Null lastname;
//   int customerId;
//   String email;
//   int sameAsBilling;
//   int saveInAddressBook;
//
//   BillingAddress(
//       {this.id,
//         this.region,
//         this.regionId,
//         this.regionCode,
//         this.countryId,
//         this.street,
//         this.telephone,
//         this.postcode,
//         this.city,
//         this.firstname,
//         this.lastname,
//         this.customerId,
//         this.email,
//         this.sameAsBilling,
//         this.saveInAddressBook});
//
//   BillingAddress.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     region = json['region'];
//     regionId = json['region_id'];
//     regionCode = json['region_code'];
//     countryId = json['country_id'];
//     street = json['street'].cast<String>();
//     telephone = json['telephone'];
//     postcode = json['postcode'];
//     city = json['city'];
//     firstname = json['firstname'];
//     lastname = json['lastname'];
//     customerId = json['customer_id'];
//     email = json['email'];
//     sameAsBilling = json['same_as_billing'];
//     saveInAddressBook = json['save_in_address_book'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['region'] = this.region;
//     data['region_id'] = this.regionId;
//     data['region_code'] = this.regionCode;
//     data['country_id'] = this.countryId;
//     data['street'] = this.street;
//     data['telephone'] = this.telephone;
//     data['postcode'] = this.postcode;
//     data['city'] = this.city;
//     data['firstname'] = this.firstname;
//     data['lastname'] = this.lastname;
//     data['customer_id'] = this.customerId;
//     data['email'] = this.email;
//     data['same_as_billing'] = this.sameAsBilling;
//     data['save_in_address_book'] = this.saveInAddressBook;
//     return data;
//   }
// }

class Currency {
  String? globalCurrencyCode;
  String? baseCurrencyCode;
  String? storeCurrencyCode;
  String? quoteCurrencyCode;
  int? storeToBaseRate;
  int? storeToQuoteRate;
  int? baseToGlobalRate;
  int? baseToQuoteRate;

  Currency(
      {this.globalCurrencyCode,
      this.baseCurrencyCode,
      this.storeCurrencyCode,
      this.quoteCurrencyCode,
      this.storeToBaseRate,
      this.storeToQuoteRate,
      this.baseToGlobalRate,
      this.baseToQuoteRate});

  Currency.fromJson(Map<String, dynamic> json) {
    globalCurrencyCode = json['global_currency_code'];
    baseCurrencyCode = json['base_currency_code'];
    storeCurrencyCode = json['store_currency_code'];
    quoteCurrencyCode = json['quote_currency_code'];
    storeToBaseRate = json['store_to_base_rate'];
    storeToQuoteRate = json['store_to_quote_rate'];
    baseToGlobalRate = json['base_to_global_rate'];
    baseToQuoteRate = json['base_to_quote_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['global_currency_code'] = this.globalCurrencyCode;
    data['base_currency_code'] = this.baseCurrencyCode;
    data['store_currency_code'] = this.storeCurrencyCode;
    data['quote_currency_code'] = this.quoteCurrencyCode;
    data['store_to_base_rate'] = this.storeToBaseRate;
    data['store_to_quote_rate'] = this.storeToQuoteRate;
    data['base_to_global_rate'] = this.baseToGlobalRate;
    data['base_to_quote_rate'] = this.baseToQuoteRate;
    return data;
  }
}

// class ExtensionAttributes {
//   List<Null> shippingAssignments;
//
//   ExtensionAttributes({this.shippingAssignments});
//
//   ExtensionAttributes.fromJson(Map<String, dynamic> json) {
//     if (json['shipping_assignments'] != null) {
//       shippingAssignments = new List<Null>();
//       json['shipping_assignments'].forEach((v) {
//         shippingAssignments.add(new Null.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.shippingAssignments != null) {
//       data['shipping_assignments'] =
//           this.shippingAssignments.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
