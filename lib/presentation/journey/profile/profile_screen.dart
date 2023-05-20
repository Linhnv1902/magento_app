import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/profile/profile_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
        appBar: AppBarWidget(
          showBackButton: true,
          title: TransactionConstants.accountInformation.tr,
          onPressed: () => Get.back(),
        ),
        body: Column(children: [
          // Container(
          //   color: AppColors.greyF0FF,
          //   height: 1.h,
          // ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(
                        title: TransactionConstants.firstName.tr,
                        isRequired: true),

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
                    _buildTitle(
                        title: TransactionConstants.lastName.tr,
                        isRequired: true),

                    Obx(() => AppTextField(
                          errorText: controller.lastNameValidate.value,
                          controller: controller.lastNameController,
                          keyboardType: TextInputType.name,
                          onChangedText: (value) {
                            controller.checkButtonEnable();
                            controller.lastNameValidate.value = '';
                          },
                          //   textInputAction: TextInputAction.next,
                          focusNode: controller.lastNameFocusNode,
                        )),

                    SizedBox(
                      height: 24.h,
                    ),
                    _buildTitle(title: TransactionConstants.gender.tr),
                    Obx(
                      () => Wrap(
                        runSpacing: 8.sp,
                        spacing: 8.sp,
                        children: Gender.values
                            .map((e) => _buildItemGender(gender: e))
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    _buildTitle(title: TransactionConstants.dob.tr),
                    Obx(
                      () => AppTextField(
                        hintText: 'yyyy-mm-dd',
                        controller: controller.dobController,
                        errorText: controller.dobValidate.value,
                        onChangedText: (value) {
                          controller.checkButtonEnable();
                          controller.dobValidate.value = '';
                        },
                        textInputAction: TextInputAction.done,
                        onEditingComplete: controller.onEditingCompleteDob,
                        focusNode: controller.dobFocusNode,
                      ),
                    ),
                    // AppButton(
                    //   margin: EdgeInsets.all(0),
                    //   title: TransactionConstants.,
                    //   onPressed: () {
                    //     if (controller.buttonEnable.value) {
                    //       controller.saveInfo();
                    //     }
                    //   },
                    //   buttonState: controller.buttonState.value,
                    // ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Obx(() => AppButton(
                          //   margin: EdgeInsets.all(0),
                          title: TransactionConstants.save.tr,
                          onPressed: controller.onPressedSave,
                          loaded: controller.rxLoadedButton.value,
                        )),
                    SizedBox(
                      height: AppDimens.height_50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }

  // Widget _itemInfoSkeletonWidget() {
  //   return ContainerSkeletonWidget(
  //     height: 48.h,
  //     width: double.infinity,
  //     borderRadius: AppDimens.radius_5,
  //   );
  // }

  Widget _buildItemGender({required Gender gender}) {
    return GestureDetector(
      onTap: () => controller.updateSelectedGender(gender),
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(right: 24),
        child: Row(
          children: [
            AppImageWidget(
              asset: controller.selectedGender.value == gender
                  ? Assets.images.icCircleChecked
                  : Assets.images.icCircleUnchecked,
              size: 20.sp,
            ),
            SizedBox(width: 8.sp),
            Text(
              gender.name.capitalize ?? '',
              style: ThemeText.bodyRegular,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle({required String title, bool isRequired = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.sp),
      child: Text(
        isRequired ? '$title *' : title,
        style: ThemeText.bodySemibold,
      ),
    );
  }

}
