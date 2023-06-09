import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/utils/app_validator.dart';
import 'package:magento_app/domain/usecases/account_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class LoginController extends GetxController with MixinController {
  Rx<LoadedType> rxLoadedButton = LoadedType.finish.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  RxString errorText = ''.obs;

  RxString emailValidate = ''.obs;
  RxString passwordValidate = ''.obs;

  RxBool buttonEnable = false.obs;
  RxBool emailHasFocus = false.obs;
  RxBool pwdHasFocus = false.obs;

  AccountUseCase accountUsecase;

  // final mainController = Get.find<MainController>();

  LoginController({required this.accountUsecase});

  void checkButtonEnable() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      buttonEnable.value = true;
    } else {
      buttonEnable.value = false;
    }
  }

  void postLogin() async {
    rxLoadedButton.value = LoadedType.start;
    hideKeyboard();
    errorText.value = '';
    // emailValidate.value = AppValidator.validateEmail(emailController);
    // passwordValidate.value = AppValidator.validatePassword(passwordController);

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      rxLoadedButton.value = LoadedType.finish;
      return;
    }

    if (emailValidate.value.isEmpty && passwordValidate.value.isEmpty) {
      final result = await accountUsecase.login(
          username: emailController.text.trim(),
          password: passwordController.text.trim());

      try {
        if (result != null) {
          debugPrint('đăng nhập thành công');
          await accountUsecase.saveToken(result);
          //   mainController.token.value = result;
          await accountUsecase.saveEmail(emailController.text.trim());
          await accountUsecase.savePass(passwordController.text.trim());
          final customerInfo = await accountUsecase.getCustomerInformation();

          if (customerInfo != null) {
            await accountUsecase.saveCustomerInformation(customerInfo);
            //  mainController.rxCustomer.value = customerInfo;
            // mainController.updateLogin();
            //go to main screen
            Get.offNamed(AppRoutes.main);
          } else {
            showTopSnackBarError(context, TransactionConstants.unknownError.tr);
          }
        } else {
          debugPrint('đăng nhập thất bại');
          errorText.value = TransactionConstants.loginError.tr;
        }
      } catch (e) {
        debugPrint(e.toString());
        showTopSnackBarError(context, TransactionConstants.unknownError.tr);
      }
    }

    rxLoadedButton.value = LoadedType.finish;
  }

  void onChangedEmail() {
    checkButtonEnable();
    emailValidate.value = '';
  }

  void onTapEmailTextField() {
    pwdHasFocus.value = false;
    emailHasFocus.value = true;
  }

  void onEditingCompleteEmail() {
    emailHasFocus.value = false;
    pwdHasFocus.value = true;
    FocusScope.of(context).requestFocus(passwordFocusNode);
  }

  void onChangedPwd() {
    checkButtonEnable();
    passwordValidate.value = '';
  }

  void onTapPwdTextField() {
    emailHasFocus.value = false;
    pwdHasFocus.value = true;
  }

  void onEditingCompletePwd() {
    pwdHasFocus.value = false;
    FocusScope.of(context).unfocus();
    if (buttonEnable.value) {
      postLogin();
    }
  }

  void onPressedLogIn() {
    pwdHasFocus.value = false;
    emailHasFocus.value = false;
    if (buttonEnable.value) {
      postLogin();
    }
  }

  onPressForgotPassword() {
    //  Get.toNamed(AppRoutes.forgotPassword);
  }

  onPressRegister() {
    Get.toNamed(AppRoutes.register);
  }

  @override
  void onReady() async {
    super.onReady();
    emailFocusNode.addListener(() {
      emailHasFocus.value = emailFocusNode.hasFocus;
    });
    passwordFocusNode.addListener(() {
      pwdHasFocus.value = passwordFocusNode.hasFocus;
    });
  }
}
