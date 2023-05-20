import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/journey/change_password/change_password_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      appBar: AppBarWidget(
        showBackButton: true,
        title: TransactionConstants.changePassword.tr,
        onPressed: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(TransactionConstants.currentPassword.tr),
              SizedBox(
                height: 12.h,
              ),
              Obx(() => AppTextField(
                    controller: controller.oldPwdController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    onChangedText: (value) {
                      controller.checkButtonEnable();
                      controller.oldPwdValidate.value = '';
                    },
                    errorText: controller.oldPwdValidate.value,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context)
                        .requestFocus(controller.newPwdFocusNode),
                    focusNode: controller.oldPwdFocusNode,
                  )),
              SizedBox(
                height: 24.h,
              ),
              _buildTitle(TransactionConstants.newPassword.tr),
              SizedBox(
                height: 12.h,
              ),
              Obx(() => AppTextField(
                    controller: controller.newPwdController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    onChangedText: (value) {
                      controller.checkButtonEnable();
                      controller.newPwdValidate.value = '';
                    },
                    errorText: controller.newPwdValidate.value,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context)
                        .requestFocus(controller.confirmPwdFocusNode),
                    focusNode: controller.newPwdFocusNode,
                  )),
              SizedBox(
                height: 24.h,
              ),
              _buildTitle('Confirm password'),
              SizedBox(
                height: 12.h,
              ),
              Obx(() => AppTextField(
                    errorText: controller.confirmPwdValidate.value,
                    controller: controller.confirmPwdController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    onChangedText: (value) {
                      controller.checkButtonEnable();
                      controller.confirmPwdValidate.value = '';
                    },
                    textInputAction: TextInputAction.done,
                    onEditingComplete: controller.saveInfo,
                    focusNode: controller.confirmPwdFocusNode,
                  )),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.all(16.sp),
      //   child:  Obx(() => AppButton(
      //     title: TransactionConstants.save.tr,
      //     onPressed: () async => await controller.saveInfo(),
      //     loaded: controller.rxLoadedButton.value,
      //   )),
      // ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Obx(() => AppButton(
              title: TransactionConstants.save.tr,
              onPressed: () async => await controller.saveInfo(),
              loaded: controller.rxLoadedButton.value,
            )),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: ThemeText.bodySemibold,
    );
  }
}
