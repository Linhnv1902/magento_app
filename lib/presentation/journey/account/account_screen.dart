import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/account/account_controller.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    final mainController = Get.find<MainController>();
    return Scaffold(
      backgroundColor: AppColors.grey50,
      // appBar: AppBarWidget(
      //   title: TransactionConstants.accountTitle.tr,
      // ),
      body: Column(
        children: [
          SizedBox(
            height: Get.mediaQuery.padding.top,
          ),
          Container(
            height: 60.sp,
            color: AppColors.grey200,
            width: Get.width,
            child: ListTile(
              tileColor: AppColors.grey200,
              // leading: AppImageWidget(
              //   asset: Assets.images.icUser,
              // ),
              title: Obx(() => Text(
                    'Hi, ${mainController.rxCustomer.value?.firstname ?? ''} ${mainController.rxCustomer.value?.lastname ?? ''}',
                    style: ThemeText.bodySemibold.s16,
                  )),
            ),
          ),
          _buildListTile(
              onTap: () {
                Get.toNamed(AppRoutes.profile);
              },
              icon: Assets.images.icUser,
              title: TransactionConstants.accountInformation.tr),
          _buildListTile(
              onTap: () {
                Get.toNamed(AppRoutes.myOrders);
              },
              icon: Assets.images.icOrder,
              title: TransactionConstants.myOrders.tr),
          _buildListTile(
              onTap: () {
                Get.toNamed(AppRoutes.address);
              },
              icon: Assets.images.icLocation,
              title: TransactionConstants.myAddress.tr),
          _buildListTile(
              onTap: () {
                Get.toNamed(AppRoutes.changePassword);
              },
              icon: Assets.images.icPassword,
              title: TransactionConstants.changePassword.tr),
          _buildListTile(
              onTap: controller.onPressLogout,
              icon: Assets.images.icLogout,
              title: TransactionConstants.logOut.tr),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required SvgGenImage icon,
    required String title,
    required onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(16.sp),
            child: AppImageWidget(
              asset: icon,
              color: AppColors.primary,
              size: 20.sp,
            ),
          ),
          Text(
            title,
            style: ThemeText.bodyRegular,
          ),
        ],
      ),
    );
  }
}
