import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/utils/app_validator.dart';
import 'package:magento_app/domain/usecases/account_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class ChangePasswordController extends GetxController with MixinController {
  Rx<LoadedType> rxLoadedButton = LoadedType.finish.obs;
  AccountUseCase accountUsecase;

  final oldPwdController = TextEditingController();
  final newPwdController = TextEditingController();
  final confirmPwdController = TextEditingController();

  final oldPwdFocusNode = FocusNode();
  final newPwdFocusNode = FocusNode();
  final confirmPwdFocusNode = FocusNode();
  RxString errorText = ''.obs;
  RxString oldPwdValidate = ''.obs;
  RxString newPwdValidate = ''.obs;
  RxString confirmPwdValidate = ''.obs;

  MainController mainController = Get.find<MainController>();
  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;

  RxBool buttonEnable = false.obs;
  String token = '';

  // RxBool hideOldPwd = true.obs;
  // RxBool hideNewPwd = true.obs;

  ChangePasswordController({required this.accountUsecase});

  void checkButtonEnable() {
    if (oldPwdController.text.isNotEmpty &&
        newPwdController.text.isNotEmpty &&
        confirmPwdController.text.isNotEmpty) {
      buttonEnable.value = true;
    } else {
      buttonEnable.value = false;
    }
  }

  // Future<void> getToken() async {
  //   token = await authUseCase.getToken();
  // }

  // void onChangeHideOldPwd() {
  //   hideOldPwd.value = !hideOldPwd.value;
  // }
  //
  // void onChangeHideNewPwd() {
  //   hideNewPwd.value = !hideNewPwd.value;
  // }

  Future<void> saveInfo() async {
    rxLoadedButton.value = LoadedType.start;
    hideKeyboard();
    errorText.value = '';
    String? oldPwd =
        await accountUsecase.getSecureData(StringConstants.keyPassword);
    if (oldPwd != oldPwdController.text) {
      oldPwdValidate.value = 'Your current password is incorrect';
    } else {
      oldPwdValidate.value = '';
    }
    newPwdValidate.value = AppValidator.validatePassword(newPwdController);
    if (confirmPwdController.text != newPwdController.text) {
      confirmPwdValidate.value = 'Your confirm password is incorrect';
    } else {
      confirmPwdValidate.value = '';
    }

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      rxLoadedButton.value = LoadedType.finish;
      return;
    }

    if (oldPwdValidate.value.isEmpty &&
        newPwdValidate.value.isEmpty &&
        confirmPwdValidate.value.isNotEmpty) {
      final result = await accountUsecase.changePassword(
          currentPassword: oldPwdController.text.trim(),
          newPassword: newPwdController.text.trim());

      if (result) {
        debugPrint('cập nhật thành công');
        await accountUsecase.savePass(newPwdController.text.trim());
        showTopSnackBar(context,
            message: TransactionConstants.successfully.tr,
            type: SnackBarType.done);
        Get.back();
      }
    }
    rxLoadedButton.value = LoadedType.finish;
  }
}
