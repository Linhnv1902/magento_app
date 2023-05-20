import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/estimate_shipping_methods_model.dart';
import 'package:magento_app/domain/models/save_shipping_method_response_model.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/estimate_shipping/estimate_shipping_controller.dart';
import 'package:magento_app/presentation/journey/payment/payment_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      appBar: AppBarWidget(
        showBackButton: true,
        title: TransactionConstants.paymentMethod.tr,
        onPressed: () => Get.back(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: SingleChildScrollView(child: Obx(() {
          if (controller.rxLoadedList.value == LoadedType.start) {
            return SizedBox(
              height: Get.height / 2,
              child: AppLoadingWidget(),
            );
          }

          final methods = controller.methods.value;

          return methods.isEmpty
              ? Center(
                  child: Padding(
                  padding: EdgeInsets.only(top: 24.sp),
                  child: Text(
                    TransactionConstants.noPaymentMethod.tr,
                    style: ThemeText.bodyMedium.grey500Color.s20,
                  ),
                ))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: methods.map((e) => _buildItem(method: e)).toList());
        })),
      ),
      bottomNavigationBar: Obx(() => Padding(
            padding: EdgeInsets.all(16.sp),
            child: AppButton(
              title: TransactionConstants.continueButton.tr,
              loaded: controller.rxLoadedButton.value,
              onPressed: ()   => Get.toNamed(AppRoutes.checkout) ,
            ),
          )),
    );
  }

  Widget _buildItem({required PaymentMethods method}) {
    return GestureDetector(
      onTap: () => controller.updateSelectedMethod(method),
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(vertical: 8.sp),
        child: Row(
          children: [
            AppImageWidget(
              asset: controller.selectedMethod.value == method
                  ? Assets.images.icCircleChecked
                  : Assets.images.icCircleUnchecked,
              size: 20.sp,
            ),
            SizedBox(width: 16.sp),
            Text(
              method.title ?? '',
              style: ThemeText.bodySemibold,
            )
          ],
        ),
      ),
    );
  }
}
