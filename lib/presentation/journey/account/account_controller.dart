import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/constants/constants_export.dart';
import 'package:magento_app/common/utils/export.dart';
import 'package:magento_app/domain/usecases/account_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/widgets/app_dialog.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class AccountController extends GetxController with MixinController {
  final AccountUseCase accountUseCase;

  AccountController({required this.accountUseCase});
  final MainController _mainController = Get.find<MainController>();

  onPressLogout() async {
    await showAppDialog(context,
        TransactionConstants.logOut.tr,
        firstButtonText: TransactionConstants.ok.tr,
        messageTextAlign: TextAlign.start,
        dismissAble: true,
        firstButtonCallback: () async {
          try {
            await accountUseCase
                .logout()
                .then((value) => Get.offAllNamed(AppRoutes.login));
          } catch (e) {
            showTopSnackBarError(context, TransactionConstants.unknownError.tr);
          }

          // Get.offAllNamed(AppRoute.login);
        },
        secondButtonText: TransactionConstants.cancel.tr,
        secondButtonCallback: () => Get.back());
  }


  goToChangePassword() {
    //Get.toNamed(AppRoutes.changePassword);
  }
}
