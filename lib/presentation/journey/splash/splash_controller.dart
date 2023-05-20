import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/usecases/account_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';

class SplashController extends GetxController with MixinController {
  SplashController({required this.accountUseCase});
  final AccountUseCase accountUseCase;

  Rx<LoadedType> rxLoader = LoadedType.start.obs;
  @override
  void onInit() {
    super.onInit();
    setStatusBarStyle(statusBarStyleType: StatusBarStyleType.light);
    loginWithUsername();
  }

  Future<void> loginWithUsername() async {
    rxLoadedType.value = LoadedType.start;
    String? username =
        await accountUseCase.getSecureData(StringConstants.keyEmail);
    String? password =
        await accountUseCase.getSecureData(StringConstants.keyPassword);

    if (isNullEmpty(username) || isNullEmpty(password)) {
      Get.offNamed(AppRoutes.login);
    } else {
      final result =
          await accountUseCase.login(username: username!, password: password!);

      try {
        if (result != null) {
          debugPrint('đăng nhập thành công');
          await accountUseCase.saveToken(result);
          //    mainController.token.value = result;
          final customerInfo = await accountUseCase.getCustomerInformation();

          if (customerInfo != null) {
            await accountUseCase.saveCustomerInformation(customerInfo);
            // mainController.rxCustomer.value = customerInfo;
            Get.offNamed(AppRoutes.main);
          } else {
            Get.offNamed(AppRoutes.login);
          }
        } else {
          Get.offNamed(AppRoutes.login);
        }
        // mainController.updateLogin();
      } catch (e) {
        debugPrint(e.toString());
        Get.offNamed(AppRoutes.login);
      }
    }
    rxLoadedType.value = LoadedType.finish;
  }

  @override
  void onReady() {
    super.onReady();
  }
}
