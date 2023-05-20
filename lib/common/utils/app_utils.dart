import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magento_app/common/config/app_config.dart';
import 'package:permission_handler/permission_handler.dart';

void logger(String message) {
  log('app_logger: {$message}');
}

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

String formatCurrency(dynamic number) {
  if (isNullEmptyFalseOrZero(number) || !isNumeric(number)) {
    return '0';
  }
  dynamic numberConvert;
  if (number is String) {
    numberConvert = int.tryParse(number) ?? double.tryParse(number);
  } else {
    numberConvert = number;
  }
  return NumberFormat("#,###", AppConfig.defaultLocate)
      .format(numberConvert ?? 0);
}

String formatPhoneNumber(String phoneNumber) {
  var filterText = phoneNumber;
  if (isNullEmpty(filterText)) return '';
  filterText = filterText.replaceAll(' ', '');
  if (filterText.length < 2) return filterText;
  final firstChars = filterText.substring(0, 2);
  if (firstChars == '09' ||
      firstChars == '08' ||
      firstChars == '07' ||
      firstChars == '03' ||
      firstChars == '05') {
    if (filterText.length > 3) {
      filterText = '${filterText.substring(0, 3)} ${filterText.substring(3)}';
    }
    if (filterText.length > 7) {
      filterText = '${filterText.substring(0, 7)} ${filterText.substring(7)}';
    }
  }
  return filterText.trim();
}

bool isNullEmpty(Object? o) => o == null || "" == o || o == "null";

bool isNullEmptyOrFalse(Object? o) => o == null || false == o || "" == o;

bool isNullEmptyFalseOrZero(Object? o) =>
    o == null || false == o || 0 == o || "" == o || "0" == o;

bool isNullEmptyList<T>(List<T>? t) => t == null || [] == t || t.isEmpty;

bool isNullEmptyMap<T>(Map<T, T>? t) => t == null || {} == t || t.isEmpty;

bool isNumeric(dynamic s) {
  String sConvert = s.toString();
  if (isNullEmpty(sConvert)) {
    return false;
  }
  return (double.tryParse(sConvert) != null || int.tryParse(sConvert) != null);
}

Future<bool> checkPermission(Permission permission) async {
  final status = await permission.request();
  return status.isGranted;
}

const pageSize = 10;
const searchKeyPageSize = 'searchCriteria[page_size]';
const searchKeyCurrentPage = 'searchCriteria[current_page]';

const searchKeyFieldName =
    'searchCriteria[filter_groups][0][filters][0][field]';
const searchKeyFieldValue =
    'searchCriteria[filter_groups][0][filters][0][value]';
const searchKeyFields = 'fields';
const searchKeyConditionType =
    'searchCriteria[filter_groups][0][filters][0][condition_type]';

String getSortFieldName(String sortOrder) {
  switch (sortOrder) {
    case '0':
    case '1':
      return 'name';
    case '2':
    case '3':
      return 'price';
    default:
      return '';
  }
}

String getSortDirection(String sortOrder) {
  switch (sortOrder) {
    case '0':
    case '2':
      return 'ASC';
    case '1':
    case '3':
      return 'DESC';
    default:
      return '';
  }
}

const currencySymbols = {
  'USD': '\$',
  'EUR': '€',
  'AUD': 'A\$',
  'GBP': '£',
  'CAD': 'CA\$',
  'CNY': 'CN¥',
  'JPY': '¥',
  'SEK': 'SEK',
  'CHF': 'CHF',
  'INR': '₹',
  'KWD': 'د.ك',
  'RON': 'RON',
};
