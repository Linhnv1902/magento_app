import 'package:magento_app/domain/models/search_criteria_model.dart';

class GetOrdersResponseModel {
  List<OrderDetail>? items;
  SearchCriteria? searchCriteria;
  int? totalCount;

  GetOrdersResponseModel({this.items, this.searchCriteria, this.totalCount});

  GetOrdersResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <OrderDetail>[];
      json['items'].forEach((v) {
        items!.add(OrderDetail.fromJson(v));
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

class OrderDetail{
  String? appliedRuleIds;
  String? baseCurrencyCode;
  num? baseDiscountAmount;
  num? baseDiscountInvoiced;
  num? baseGrandTotal;
  num? baseDiscountTaxCompensationAmount;
  num? baseDiscountTaxCompensationInvoiced;
  num? baseShippingAmount;
  num? baseShippingDiscountAmount;
  num? baseShippingDiscountTaxCompensationAmnt;
  num? baseShippingInclTax;
  num? baseShippingInvoiced;
  num? baseShippingTaxAmount;
  num? baseSubtotal;
  num? baseSubtotalInclTax;
  num? baseSubtotalInvoiced;
  num? baseTaxAmount;
  num? baseTaxInvoiced;
  num? baseTotalDue;
  num? baseTotalInvoiced;
  num? baseTotalInvoicedCost;
  num? baseTotalPaid;
  num? baseToGlobalRate;
  num? baseToOrderRate;
  num? billingAddressId;
  String? createdAt;
  String? customerDob;
  String? customerEmail;
  String? customerFirstname;
  num? customerGender;
  num? customerGroupId;
  num? customerId;
  num? customerIsGuest;
  String? customerLastname;
  num? customerNoteNotify;
  num? discountAmount;
  num? discountInvoiced;
  num? entityId;
  String? globalCurrencyCode;
  num? grandTotal;
  num? discountTaxCompensationAmount;
  num? discountTaxCompensationInvoiced;
  String? incrementId;
  num? isVirtual;
  String? orderCurrencyCode;
  String? protectCode;
  num? quoteId;
  num? shippingAmount;
  String? shippingDescription;
  num? shippingDiscountAmount;
  num? shippingDiscountTaxCompensationAmount;
  num? shippingInclTax;
  num? shippingInvoiced;
  num? shippingTaxAmount;
  String? state;
  String? status;
  String? storeCurrencyCode;
  num? storeId;
  String? storeName;
  num? storeToBaseRate;
  num? storeToOrderRate;
  num? subtotal;
  num? subtotalInclTax;
  num? subtotalInvoiced;
  num? taxAmount;
  num? taxInvoiced;
  num? totalDue;
  num? totalInvoiced;
  num? totalItemCount;
  num? totalPaid;
  num? totalQtyOrdered;
  String? updatedAt;
  num? weight;
  List<Items>? items;
  BillingAddress? billingAddress;
  Payment? payment;
  List<StatusHistories>? statusHistories;
  ExtensionAttributesOrder? extensionAttributesOrder;
  num? adjustmentNegative;
  num? adjustmentPositive;
  num? baseAdjustmentNegative;
  num? baseAdjustmentPositive;
  num? baseDiscountRefunded;
  num? baseDiscountTaxCompensationRefunded;
  num? baseShippingRefunded;
  num? baseShippingTaxRefunded;
  num? baseSubtotalRefunded;
  num? baseTaxRefunded;
  num? baseTotalOfflineRefunded;
  num? baseTotalRefunded;
  num? discountRefunded;
  num? discountTaxCompensationRefunded;
  num? shippingRefunded;
  num? shippingTaxRefunded;
  num? subtotalRefunded;
  num? taxRefunded;
  num? totalOfflineRefunded;
  num? totalRefunded;
  String? remoteIp;

  OrderDetail(
      {this.appliedRuleIds,
        this.baseCurrencyCode,
        this.baseDiscountAmount,
        this.baseDiscountInvoiced,
        this.baseGrandTotal,
        this.baseDiscountTaxCompensationAmount,
        this.baseDiscountTaxCompensationInvoiced,
        this.baseShippingAmount,
        this.baseShippingDiscountAmount,
        this.baseShippingDiscountTaxCompensationAmnt,
        this.baseShippingInclTax,
        this.baseShippingInvoiced,
        this.baseShippingTaxAmount,
        this.baseSubtotal,
        this.baseSubtotalInclTax,
        this.baseSubtotalInvoiced,
        this.baseTaxAmount,
        this.baseTaxInvoiced,
        this.baseTotalDue,
        this.baseTotalInvoiced,
        this.baseTotalInvoicedCost,
        this.baseTotalPaid,
        this.baseToGlobalRate,
        this.baseToOrderRate,
        this.billingAddressId,
        this.createdAt,
        this.customerDob,
        this.customerEmail,
        this.customerFirstname,
        this.customerGender,
        this.customerGroupId,
        this.customerId,
        this.customerIsGuest,
        this.customerLastname,
        this.customerNoteNotify,
        this.discountAmount,
        this.discountInvoiced,
        this.entityId,
        this.globalCurrencyCode,
        this.grandTotal,
        this.discountTaxCompensationAmount,
        this.discountTaxCompensationInvoiced,
        this.incrementId,
        this.isVirtual,
        this.orderCurrencyCode,
        this.protectCode,
        this.quoteId,
        this.shippingAmount,
        this.shippingDescription,
        this.shippingDiscountAmount,
        this.shippingDiscountTaxCompensationAmount,
        this.shippingInclTax,
        this.shippingInvoiced,
        this.shippingTaxAmount,
        this.state,
        this.status,
        this.storeCurrencyCode,
        this.storeId,
        this.storeName,
        this.storeToBaseRate,
        this.storeToOrderRate,
        this.subtotal,
        this.subtotalInclTax,
        this.subtotalInvoiced,
        this.taxAmount,
        this.taxInvoiced,
        this.totalDue,
        this.totalInvoiced,
        this.totalItemCount,
        this.totalPaid,
        this.totalQtyOrdered,
        this.updatedAt,
        this.weight,
        this.items,
        this.billingAddress,
        this.payment,
        this.statusHistories,
        this.extensionAttributesOrder,
        this.adjustmentNegative,
        this.adjustmentPositive,
        this.baseAdjustmentNegative,
        this.baseAdjustmentPositive,
        this.baseDiscountRefunded,
        this.baseDiscountTaxCompensationRefunded,
        this.baseShippingRefunded,
        this.baseShippingTaxRefunded,
        this.baseSubtotalRefunded,
        this.baseTaxRefunded,
        this.baseTotalOfflineRefunded,
        this.baseTotalRefunded,
        this.discountRefunded,
        this.discountTaxCompensationRefunded,
        this.shippingRefunded,
        this.shippingTaxRefunded,
        this.subtotalRefunded,
        this.taxRefunded,
        this.totalOfflineRefunded,
        this.totalRefunded,
        this.remoteIp});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    appliedRuleIds = json['applied_rule_ids'];
    baseCurrencyCode = json['base_currency_code'];
    baseDiscountAmount = json['base_discount_amount'];
    baseDiscountInvoiced = json['base_discount_invoiced'];
    baseGrandTotal = json['base_grand_total'];
    baseDiscountTaxCompensationAmount =
    json['base_discount_tax_compensation_amount'];
    baseDiscountTaxCompensationInvoiced =
    json['base_discount_tax_compensation_invoiced'];
    baseShippingAmount = json['base_shipping_amount'];
    baseShippingDiscountAmount = json['base_shipping_discount_amount'];
    baseShippingDiscountTaxCompensationAmnt =
    json['base_shipping_discount_tax_compensation_amnt'];
    baseShippingInclTax = json['base_shipping_incl_tax'];
    baseShippingInvoiced = json['base_shipping_invoiced'];
    baseShippingTaxAmount = json['base_shipping_tax_amount'];
    baseSubtotal = json['base_subtotal'];
    baseSubtotalInclTax = json['base_subtotal_incl_tax'];
    baseSubtotalInvoiced = json['base_subtotal_invoiced'];
    baseTaxAmount = json['base_tax_amount'];
    baseTaxInvoiced = json['base_tax_invoiced'];
    baseTotalDue = json['base_total_due'];
    baseTotalInvoiced = json['base_total_invoiced'];
    baseTotalInvoicedCost = json['base_total_invoiced_cost'];
    baseTotalPaid = json['base_total_paid'];
    baseToGlobalRate = json['base_to_global_rate'];
    baseToOrderRate = json['base_to_order_rate'];
    billingAddressId = json['billing_address_id'];
    createdAt = json['created_at'];
    customerDob = json['customer_dob'];
    customerEmail = json['customer_email'];
    customerFirstname = json['customer_firstname'];
    customerGender = json['customer_gender'];
    customerGroupId = json['customer_group_id'];
    customerId = json['customer_id'];
    customerIsGuest = json['customer_is_guest'];
    customerLastname = json['customer_lastname'];
    customerNoteNotify = json['customer_note_notify'];
    discountAmount = json['discount_amount'];
    discountInvoiced = json['discount_invoiced'];
    entityId = json['entity_id'];
    globalCurrencyCode = json['global_currency_code'];
    grandTotal = json['grand_total'];
    discountTaxCompensationAmount = json['discount_tax_compensation_amount'];
    discountTaxCompensationInvoiced =
    json['discount_tax_compensation_invoiced'];
    incrementId = json['increment_id'];
    isVirtual = json['is_virtual'];
    orderCurrencyCode = json['order_currency_code'];
    protectCode = json['protect_code'];
    quoteId = json['quote_id'];
    shippingAmount = json['shipping_amount'];
    shippingDescription = json['shipping_description'];
    shippingDiscountAmount = json['shipping_discount_amount'];
    shippingDiscountTaxCompensationAmount =
    json['shipping_discount_tax_compensation_amount'];
    shippingInclTax = json['shipping_incl_tax'];
    shippingInvoiced = json['shipping_invoiced'];
    shippingTaxAmount = json['shipping_tax_amount'];
    state = json['state'];
    status = json['status'];
    storeCurrencyCode = json['store_currency_code'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeToBaseRate = json['store_to_base_rate'];
    storeToOrderRate = json['store_to_order_rate'];
    subtotal = json['subtotal'];
    subtotalInclTax = json['subtotal_incl_tax'];
    subtotalInvoiced = json['subtotal_invoiced'];
    taxAmount = json['tax_amount'];
    taxInvoiced = json['tax_invoiced'];
    totalDue = json['total_due'];
    totalInvoiced = json['total_invoiced'];
    totalItemCount = json['total_item_count'];
    totalPaid = json['total_paid'];
    totalQtyOrdered = json['total_qty_ordered'];
    updatedAt = json['updated_at'];
    weight = json['weight'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    billingAddress = json['billing_address'] != null
        ? BillingAddress.fromJson(json['billing_address'])
        : null;
    payment =
    json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    if (json['status_histories'] != null) {
      statusHistories = <StatusHistories>[];
      json['status_histories'].forEach((v) {
        statusHistories!.add(StatusHistories.fromJson(v));
      });
    }
    extensionAttributesOrder = json['extension_attributes'] != null
        ? ExtensionAttributesOrder.fromJson(json['extension_attributes'])
        : null;
    adjustmentNegative = json['adjustment_negative'];
    adjustmentPositive = json['adjustment_positive'];
    baseAdjustmentNegative = json['base_adjustment_negative'];
    baseAdjustmentPositive = json['base_adjustment_positive'];
    baseDiscountRefunded = json['base_discount_refunded'];
    baseDiscountTaxCompensationRefunded =
    json['base_discount_tax_compensation_refunded'];
    baseShippingRefunded = json['base_shipping_refunded'];
    baseShippingTaxRefunded = json['base_shipping_tax_refunded'];
    baseSubtotalRefunded = json['base_subtotal_refunded'];
    baseTaxRefunded = json['base_tax_refunded'];
    baseTotalOfflineRefunded = json['base_total_offline_refunded'];
    baseTotalRefunded = json['base_total_refunded'];
    discountRefunded = json['discount_refunded'];
    discountTaxCompensationRefunded =
    json['discount_tax_compensation_refunded'];
    shippingRefunded = json['shipping_refunded'];
    shippingTaxRefunded = json['shipping_tax_refunded'];
    subtotalRefunded = json['subtotal_refunded'];
    taxRefunded = json['tax_refunded'];
    totalOfflineRefunded = json['total_offline_refunded'];
    totalRefunded = json['total_refunded'];
    remoteIp = json['remote_ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['applied_rule_ids'] = appliedRuleIds;
    data['base_currency_code'] = baseCurrencyCode;
    data['base_discount_amount'] = baseDiscountAmount;
    data['base_discount_invoiced'] = baseDiscountInvoiced;
    data['base_grand_total'] = baseGrandTotal;
    data['base_discount_tax_compensation_amount'] =
        baseDiscountTaxCompensationAmount;
    data['base_discount_tax_compensation_invoiced'] =
        baseDiscountTaxCompensationInvoiced;
    data['base_shipping_amount'] = baseShippingAmount;
    data['base_shipping_discount_amount'] = baseShippingDiscountAmount;
    data['base_shipping_discount_tax_compensation_amnt'] =
        baseShippingDiscountTaxCompensationAmnt;
    data['base_shipping_incl_tax'] = baseShippingInclTax;
    data['base_shipping_invoiced'] = baseShippingInvoiced;
    data['base_shipping_tax_amount'] = baseShippingTaxAmount;
    data['base_subtotal'] = baseSubtotal;
    data['base_subtotal_incl_tax'] = baseSubtotalInclTax;
    data['base_subtotal_invoiced'] = baseSubtotalInvoiced;
    data['base_tax_amount'] = baseTaxAmount;
    data['base_tax_invoiced'] = baseTaxInvoiced;
    data['base_total_due'] = baseTotalDue;
    data['base_total_invoiced'] = baseTotalInvoiced;
    data['base_total_invoiced_cost'] = baseTotalInvoicedCost;
    data['base_total_paid'] = baseTotalPaid;
    data['base_to_global_rate'] = baseToGlobalRate;
    data['base_to_order_rate'] = baseToOrderRate;
    data['billing_address_id'] = billingAddressId;
    data['created_at'] = createdAt;
    data['customer_dob'] = customerDob;
    data['customer_email'] = customerEmail;
    data['customer_firstname'] = customerFirstname;
    data['customer_gender'] = customerGender;
    data['customer_group_id'] = customerGroupId;
    data['customer_id'] = customerId;
    data['customer_is_guest'] = customerIsGuest;
    data['customer_lastname'] = customerLastname;
    data['customer_note_notify'] = customerNoteNotify;
    data['discount_amount'] = discountAmount;
    data['discount_invoiced'] = discountInvoiced;
    data['entity_id'] = entityId;
    data['global_currency_code'] = globalCurrencyCode;
    data['grand_total'] = grandTotal;
    data['discount_tax_compensation_amount'] =
        discountTaxCompensationAmount;
    data['discount_tax_compensation_invoiced'] =
        discountTaxCompensationInvoiced;
    data['increment_id'] = incrementId;
    data['is_virtual'] = isVirtual;
    data['order_currency_code'] = orderCurrencyCode;
    data['protect_code'] = protectCode;
    data['quote_id'] = quoteId;
    data['shipping_amount'] = shippingAmount;
    data['shipping_description'] = shippingDescription;
    data['shipping_discount_amount'] = shippingDiscountAmount;
    data['shipping_discount_tax_compensation_amount'] =
        shippingDiscountTaxCompensationAmount;
    data['shipping_incl_tax'] = shippingInclTax;
    data['shipping_invoiced'] = shippingInvoiced;
    data['shipping_tax_amount'] = shippingTaxAmount;
    data['state'] = state;
    data['status'] = status;
    data['store_currency_code'] = storeCurrencyCode;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['store_to_base_rate'] = storeToBaseRate;
    data['store_to_order_rate'] = storeToOrderRate;
    data['subtotal'] = subtotal;
    data['subtotal_incl_tax'] = subtotalInclTax;
    data['subtotal_invoiced'] = subtotalInvoiced;
    data['tax_amount'] = taxAmount;
    data['tax_invoiced'] = taxInvoiced;
    data['total_due'] = totalDue;
    data['total_invoiced'] = totalInvoiced;
    data['total_item_count'] = totalItemCount;
    data['total_paid'] = totalPaid;
    data['total_qty_ordered'] = totalQtyOrdered;
    data['updated_at'] = updatedAt;
    data['weight'] = weight;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (billingAddress != null) {
      data['billing_address'] = billingAddress!.toJson();
    }
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    if (statusHistories != null) {
      data['status_histories'] =
          statusHistories!.map((v) => v.toJson()).toList();
    }
    if (extensionAttributesOrder != null) {
      data['extension_attributes'] = extensionAttributesOrder!.toJson();
    }
    data['adjustment_negative'] = adjustmentNegative;
    data['adjustment_positive'] = adjustmentPositive;
    data['base_adjustment_negative'] = baseAdjustmentNegative;
    data['base_adjustment_positive'] = baseAdjustmentPositive;
    data['base_discount_refunded'] = baseDiscountRefunded;
    data['base_discount_tax_compensation_refunded'] =
        baseDiscountTaxCompensationRefunded;
    data['base_shipping_refunded'] = baseShippingRefunded;
    data['base_shipping_tax_refunded'] = baseShippingTaxRefunded;
    data['base_subtotal_refunded'] = baseSubtotalRefunded;
    data['base_tax_refunded'] = baseTaxRefunded;
    data['base_total_offline_refunded'] = baseTotalOfflineRefunded;
    data['base_total_refunded'] = baseTotalRefunded;
    data['discount_refunded'] = discountRefunded;
    data['discount_tax_compensation_refunded'] =
        discountTaxCompensationRefunded;
    data['shipping_refunded'] = shippingRefunded;
    data['shipping_tax_refunded'] = shippingTaxRefunded;
    data['subtotal_refunded'] = subtotalRefunded;
    data['tax_refunded'] = taxRefunded;
    data['total_offline_refunded'] = totalOfflineRefunded;
    data['total_refunded'] = totalRefunded;
    data['remote_ip'] = remoteIp;
    return data;
  }
}

class Items {
  num? amountRefunded;
  String? appliedRuleIds;
  num? baseAmountRefunded;
  num? baseDiscountAmount;
  num? baseDiscountInvoiced;
  num? baseDiscountTaxCompensationAmount;
  num? baseDiscountTaxCompensationInvoiced;
  num? baseOriginalPrice;
  num? basePrice;
  num? basePriceInclTax;
  num? baseRowInvoiced;
  num? baseRowTotal;
  num? baseRowTotalInclTax;
  num? baseTaxAmount;
  num? baseTaxInvoiced;
  String? createdAt;
  num? discountAmount;
  num? discountInvoiced;
  num? discountPercent;
  num? freeShipping;
  num? discountTaxCompensationAmount;
  num? discountTaxCompensationInvoiced;
  num? isQtyDecimal;
  num? itemId;
  String? name;
  num? noDiscount;
  num? orderId;
  num? originalPrice;
  num? price;
  num? priceInclTax;
  num? productId;
  String? productType;
  num? qtyCanceled;
  num? qtyInvoiced;
  num? qtyOrdered;
  num? qtyRefunded;
  num? qtyShipped;
  num? rowInvoiced;
  num? rowTotal;
  num? rowTotalInclTax;
  num? rowWeight;
  String? sku;
  num? storeId;
  num? taxAmount;
  num? taxInvoiced;
  num? taxPercent;
  String? updatedAt;
  num? weight;
  ProductOption? productOption;
  num? baseDiscountRefunded;
  num? baseDiscountTaxCompensationRefunded;
  num? baseTaxRefunded;
  num? discountRefunded;
  num? discountTaxCompensationRefunded;
  num? taxRefunded;
  String? weeeTaxApplied;
  num? isVirtual;
  num? quoteItemId;

  Items(
      {this.amountRefunded,
        this.appliedRuleIds,
        this.baseAmountRefunded,
        this.baseDiscountAmount,
        this.baseDiscountInvoiced,
        this.baseDiscountTaxCompensationAmount,
        this.baseDiscountTaxCompensationInvoiced,
        this.baseOriginalPrice,
        this.basePrice,
        this.basePriceInclTax,
        this.baseRowInvoiced,
        this.baseRowTotal,
        this.baseRowTotalInclTax,
        this.baseTaxAmount,
        this.baseTaxInvoiced,
        this.createdAt,
        this.discountAmount,
        this.discountInvoiced,
        this.discountPercent,
        this.freeShipping,
        this.discountTaxCompensationAmount,
        this.discountTaxCompensationInvoiced,
        this.isQtyDecimal,
        this.itemId,
        this.name,
        this.noDiscount,
        this.orderId,
        this.originalPrice,
        this.price,
        this.priceInclTax,
        this.productId,
        this.productType,
        this.qtyCanceled,
        this.qtyInvoiced,
        this.qtyOrdered,
        this.qtyRefunded,
        this.qtyShipped,
        this.rowInvoiced,
        this.rowTotal,
        this.rowTotalInclTax,
        this.rowWeight,
        this.sku,
        this.storeId,
        this.taxAmount,
        this.taxInvoiced,
        this.taxPercent,
        this.updatedAt,
        this.weight,
        this.productOption,
        this.baseDiscountRefunded,
        this.baseDiscountTaxCompensationRefunded,
        this.baseTaxRefunded,
        this.discountRefunded,
        this.discountTaxCompensationRefunded,
        this.taxRefunded,
        this.weeeTaxApplied,
        this.isVirtual,
        this.quoteItemId});

  Items.fromJson(Map<String, dynamic> json) {
    amountRefunded = json['amount_refunded'];
    appliedRuleIds = json['applied_rule_ids'];
    baseAmountRefunded = json['base_amount_refunded'];
    baseDiscountAmount = json['base_discount_amount'];
    baseDiscountInvoiced = json['base_discount_invoiced'];
    baseDiscountTaxCompensationAmount =
    json['base_discount_tax_compensation_amount'];
    baseDiscountTaxCompensationInvoiced =
    json['base_discount_tax_compensation_invoiced'];
    baseOriginalPrice = json['base_original_price'];
    basePrice = json['base_price'];
    basePriceInclTax = json['base_price_incl_tax'];
    baseRowInvoiced = json['base_row_invoiced'];
    baseRowTotal = json['base_row_total'];
    baseRowTotalInclTax = json['base_row_total_incl_tax'];
    baseTaxAmount = json['base_tax_amount'];
    baseTaxInvoiced = json['base_tax_invoiced'];
    createdAt = json['created_at'];
    discountAmount = json['discount_amount'];
    discountInvoiced = json['discount_invoiced'];
    discountPercent = json['discount_percent'];
    freeShipping = json['free_shipping'];
    discountTaxCompensationAmount = json['discount_tax_compensation_amount'];
    discountTaxCompensationInvoiced =
    json['discount_tax_compensation_invoiced'];
    isQtyDecimal = json['is_qty_decimal'];
    itemId = json['item_id'];
    name = json['name'];
    noDiscount = json['no_discount'];
    orderId = json['order_id'];
    originalPrice = json['original_price'];
    price = json['price'];
    priceInclTax = json['price_incl_tax'];
    productId = json['product_id'];
    productType = json['product_type'];
    qtyCanceled = json['qty_canceled'];
    qtyInvoiced = json['qty_invoiced'];
    qtyOrdered = json['qty_ordered'];
    qtyRefunded = json['qty_refunded'];
    qtyShipped = json['qty_shipped'];
    rowInvoiced = json['row_invoiced'];
    rowTotal = json['row_total'];
    rowTotalInclTax = json['row_total_incl_tax'];
    rowWeight = json['row_weight'];
    sku = json['sku'];
    storeId = json['store_id'];
    taxAmount = json['tax_amount'];
    taxInvoiced = json['tax_invoiced'];
    taxPercent = json['tax_percent'];
    updatedAt = json['updated_at'];
    weight = json['weight'];
    productOption = json['product_option'] != null
        ? ProductOption.fromJson(json['product_option'])
        : null;
    baseDiscountRefunded = json['base_discount_refunded'];
    baseDiscountTaxCompensationRefunded =
    json['base_discount_tax_compensation_refunded'];
    baseTaxRefunded = json['base_tax_refunded'];
    discountRefunded = json['discount_refunded'];
    discountTaxCompensationRefunded =
    json['discount_tax_compensation_refunded'];
    taxRefunded = json['tax_refunded'];
    weeeTaxApplied = json['weee_tax_applied'];
    isVirtual = json['is_virtual'];
    quoteItemId = json['quote_item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount_refunded'] = amountRefunded;
    data['applied_rule_ids'] = appliedRuleIds;
    data['base_amount_refunded'] = baseAmountRefunded;
    data['base_discount_amount'] = baseDiscountAmount;
    data['base_discount_invoiced'] = baseDiscountInvoiced;
    data['base_discount_tax_compensation_amount'] =
        baseDiscountTaxCompensationAmount;
    data['base_discount_tax_compensation_invoiced'] =
        baseDiscountTaxCompensationInvoiced;
    data['base_original_price'] = baseOriginalPrice;
    data['base_price'] = basePrice;
    data['base_price_incl_tax'] = basePriceInclTax;
    data['base_row_invoiced'] = baseRowInvoiced;
    data['base_row_total'] = baseRowTotal;
    data['base_row_total_incl_tax'] = baseRowTotalInclTax;
    data['base_tax_amount'] = baseTaxAmount;
    data['base_tax_invoiced'] = baseTaxInvoiced;
    data['created_at'] = createdAt;
    data['discount_amount'] = discountAmount;
    data['discount_invoiced'] = discountInvoiced;
    data['discount_percent'] = discountPercent;
    data['free_shipping'] = freeShipping;
    data['discount_tax_compensation_amount'] =
        discountTaxCompensationAmount;
    data['discount_tax_compensation_invoiced'] =
        discountTaxCompensationInvoiced;
    data['is_qty_decimal'] = isQtyDecimal;
    data['item_id'] = itemId;
    data['name'] = name;
    data['no_discount'] = noDiscount;
    data['order_id'] = orderId;
    data['original_price'] = originalPrice;
    data['price'] = price;
    data['price_incl_tax'] = priceInclTax;
    data['product_id'] = productId;
    data['product_type'] = productType;
    data['qty_canceled'] = qtyCanceled;
    data['qty_invoiced'] = qtyInvoiced;
    data['qty_ordered'] = qtyOrdered;
    data['qty_refunded'] = qtyRefunded;
    data['qty_shipped'] = qtyShipped;
    data['row_invoiced'] = rowInvoiced;
    data['row_total'] = rowTotal;
    data['row_total_incl_tax'] = rowTotalInclTax;
    data['row_weight'] = rowWeight;
    data['sku'] = sku;
    data['store_id'] = storeId;
    data['tax_amount'] = taxAmount;
    data['tax_invoiced'] = taxInvoiced;
    data['tax_percent'] = taxPercent;
    data['updated_at'] = updatedAt;
    data['weight'] = weight;
    if (productOption != null) {
      data['product_option'] = productOption!.toJson();
    }
    data['base_discount_refunded'] = baseDiscountRefunded;
    data['base_discount_tax_compensation_refunded'] =
        baseDiscountTaxCompensationRefunded;
    data['base_tax_refunded'] = baseTaxRefunded;
    data['discount_refunded'] = discountRefunded;
    data['discount_tax_compensation_refunded'] =
        discountTaxCompensationRefunded;
    data['tax_refunded'] = taxRefunded;
    data['weee_tax_applied'] = weeeTaxApplied;
    data['is_virtual'] = isVirtual;
    data['quote_item_id'] = quoteItemId;
    return data;
  }
}

class ProductOption {
  ExtensionAttributes? extensionAttributes;

  ProductOption({this.extensionAttributes});

  ProductOption.fromJson(Map<String, dynamic> json) {
    extensionAttributes = json['extension_attributes'] != null
        ? ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (extensionAttributes != null) {
      data['extension_attributes'] = extensionAttributes!.toJson();
    }
    return data;
  }
}

class ExtensionAttributes {
  List<ConfigurableItemOptions>? configurableItemOptions;
  List<CustomOptions>? customOptions;

  ExtensionAttributes({this.configurableItemOptions, this.customOptions});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    if (json['configurable_item_options'] != null) {
      configurableItemOptions = <ConfigurableItemOptions>[];
      json['configurable_item_options'].forEach((v) {
        configurableItemOptions!.add(ConfigurableItemOptions.fromJson(v));
      });
    }
    if (json['custom_options'] != null) {
      customOptions = <CustomOptions>[];
      json['custom_options'].forEach((v) {
        customOptions!.add(CustomOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (configurableItemOptions != null) {
      data['configurable_item_options'] =
          configurableItemOptions!.map((v) => v.toJson()).toList();
    }
    if (customOptions != null) {
      data['custom_options'] =
          customOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConfigurableItemOptions {
  String? optionId;
  num? optionValue;

  ConfigurableItemOptions({this.optionId, this.optionValue});

  ConfigurableItemOptions.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    optionValue = json['option_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option_id'] = optionId;
    data['option_value'] = optionValue;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option_id'] = optionId;
    data['option_value'] = optionValue;
    return data;
  }
}

class BillingAddress {
  String? addressType;
  String? city;
  String? countryId;
  num? customerAddressId;
  String? email;
  num? entityId;
  String? firstname;
  String? lastname;
  num? parentId;
  String? postcode;
  String? region;
  String? regionCode;
  num? regionId;
  List<String>? street;
  String? telephone;

  BillingAddress(
      {this.addressType,
        this.city,
        this.countryId,
        this.customerAddressId,
        this.email,
        this.entityId,
        this.firstname,
        this.lastname,
        this.parentId,
        this.postcode,
        this.region,
        this.regionCode,
        this.regionId,
        this.street,
        this.telephone});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    addressType = json['address_type'];
    city = json['city'];
    countryId = json['country_id'];
    customerAddressId = json['customer_address_id'];
    email = json['email'];
    entityId = json['entity_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    parentId = json['parent_id'];
    postcode = json['postcode'];
    region = json['region'];
    regionCode = json['region_code'];
    regionId = json['region_id'];
    street = json['street'].cast<String>();
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_type'] = addressType;
    data['city'] = city;
    data['country_id'] = countryId;
    data['customer_address_id'] = customerAddressId;
    data['email'] = email;
    data['entity_id'] = entityId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['parent_id'] = parentId;
    data['postcode'] = postcode;
    data['region'] = region;
    data['region_code'] = regionCode;
    data['region_id'] = regionId;
    data['street'] = street;
    data['telephone'] = telephone;
    return data;
  }
}

class Payment {
  //Null accountStatus;
  List<String>? additionalInformation;
  num? amountOrdered;
  num? amountPaid;
  num? baseAmountOrdered;
  num? baseAmountPaid;
  num? baseShippingAmount;
  num? baseShippingCaptured;
  //Null ccLast4;
  num? entityId;
  String? method;
  num? parentId;
  num? shippingAmount;
  num? shippingCaptured;
  num? amountRefunded;
  num? baseAmountRefunded;
  num? baseShippingRefunded;
  num? shippingRefunded;
  String? ccExpYear;
  String? ccSsStartMonth;
  String? ccSsStartYear;

  Payment(
      {
        //this.accountStatus,
        this.additionalInformation,
        this.amountOrdered,
        this.amountPaid,
        this.baseAmountOrdered,
        this.baseAmountPaid,
        this.baseShippingAmount,
        this.baseShippingCaptured,
      //  this.ccLast4,
        this.entityId,
        this.method,
        this.parentId,
        this.shippingAmount,
        this.shippingCaptured,
        this.amountRefunded,
        this.baseAmountRefunded,
        this.baseShippingRefunded,
        this.shippingRefunded,
        this.ccExpYear,
        this.ccSsStartMonth,
        this.ccSsStartYear});

  Payment.fromJson(Map<String, dynamic> json) {
   // accountStatus = json['account_status'];
    additionalInformation = json['additional_information'].cast<String>();
    amountOrdered = json['amount_ordered'];
    amountPaid = json['amount_paid'];
    baseAmountOrdered = json['base_amount_ordered'];
    baseAmountPaid = json['base_amount_paid'];
    baseShippingAmount = json['base_shipping_amount'];
    baseShippingCaptured = json['base_shipping_captured'];
    //ccLast4 = json['cc_last4'];
    entityId = json['entity_id'];
    method = json['method'];
    parentId = json['parent_id'];
    shippingAmount = json['shipping_amount'];
    shippingCaptured = json['shipping_captured'];
    amountRefunded = json['amount_refunded'];
    baseAmountRefunded = json['base_amount_refunded'];
    baseShippingRefunded = json['base_shipping_refunded'];
    shippingRefunded = json['shipping_refunded'];
    ccExpYear = json['cc_exp_year'];
    ccSsStartMonth = json['cc_ss_start_month'];
    ccSsStartYear = json['cc_ss_start_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
   // data['account_status'] = accountStatus;
    data['additional_information'] = additionalInformation;
    data['amount_ordered'] = amountOrdered;
    data['amount_paid'] = amountPaid;
    data['base_amount_ordered'] = baseAmountOrdered;
    data['base_amount_paid'] = baseAmountPaid;
    data['base_shipping_amount'] = baseShippingAmount;
    data['base_shipping_captured'] = baseShippingCaptured;
  //  data['cc_last4'] = ccLast4;
    data['entity_id'] = entityId;
    data['method'] = method;
    data['parent_id'] = parentId;
    data['shipping_amount'] = shippingAmount;
    data['shipping_captured'] = shippingCaptured;
    data['amount_refunded'] = amountRefunded;
    data['base_amount_refunded'] = baseAmountRefunded;
    data['base_shipping_refunded'] = baseShippingRefunded;
    data['shipping_refunded'] = shippingRefunded;
    data['cc_exp_year'] = ccExpYear;
    data['cc_ss_start_month'] = ccSsStartMonth;
    data['cc_ss_start_year'] = ccSsStartYear;
    return data;
  }
}

class StatusHistories {
  String? comment;
  String? createdAt;
  num? entityId;
  String? entityName;
  num? isCustomerNotified;
  num? isVisibleOnFront;
  num? parentId;
  String? status;

  StatusHistories(
      {this.comment,
        this.createdAt,
        this.entityId,
        this.entityName,
        this.isCustomerNotified,
        this.isVisibleOnFront,
        this.parentId,
        this.status});

  StatusHistories.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    createdAt = json['created_at'];
    entityId = json['entity_id'];
    entityName = json['entity_name'];
    isCustomerNotified = json['is_customer_notified'];
    isVisibleOnFront = json['is_visible_on_front'];
    parentId = json['parent_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = comment;
    data['created_at'] = createdAt;
    data['entity_id'] = entityId;
    data['entity_name'] = entityName;
    data['is_customer_notified'] = isCustomerNotified;
    data['is_visible_on_front'] = isVisibleOnFront;
    data['parent_id'] = parentId;
    data['status'] = status;
    return data;
  }
}

class ExtensionAttributesOrder {
  List<ShippingAssignments>? shippingAssignments;
  List<PaymentAdditionalInfo>? paymentAdditionalInfo;
  List<AppliedTaxes>? appliedTaxes;
  List<ItemAppliedTaxes>? itemAppliedTaxes;
  bool? convertingFromQuote;

  ExtensionAttributesOrder(
      {this.shippingAssignments,
        this.paymentAdditionalInfo,
        this.appliedTaxes,
        this.itemAppliedTaxes,
        this.convertingFromQuote});

  ExtensionAttributesOrder.fromJson(Map<String, dynamic> json) {
    if (json['shipping_assignments'] != null) {
      shippingAssignments =  <ShippingAssignments>[];
      json['shipping_assignments'].forEach((v) {
        shippingAssignments!.add(ShippingAssignments.fromJson(v));
      });
    }
    if (json['payment_additional_info'] != null) {
      paymentAdditionalInfo =  <PaymentAdditionalInfo>[];
      json['payment_additional_info'].forEach((v) {
        paymentAdditionalInfo!.add(PaymentAdditionalInfo.fromJson(v));
      });
    }
    if (json['applied_taxes'] != null) {
      appliedTaxes =  <AppliedTaxes>[];
      json['applied_taxes'].forEach((v) {
        appliedTaxes!.add(AppliedTaxes.fromJson(v));
      });
    }
    if (json['item_applied_taxes'] != null) {
      itemAppliedTaxes =<ItemAppliedTaxes>[];
      json['item_applied_taxes'].forEach((v) {
        itemAppliedTaxes!.add(ItemAppliedTaxes.fromJson(v));
      });
    }
    convertingFromQuote = json['converting_from_quote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shippingAssignments != null) {
      data['shipping_assignments'] =
          shippingAssignments!.map((v) => v.toJson()).toList();
    }
    if (paymentAdditionalInfo != null) {
      data['payment_additional_info'] =
          paymentAdditionalInfo!.map((v) => v.toJson()).toList();
    }
    if (appliedTaxes != null) {
      data['applied_taxes'] = appliedTaxes!.map((v) => v.toJson()).toList();
    }
    if (itemAppliedTaxes != null) {
      data['item_applied_taxes'] =
          itemAppliedTaxes!.map((v) => v.toJson()).toList();
    }
    data['converting_from_quote'] = convertingFromQuote;
    return data;
  }
}

class ShippingAssignments {
  Shipping? shipping;
  List<Items>? items;

  ShippingAssignments({this.shipping, this.items});

  ShippingAssignments.fromJson(Map<String, dynamic> json) {
    shipping = json['shipping'] != null
        ? Shipping.fromJson(json['shipping'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shipping {
  Address? address;
  String? method;
  Total? total;

  Shipping({this.address, this.method, this.total});

  Shipping.fromJson(Map<String, dynamic> json) {
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    method = json['method'];
    total = json['total'] != null ? Total.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['method'] = method;
    if (total != null) {
      data['total'] = total!.toJson();
    }
    return data;
  }
}

class Address {
  String? addressType;
  String? city;
  String? countryId;
  num? customerAddressId;
  String? email;
  num? entityId;
  String? firstname;
  String? lastname;
  num? parentId;
  String? postcode;
  String? region;
  String? regionCode;
  num? regionId;
  List<String>? street;
  String? telephone;
  String? company;

  Address(
      {this.addressType,
        this.city,
        this.countryId,
        this.customerAddressId,
        this.email,
        this.entityId,
        this.firstname,
        this.lastname,
        this.parentId,
        this.postcode,
        this.region,
        this.regionCode,
        this.regionId,
        this.street,
        this.telephone,
        this.company});

  Address.fromJson(Map<String, dynamic> json) {
    addressType = json['address_type'];
    city = json['city'];
    countryId = json['country_id'];
    customerAddressId = json['customer_address_id'];
    email = json['email'];
    entityId = json['entity_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    parentId = json['parent_id'];
    postcode = json['postcode'];
    region = json['region'];
    regionCode = json['region_code'];
    regionId = json['region_id'];
    street = json['street'].cast<String>();
    telephone = json['telephone'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_type'] = addressType;
    data['city'] = city;
    data['country_id'] = countryId;
    data['customer_address_id'] = customerAddressId;
    data['email'] = email;
    data['entity_id'] = entityId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['parent_id'] = parentId;
    data['postcode'] = postcode;
    data['region'] = region;
    data['region_code'] = regionCode;
    data['region_id'] = regionId;
    data['street'] = street;
    data['telephone'] = telephone;
    data['company'] = company;
    return data;
  }
}

class Total {
  num? baseShippingAmount;
  num? baseShippingDiscountAmount;
  num? baseShippingDiscountTaxCompensationAmnt;
  num? baseShippingInclTax;
  num? baseShippingInvoiced;
  num? baseShippingTaxAmount;
  num? shippingAmount;
  num? shippingDiscountAmount;
  num? shippingDiscountTaxCompensationAmount;
  num? shippingInclTax;
  num? shippingInvoiced;
  num? shippingTaxAmount;
  num? baseShippingRefunded;
  num? baseShippingTaxRefunded;
  num? shippingRefunded;
  num? shippingTaxRefunded;

  Total(
      {this.baseShippingAmount,
        this.baseShippingDiscountAmount,
        this.baseShippingDiscountTaxCompensationAmnt,
        this.baseShippingInclTax,
        this.baseShippingInvoiced,
        this.baseShippingTaxAmount,
        this.shippingAmount,
        this.shippingDiscountAmount,
        this.shippingDiscountTaxCompensationAmount,
        this.shippingInclTax,
        this.shippingInvoiced,
        this.shippingTaxAmount,
        this.baseShippingRefunded,
        this.baseShippingTaxRefunded,
        this.shippingRefunded,
        this.shippingTaxRefunded});

  Total.fromJson(Map<String, dynamic> json) {
    baseShippingAmount = json['base_shipping_amount'];
    baseShippingDiscountAmount = json['base_shipping_discount_amount'];
    baseShippingDiscountTaxCompensationAmnt =
    json['base_shipping_discount_tax_compensation_amnt'];
    baseShippingInclTax = json['base_shipping_incl_tax'];
    baseShippingInvoiced = json['base_shipping_invoiced'];
    baseShippingTaxAmount = json['base_shipping_tax_amount'];
    shippingAmount = json['shipping_amount'];
    shippingDiscountAmount = json['shipping_discount_amount'];
    shippingDiscountTaxCompensationAmount =
    json['shipping_discount_tax_compensation_amount'];
    shippingInclTax = json['shipping_incl_tax'];
    shippingInvoiced = json['shipping_invoiced'];
    shippingTaxAmount = json['shipping_tax_amount'];
    baseShippingRefunded = json['base_shipping_refunded'];
    baseShippingTaxRefunded = json['base_shipping_tax_refunded'];
    shippingRefunded = json['shipping_refunded'];
    shippingTaxRefunded = json['shipping_tax_refunded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base_shipping_amount'] = baseShippingAmount;
    data['base_shipping_discount_amount'] = baseShippingDiscountAmount;
    data['base_shipping_discount_tax_compensation_amnt'] =
        baseShippingDiscountTaxCompensationAmnt;
    data['base_shipping_incl_tax'] = baseShippingInclTax;
    data['base_shipping_invoiced'] = baseShippingInvoiced;
    data['base_shipping_tax_amount'] = baseShippingTaxAmount;
    data['shipping_amount'] = shippingAmount;
    data['shipping_discount_amount'] = shippingDiscountAmount;
    data['shipping_discount_tax_compensation_amount'] =
        shippingDiscountTaxCompensationAmount;
    data['shipping_incl_tax'] = shippingInclTax;
    data['shipping_invoiced'] = shippingInvoiced;
    data['shipping_tax_amount'] = shippingTaxAmount;
    data['base_shipping_refunded'] = baseShippingRefunded;
    data['base_shipping_tax_refunded'] = baseShippingTaxRefunded;
    data['shipping_refunded'] = shippingRefunded;
    data['shipping_tax_refunded'] = shippingTaxRefunded;
    return data;
  }
}

class PaymentAdditionalInfo {
  String? key;
  String? value;

  PaymentAdditionalInfo({this.key, this.value});

  PaymentAdditionalInfo.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class AppliedTaxes {
  String? code;
  String? title;
  num? percent;
  num? amount;
  num? baseAmount;

  AppliedTaxes(
      {this.code, this.title, this.percent, this.amount, this.baseAmount});

  AppliedTaxes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
    percent = json['percent'];
    amount = json['amount'];
    baseAmount = json['base_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['title'] = title;
    data['percent'] = percent;
    data['amount'] = amount;
    data['base_amount'] = baseAmount;
    return data;
  }
}

class ItemAppliedTaxes {
  String? type;
  List<AppliedTaxes>? appliedTaxes;
  num? itemId;

  ItemAppliedTaxes({this.type, this.appliedTaxes, this.itemId});

  ItemAppliedTaxes.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['applied_taxes'] != null) {
      appliedTaxes =  <AppliedTaxes>[];
      json['applied_taxes'].forEach((v) {
        appliedTaxes!.add(AppliedTaxes.fromJson(v));
      });
    }
    itemId = json['item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (appliedTaxes != null) {
      data['applied_taxes'] = appliedTaxes!.map((v) => v.toJson()).toList();
    }
    data['item_id'] = itemId;
    return data;
  }
}


