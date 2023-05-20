import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/cart_information_model.dart';
import 'package:magento_app/domain/models/customer_model.dart';
import 'package:magento_app/presentation/journey/checkout/checkout_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      appBar: AppBarWidget(
        showBackButton: true,
        title: TransactionConstants.checkoutTitle.tr,
        onPressed: () => Get.back(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: SingleChildScrollView(
          child: Obx(
            () {
              final String currencySymbol = currencySymbols[(controller
                          .paymentController
                          .shippingInfor
                          ?.totals
                          ?.baseCurrencyCode) ??
                      'USD'] ??
                  '';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(TransactionConstants.shippingMethod.tr),
                  SizedBox(
                    height: 8.sp,
                  ),
                  _buildAddressItem(
                      addresses: controller.shippingController.address!),
                  SizedBox(
                    height: 16.sp,
                  ),
                  _buildTitle(TransactionConstants.orderDetails.tr),
                  SizedBox(
                    height: 16.sp,
                  ),
                  ...List.generate(
                      controller.cartController.items.length,
                      (index) => _buildCartItem(
                          productEntity:
                              controller.cartController.items[index])),
                  _buildInvoiceItem(
                    title: TransactionConstants.subTotal.tr,
                    value:
                        '$currencySymbol${controller.paymentController.shippingInfor?.totals?.subtotal ?? 0}',
                  ),
                  _buildInvoiceItem(
                    title: TransactionConstants.shipping.tr,
                    value:
                        '$currencySymbol${controller.paymentController.shippingInfor?.totals?.shippingInclTax ?? 0}',
                  ),
                  _buildInvoiceItem(
                    title: TransactionConstants.tax.tr,
                    value:
                        '$currencySymbol${controller.paymentController.shippingInfor?.totals?.taxAmount ?? 0}',
                  ),
                  _buildInvoiceItem(
                    title: TransactionConstants.discount.tr,
                    value:
                        '$currencySymbol${controller.paymentController.shippingInfor?.totals?.discountAmount ?? 0}',
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        TransactionConstants.total.tr,
                        style: ThemeText.bodySemibold.s18,
                      )),
                      Text(
                        '$currencySymbol${(controller.paymentController.shippingInfor?.totals?.grandTotal ?? 0) + (controller.paymentController.shippingInfor?.totals?.taxAmount ?? 0)}',
                        style: ThemeText.bodySemibold.s18,
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: EdgeInsets.only(
            bottom: 16.sp,
            left: 16.sp,
            right: 16.sp,
          ),
          child: AppButton(
            title: TransactionConstants.checkoutTitle.tr,
            loaded: controller.rxLoadedButton.value,
            onPressed: () async => await controller.saveInfo(),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: ThemeText.bodySemibold.s16,
    );
  }

  Widget _buildInvoiceItem({required String title, required String value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.sp),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: ThemeText.bodyRegular,
          )),
          Text(
            value,
            style: ThemeText.bodyRegular,
          )
        ],
      ),
    );
  }

  Widget _buildAddressItem({required Addresses addresses}) {
    return Container(
      width: double.infinity,
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
                Text(
                  '${addresses.firstname ?? ''} ${addresses.lastname ?? ''}',
                  style: ThemeText.bodySemibold,
                ),
                SizedBox(
                  height: 2.sp,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem({
    required CartItem productEntity,
  }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 16.sp,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey200),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 72.sp,
              width: 72.sp,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: AppImageWidget(
                url:
                    '${NetworkConfig.baseProductMediaUrl}${productEntity.productOption?.extensionAttributes?.customOptions?.first.optionValue ?? ''}',
                height: 72.sp,
                width: 72.sp,
              ),
            ),
            SizedBox(
              width: 12.sp,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productEntity.name ?? '',
                    style: ThemeText.bodySemibold,
                  ),
                  SizedBox(
                    height: 2.sp,
                  ),
                  Text(
                    '${currencySymbols[controller.mainController.storeConfig.value.baseCurrencyCode ?? 'USD']}${(productEntity.price ?? 0) * (productEntity.qty ?? 1)}',
                    style: ThemeText.bodyRegular.s12,
                  ),
                  Text(
                    '${TransactionConstants.quantity.tr}: ${productEntity.qty ?? 1}',
                    style: ThemeText.bodyRegular.s12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
