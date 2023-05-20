import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/product_model.dart';
import 'package:magento_app/presentation/journey/home/home_controller.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class ProductWidget extends GetView<HomeController> {
  const ProductWidget({Key? key, required this.productModel}) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final mainController = Get.find<MainController>();
    return AppTouchable(
      onPressed: () {
        Get.toNamed(AppRoutes.productDetail, arguments: productModel.sku);
      },
      child: Container(
        color: AppColors.white,
        margin: EdgeInsets.symmetric(horizontal: 16.sp),
        width: Get.width / 2,
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImageWidget(
              url:
                  '${NetworkConfig.baseProductMediaUrl}${productModel.mediaGalleryEntries?.first.file ?? ''}',
            ),
            SizedBox(height: 16.sp),
            Text(
              productModel.name ?? '',
              style: ThemeText.bodySemibold,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.sp),
            Obx(
              () => Text(
                  '${currencySymbols[mainController.storeConfig.value.baseCurrencyCode ?? 'USD']}${productModel.price ?? 0}',
                  style: ThemeText.bodySemibold),
            ),
            const Spacer(),
            // productModel.extensionAttributes?.stockItem?.isInStock ?? false
            //     ? _buildAddToCartButton()
            //     : AppButton(
            //         backgroundColor: AppColors.white,
            //         title: TransactionConstants.outOfStock.tr,
            //         titleStyle: ThemeText.bodyMedium.orange,
            //         titleColor: AppColors.black,
            //         onPressed: () {
            //           // debugPrint('fvdvdv');
            //         },
            //       ),
          ],
        ),
      ),
    );
  }

  // Widget _buildAddToCartButton() {
  //   return AppTouchable(
  //     onPressed: () => controller.addToCart(productModel),
  //     padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 16.sp),
  //     backgroundColor: AppColors.black,
  //     child: Text(
  //       TransactionConstants.addToCartButton.tr,
  //       style: ThemeText.bodySemibold.colorWhite,
  //     ),
  //   );
  // }
}
