import 'package:magento_app/common/config/app_config.dart';

class ApiEndpoints {
  // static endpoints
  static String cmsHome = '/rest/default/V1/cmsBlock/${AppConfig.cmsHomeBlock}';
  static String getCategoriesList = '/rest/default/V1/categories/list';
  static String getProducts = '/rest/default/V1/products';
  static String getCategoriesTree = '/rest/default/V1/categories';
  static String login = '/rest/default/V1/integration/customer/token';
  static String getCustomerInfor = '/rest/V1/customers/me';
  static String getStoreConfig = '/rest/default/V1/store/storeConfigs';
  static String customer = '/rest/V1/customers';
  static String changePassword = '/rest/V1/customers/me/password';
  static String cart = '/rest/default/V1/carts/mine';
  static String cartItem = '/rest/V1/carts/mine/items';
  static String orders = '/rest/default/V1/orders';
  static String getAllMessage = '/rest/V1/chat-support/mine/myChat';
  static String sendMessage = '/rest/V1/chat-support/mine/sendChatMessage';
  static String coupons({required String code}) =>
      '/rest/default/V1/carts/mine/coupons/$code';
  static String producReview({required String sku}) =>
      '/rest/V1/products/$sku/reviews';
  static String addReview = '/rest/V1/reviews';
}
