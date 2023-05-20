import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/customer_model.dart';

class LocalRepository {
  Future<void> saveToken(String token) async {
    await SharePreferencesConstants.prefs
        .setString(SharePreferencesConstants.keyToken, token);
  }

  String? getToken() {
    return SharePreferencesConstants.prefs
        .getString(SharePreferencesConstants.keyToken);
  }

  Future<void> saveCustomerInformation(CustomerModel customerModel) async {
    String customer = jsonEncode(customerModel.toJson());
    await SharePreferencesConstants.prefs
        .setString(SharePreferencesConstants.keyCustomer, customer);
  }

  CustomerModel? getCustomerInformation() {
    var customer = SharePreferencesConstants.prefs
        .getString(SharePreferencesConstants.keyCustomer);
    return customer != null
        ? CustomerModel.fromJson(jsonDecode(customer))
        : null;
  }

  Future<void> saveEmail(String email) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(key: StringConstants.keyEmail, value: email);
  }

  Future<void> savePass(String password) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(key: StringConstants.keyPassword, value: password);
  }

  Future<String?> getSecureData(String key) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return storage.read(key: key);
  }

  Future<void> logout() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.deleteAll();
    await SharePreferencesConstants.prefs.clear();
  }
}
