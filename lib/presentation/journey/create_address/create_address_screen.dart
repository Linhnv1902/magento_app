import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/create_address/create_address_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class CreateNewAddressScreen extends GetView<CreateNewAddressController> {
  const CreateNewAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      appBar: AppBarWidget(
        showBackButton: true,
        title: TransactionConstants.addAccountAddress.tr,
        onPressed: () => Get.back(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(title: TransactionConstants.firstName.tr),
                    Obx(() => AppTextField(
                          controller: controller.firstNameController,
                          keyboardType: TextInputType.name,
                          onChangedText: (value) {
                            controller.checkButtonEnable();
                            controller.firstNameValidate.value = '';
                          },
                          errorText: controller.firstNameValidate.value,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(controller.lastNameFocusNode),
                          focusNode: controller.firstNameFocusNode,
                        )),
                    SizedBox(
                      height: 24.h,
                    ),
                    _buildTitle(title: TransactionConstants.lastName.tr),
                    Obx(
                      () => AppTextField(
                        controller: controller.lastNameController,
                        keyboardType: TextInputType.name,
                        onChangedText: (value) {
                          controller.checkButtonEnable();
                          controller.lastNameValidate.value = '';
                        },
                        errorText: controller.lastNameValidate.value,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(controller.phoneFocusNode),
                        focusNode: controller.lastNameFocusNode,
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    _buildTitle(title: TransactionConstants.telephone.tr),
                    Obx(() => AppTextField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          onChangedText: (value) {
                            controller.checkButtonEnable();
                            controller.phoneValidate.value = '';
                          },
                          errorText: controller.phoneValidate.value,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(controller.streetFocusNode),
                          focusNode: controller.phoneFocusNode,
                        )),
                    SizedBox(
                      height: 24.h,
                    ),
                    _buildTitle(title: TransactionConstants.street.tr),
                    Obx(() => AppTextField(
                          controller: controller.streetController,
                          keyboardType: TextInputType.name,
                          onChangedText: (value) {
                            controller.checkButtonEnable();
                            controller.streetValidate.value = '';
                          },
                          errorText: controller.streetValidate.value,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(controller.cityFocusNode),
                          focusNode: controller.streetFocusNode,
                        )),
                    SizedBox(
                      height: 24.h,
                    ),
                    _buildTitle(title: TransactionConstants.city.tr),
                    Obx(() => AppTextField(
                          controller: controller.cityController,
                          keyboardType: TextInputType.name,
                          onChangedText: (value) {
                            controller.checkButtonEnable();
                            controller.cityValidate.value = '';
                          },
                          errorText: controller.cityValidate.value,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: controller.onEditingCompleteCity,
                          focusNode: controller.cityFocusNode,
                        )),
                    SizedBox(
                      height: 24.h,
                    ),
                    Obx(() => _buildItemDefaultAddress(
                        title: TransactionConstants
                            .addressDefaultBillingAddress.tr,
                        isSelected: controller.defaultBillingAddress.value,
                        onSelect: controller.onChangeSetDefaultBillingAddress)),
                    SizedBox(
                      height: 24.h,
                    ),
                    Obx(() => _buildItemDefaultAddress(
                        title: TransactionConstants
                            .addressDefaultShippingAddress.tr,
                        isSelected: controller.defaultShippingAddress.value,
                        onSelect:
                            controller.onChangeSetDefaultShippingAddress)),
                    SizedBox(
                      height: 24.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Obx(() => AppButton(
              title: TransactionConstants.save.tr,
              onPressed: controller.onPressedSave,
              loaded: controller.rxLoadedButton.value,
            )),
      ),
    );
  }

  Widget _buildTitle({required String title}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.sp),
      child: Text(
        title,
        style: ThemeText.bodySemibold,
      ),
    );
  }

  Widget _buildItemDefaultAddress(
      {required String title,
      bool isSelected = false,
      required Function()? onSelect}) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(right: 24),
        child: Row(
          children: [
            AppImageWidget(
              asset: isSelected
                  ? Assets.images.icCircleChecked
                  : Assets.images.icCircleUnchecked,
              size: 20.sp,
            ),
            SizedBox(width: 8.sp),
            Text(
              title,
              style: ThemeText.bodyRegular,
            )
          ],
        ),
      ),
    );
  }
}
