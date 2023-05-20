import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesConstants {
  static late SharedPreferences prefs;

  static String keyToken = 'access_token';
  static String keyCustomer = 'customer';

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}