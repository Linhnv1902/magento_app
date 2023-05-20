import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/get_all_orders_response_model.dart';
import 'package:magento_app/presentation/journey/my_orders/my_orders_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';
import 'package:magento_app/presentation/widgets/export.dart';
import 'package:magento_app/presentation/widgets/refresh_widget.dart';

class MyOrdersScreen extends GetView<MyOrdersController> {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return WillPopScope(
      onWillPop: () async {
        Get.back(result: controller.shouldRefresh.value);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
            showBackButton: true,
            title: TransactionConstants.myOrders.tr,
            onPressed: () => Get.back(result: controller.shouldRefresh.value)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            // color: AppColors.greyF0FF,
            // height: 1.h,
            // ),
            SizedBox(height: 16.sp),
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: RichText(
                  text: TextSpan(
                    text: '${TransactionConstants.total.tr}: ',
                    style: ThemeText.bodySemibold,
                    children: [
                      TextSpan(
                        text: '${controller.orders.length}',
                        style: ThemeText.bodyRegular,
                      )
                    ],
                  ),
                ),
              ),
            ),
            //  SizedBox(height: 16.sp),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.sp),
            //   child: AppTextField(
            //     prefixIcon: Padding(
            //       padding: EdgeInsets.only(left: 16.sp, right: 10.5.sp),
            //       child: SizedBox(
            //         width: 14.sp,
            //         height: 14.sp,
            //         child: AppImage.asset(
            //           path: ImageConstants.icSearch,
            //           color: AppColors.primary,
            //         ),
            //       ),
            //     ),
            //     hintText: 'Tìm mã đơn hàng',
            //     controller: controller.searchController,
            //     onChangedText: (value) => controller.onSearch(value),
            //     focusNode: controller.searchFocusNode,
            //   ),
            // ),
            SizedBox(height: 16.sp),
            Expanded(
              child: Obx(
                () => RefreshWidget(
                  enableLoadMore: controller.canLoadMore.value,
                  onLoadMore: () async {
                    double oldPosition =
                        controller.scrollController.position.pixels;
                    await controller.getAllOrders();
                    // if (controller.searchController.text.isNotEmpty) {
                    //   await controller
                    //       .onSearch(controller.searchController.text);
                    // }
                    controller.scrollController.position.jumpTo(oldPosition);
                  },
                  controller: controller.ordersRefreshController,
                  onRefresh: controller.onRefresh,
                  child: CustomScrollView(
                    controller: controller.scrollController,
                    shrinkWrap: true,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            controller.rxLoadedList.value == LoadedType.start
                                ? SizedBox(
                                    height: Get.height / 2,
                                    child: const AppLoadingWidget())
                                : Column(
                                    children: controller.orders.value.reversed
                                        .toList()
                                        .map((e) => _buildItem(e))
                                        .toList(),
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(OrderDetail orderDetail) {
    return AppTouchable(
      onPressed: () {
        Get.toNamed(AppRoutes.myOrderDetail, arguments: orderDetail);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.sp, left: 16.sp, right: 16.sp),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey200),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //   '${TransactionConstants.orderId.tr}: ${orderDetail.quoteId ?? 0}',
                          (orderDetail.incrementId ?? 0).toString(),
                          style: ThemeText.bodySemibold,
                        ),
                        Text(
                          '${TransactionConstants.createAt.tr}: ${orderDetail.createdAt ?? ''}',
                          style: ThemeText.bodyRegular,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.grey200,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 6.sp, horizontal: 10.sp),
                        child: Center(
                          child: Text(
                            orderDetail.status ?? '',
                            style: ThemeText.bodyRegular,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12.sp,
              ),
              ...List.generate(
                  orderDetail.items?.length ?? 0,
                  (index) => _buildProductItem(
                      productEntity: (orderDetail.items ?? [])[index])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem({
    required Items productEntity,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.sp, 16.sp, 16.sp, 0),
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
                  '${currencySymbols[controller.mainController.storeConfig.value.baseCurrencyCode ?? 'USD']}${(productEntity.price ?? 0) * (productEntity.qtyOrdered ?? 1)}',
                  style: ThemeText.bodyRegular.s12,
                ),
                Text(
                  '${TransactionConstants.quantity.tr}: ${productEntity.qtyOrdered ?? 1}',
                  style: ThemeText.bodyRegular.s12,
                ),
              ],
            ),
          ),
        ],
      ),
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
}
