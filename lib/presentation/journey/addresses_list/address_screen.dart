import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/customer_model.dart';
import 'package:magento_app/presentation/journey/addresses_list/address_controller.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class AddressScreen extends GetView<AddressController> {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    final mainController = Get.find<MainController>();
    return Scaffold(
      appBar: AppBarWidget(
        showBackButton: true,
        title: TransactionConstants.myAddress.tr,
        onPressed: () => Get.back(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: SingleChildScrollView(child: Obx(() {
          final addresses = mainController.rxCustomer.value?.addresses ?? [];

          return addresses.isEmpty
              ? Center(
                  child: Padding(
                  padding: EdgeInsets.only(top: 24.sp),
                  child: Text(
                    TransactionConstants.noData.tr,
                    style: ThemeText.bodyMedium.grey500Color.s20,
                  ),
                ))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: addresses
                      .map((e) => _buildAddressItem(addresses: e))
                      .toList());
        })),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.sp),
        child: AppButton(
          title: TransactionConstants.addAccountAddress.tr,
          onPressed: () => Get.toNamed(AppRoutes.createAddress),
        ),
      ),
    );
  }

  Widget _buildAddressItem({required Addresses addresses}) {
    return GestureDetector(
      onTap: controller.isCheckout
          ? () {
              Get.toNamed(AppRoutes.estimateShipping, arguments: addresses);
            }
          : () {},
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(8.sp),
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (addresses.defaultBilling ?? false)
                  Text(
                    TransactionConstants.defaultBillingAddress.tr,
                    style: ThemeText.bodyRegular.s12
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                if (addresses.defaultShipping ?? false)
                  Text(
                    TransactionConstants.defaultShippingAddress.tr,
                    style: ThemeText.bodyRegular.s12
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                Text(
                  '${addresses.firstname ?? ''} ${addresses.lastname ?? ''}',
                  style: ThemeText.bodySemibold,
                ),
                Text(
                  addresses.telephone ?? '',
                  style: ThemeText.bodyRegular,
                ),
                Text(
                  addresses.street?.first ?? '',
                  style: ThemeText.bodyRegular,
                ),
                Text(
                  addresses.city ?? '',
                  style: ThemeText.bodyRegular,
                ),
              ],
            )),
            AppTouchable(
                onPressed: () {
                  Get.toNamed(AppRoutes.createAddress, arguments: {
                    'address': addresses,
                  });
                },
                child: Icon(
                  Icons.edit,
                  color: AppColors.grey,
                  size: 20.sp,
                ))
          ],
        ),
      ),
    );
  }
}
