import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/injector/bindings/account_binding.dart';
import 'package:magento_app/common/injector/bindings/addresses_list_binding.dart';
import 'package:magento_app/common/injector/bindings/cart_binding.dart';
import 'package:magento_app/common/injector/bindings/category_binding.dart';
import 'package:magento_app/common/injector/bindings/change_password_binding.dart';
import 'package:magento_app/common/injector/bindings/checkout_binding.dart';
import 'package:magento_app/common/injector/bindings/create_address_binding.dart';
import 'package:magento_app/common/injector/bindings/estimate_shipping_binding.dart';
import 'package:magento_app/common/injector/bindings/home_binding.dart';
import 'package:magento_app/common/injector/bindings/login_binding.dart';
import 'package:magento_app/common/injector/bindings/message_binding.dart';
import 'package:magento_app/common/injector/bindings/my_orders_binding.dart';
import 'package:magento_app/common/injector/bindings/order_detail_binding.dart';
import 'package:magento_app/common/injector/bindings/payment_binding.dart';
import 'package:magento_app/common/injector/bindings/paypal_binding.dart';
import 'package:magento_app/common/injector/bindings/product_binding.dart';
import 'package:magento_app/common/injector/bindings/product_detail_binding.dart';
import 'package:magento_app/common/injector/bindings/profile_binding.dart';
import 'package:magento_app/common/injector/bindings/register_binding.dart';
import 'package:magento_app/presentation/journey/addresses_list/address_screen.dart';
import 'package:magento_app/presentation/journey/cart/cart_screen.dart';
import 'package:magento_app/presentation/journey/change_password/change_password_screen.dart';
import 'package:magento_app/presentation/journey/checkout/checkout_screen.dart';
import 'package:magento_app/presentation/journey/create_address/create_address_screen.dart';
import 'package:magento_app/presentation/journey/estimate_shipping/estimate_shipping_screen.dart';
import 'package:magento_app/presentation/journey/login/login_screen.dart';
import 'package:magento_app/presentation/journey/message/message_screen.dart';
import 'package:magento_app/presentation/journey/my_order_detail/my_order_detail_screen.dart';
import 'package:magento_app/presentation/journey/my_orders/my_orders_screen.dart';
import 'package:magento_app/presentation/journey/payment/payment_screen.dart';
import 'package:magento_app/presentation/journey/paypal_payment/paypal_screen.dart';
import 'package:magento_app/presentation/journey/product/product_screen.dart';
import 'package:magento_app/presentation/journey/product_detail/product_detail_screen.dart';
import 'package:magento_app/presentation/journey/profile/profile_screen.dart';
import 'package:magento_app/presentation/journey/register/register_screen.dart';
import 'journey/main/main_screen.dart';
import 'journey/splash/splash_screen.dart';

List<GetPage> myPages = [
  GetPage(
    name: AppRoutes.splash,
    page: () => const SplashScreen(),
    binding: SplashBinding(),
  ),
  GetPage(name: AppRoutes.main, page: () => MainScreen(), bindings: [
    MainBinding(),
    HomeBinding(),
    CategoryBinding(),
    CartBinding(),
    MessageBinding(),
    AccountBinding(),
  ]),
  GetPage(
    name: AppRoutes.login,
    page: () => const LogInScreen(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: AppRoutes.register,
    page: () => const RegisterScreen(),
    binding: RegisterBinding(),
  ),
  GetPage(
    name: AppRoutes.product,
    page: () => const ProductScreen(),
    binding: ProductBinding(),
  ),
  GetPage(
    name: AppRoutes.profile,
    page: () => const ProfileScreen(),
    binding: ProfileBinding(),
  ),
  GetPage(
    name: AppRoutes.address,
    page: () => const AddressScreen(),
    binding: AddressBinding(),
  ),
  GetPage(
    name: AppRoutes.createAddress,
    page: () => const CreateNewAddressScreen(),
    binding: CreateAddressBinding(),
  ),
  GetPage(
    name: AppRoutes.changePassword,
    page: () => const ChangePasswordScreen(),
    binding: ChangePasswordBinding(),
  ),
  GetPage(
    name: AppRoutes.productDetail,
    page: () => const ProductDetailScreen(),
    binding: ProductDetailBinding(),
  ),
  GetPage(
    name: AppRoutes.cart,
    page: () => const CartScreen(),
    binding: CartBinding(),
  ),
  GetPage(
    name: AppRoutes.myOrders,
    page: () => const MyOrdersScreen(),
    binding: MyOrdersBinding(),
  ),
  GetPage(
    name: AppRoutes.estimateShipping,
    page: () => const EstimateShippingScreen(),
    binding: EstimateShippingBinding(),
  ),
  GetPage(
    name: AppRoutes.payment,
    page: () => const PaymentScreen(),
    binding: PaymentBinding(),
  ),
  GetPage(
    name: AppRoutes.checkout,
    page: () => const CheckoutScreen(),
    binding: CheckoutBinding(),
  ),
  GetPage(
    name: AppRoutes.myOrderDetail,
    page: () => const OrderDetailScreen(),
    binding: OrderDetailBinding(),
  ),
  GetPage(
    name: AppRoutes.message,
    page: () => MessageScreen(),
    binding: MessageBinding(),
  ),
  GetPage(
    name: AppRoutes.paypal,
    page: () => PaypalScreen(),
    binding: PaypalBinding(),
  ),
];
