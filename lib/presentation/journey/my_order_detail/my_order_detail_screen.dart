import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/get_all_orders_response_model.dart';
import 'package:magento_app/presentation/journey/my_order_detail/my_order_detail_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class OrderDetailScreen extends GetView<OrderDetailController> {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      appBar: AppBarWidget(
        showBackButton: true,
        title: controller.orderDetail?.incrementId ?? '',
        onPressed: () => Get.back(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(TransactionConstants.general.tr),
              SizedBox(
                height: 16.sp,
              ),
              _buildGenralInformation(),
              SizedBox(
                height: 16.sp,
              ),
              _buildTitle(TransactionConstants.billingAddress.tr),
              SizedBox(
                height: 16.sp,
              ),
              _buildBillingAddressItem(),
              SizedBox(
                height: 16.sp,
              ),
              _buildTitle(TransactionConstants.paymentMethod.tr),
              SizedBox(
                height: 16.sp,
              ),
              _buildPayment(),
              SizedBox(
                height: 16.sp,
              ),
              _buildTitle(TransactionConstants.orderDetails.tr),
              SizedBox(
                height: 16.sp,
              ),
              ...List.generate(
                  controller.orderDetail?.extensionAttributesOrder
                          ?.shippingAssignments?.length ??
                      0,
                  (index) => _buildShippingItem(
                      shippingAssignments: (controller.orderDetail
                              ?.extensionAttributesOrder?.shippingAssignments ??
                          [])[index])),
            ],
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

  Widget _buildPayment() {
    final String currencySymbol =
        currencySymbols[(controller.orderDetail?.baseCurrencyCode) ?? 'USD'] ??
            '';
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
                _buildInvoiceItem(
                  title: TransactionConstants.paymentMethod.tr,
                  value: (controller.orderDetail?.payment?.additionalInformation
                                  ?.toString() ??
                              '')
                          .toUpperCase()
                          .contains('PAY')
                      ? "Paypal"
                      : "Check / Money order",
                ),
                _buildInvoiceItem(
                  title: TransactionConstants.subTotal.tr,
                  value:
                      '$currencySymbol${controller.orderDetail?.subtotal ?? 0}',
                ),
                _buildInvoiceItem(
                  title: TransactionConstants.shipping.tr,
                  value:
                      '$currencySymbol${controller.orderDetail?.shippingInclTax ?? 0}',
                ),
                _buildInvoiceItem(
                  title: TransactionConstants.tax.tr,
                  value:
                      '$currencySymbol${controller.orderDetail?.taxAmount ?? 0}',
                ),
                _buildInvoiceItem(
                  title: TransactionConstants.discount.tr,
                  value:
                      '$currencySymbol${controller.orderDetail?.discountAmount ?? 0}',
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      TransactionConstants.total.tr,
                      style: ThemeText.bodySemibold.s18,
                    )),
                    Text(
                      '$currencySymbol${((controller.orderDetail?.grandTotal ?? 0) + (controller.orderDetail?.taxAmount ?? 0))}',
                      style: ThemeText.bodySemibold.s18,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenralInformation() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.grey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInvoiceItem(
              title: TransactionConstants.customerName.tr,
              value:
                  '${controller.orderDetail?.customerFirstname ?? ''} ${controller.orderDetail?.customerLastname ?? ''}'),
          _buildInvoiceItem(
              title: TransactionConstants.email.tr,
              value: controller.orderDetail?.customerEmail ?? ''),
          _buildInvoiceItem(
              title: TransactionConstants.createAt.tr,
              value: controller.orderDetail?.createdAt ?? ''),
          _buildInvoiceItem(
              title: TransactionConstants.status.tr,
              value: controller.orderDetail?.status ?? '')
        ],
      ),
    );
  }

  Widget _buildBillingAddressItem() {
    final billingAddress = controller.orderDetail?.billingAddress;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.grey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${billingAddress?.firstname ?? ''} ${billingAddress?.lastname ?? ''}',
            style: ThemeText.bodySemibold,
          ),
          SizedBox(
            height: 2.sp,
          ),
          Text(
            billingAddress?.telephone ?? '',
            style: ThemeText.bodyRegular,
          ),
          Text(
            billingAddress?.street?.first ?? '',
            style: ThemeText.bodyRegular,
          ),
          Text(
            billingAddress?.city ?? '',
            style: ThemeText.bodyRegular,
          ),
        ],
      ),
    );
  }

  Widget _buildShippingAddressItem(Shipping shipping) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInvoiceItem(
              title: TransactionConstants.shippingMethod.tr,
              value: shipping.method ?? ''),
          Text(
            '${shipping.address?.firstname ?? ''} ${shipping.address?.lastname ?? ''}',
            style: ThemeText.bodyRegular,
          ),
          SizedBox(
            height: 2.sp,
          ),
          Text(
            shipping.address?.telephone ?? '',
            style: ThemeText.bodyRegular,
          ),
          Text(
            shipping.address?.street.toString() ?? '',
            style: ThemeText.bodyRegular,
          ),
          Text(
            shipping.address?.city ?? '',
            style: ThemeText.bodyRegular,
          ),
        ],
      ),
    );
  }

  Widget _buildShippingItem({
    required ShippingAssignments shippingAssignments,
  }) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey200),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              _buildShippingAddressItem(shippingAssignments.shipping!),
              ...List.generate(
                  shippingAssignments.items?.length ?? 0,
                  (index) => _buildItem(
                      productEntity: (shippingAssignments.items ?? [])[index]))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem({
    required Items productEntity,
  }) {
    return Padding(
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
                  '${currencySymbols[(controller.orderDetail?.baseCurrencyCode) ?? 'USD']}${(productEntity.price ?? 0) * (productEntity.qtyShipped ?? 1)}',
                  style: ThemeText.bodyRegular.s12,
                ),
                Text(
                  '${TransactionConstants.quantity.tr}: ${productEntity.qtyShipped ?? 1}',
                  style: ThemeText.bodyRegular.s12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
