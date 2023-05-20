import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/review_model.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/journey/product_detail/product_detail_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    final mainController = Get.find<MainController>();
    return Scaffold(
      floatingActionButton: Container(
        width: Get.width / 5,
        decoration: BoxDecoration(
            color: AppColors.orange,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: AppColors.black.withOpacity(0.2),
                  offset: const Offset(0.5, 0.5),
                  blurRadius: 3,
                  spreadRadius: 1)
            ]),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(),
              child: AppTouchable(
                onPressed: () {
                  Get.back();
                  Get.back();
                  mainController.onChangedNav(2);
                },
                child: AppImageWidget(
                  asset: Assets.images.icShoppingCart,
                  color: AppColors.white,
                  size: Get.width / 5 - 36.sp,
                  margin: EdgeInsets.only(
                      top: 16.sp,
                      bottom: MediaQuery.of(context).padding.bottom + 16.sp,
                      left: 18.sp),
                ),
              ),
            ),
            Positioned(
              top: 8.sp,
              right: 10.sp,
              child: Obx(
                () => Visibility(
                  visible: mainController.totalItem.value != 0,
                  child: Container(
                    width: 22.sp,
                    height: 22.sp,
                    padding: EdgeInsets.all(2.sp),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.red,
                    ),
                    child: Center(
                        child: FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        '${mainController.totalItem.value > 99 ? '99+' : mainController.totalItem.value}',
                        style: ThemeText.bodySemibold.colorWhite,
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () {
          final product = controller.product.value;
          final description = product.customAttributes?.firstWhereOrNull(
              (element) =>
                  element.attributeCode?.compareTo('description') == 0);
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: true,
                snap: false,
                floating: false,
                leading: AppTouchable(
                  onPressed: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                      color: AppColors.grey100,
                      shape: BoxShape.circle,
                    ),
                    child: AppImageWidget(
                      asset: Assets.images.icArrowLeft,
                      size: 18.sp,
                    ),
                  ),
                ),
                expandedHeight: 250.0,
                flexibleSpace:
                    (controller.rxLoadedList.value == LoadedType.start)
                        ? const SizedBox.shrink()
                        : FlexibleSpaceBar(
                            // title: Text('Goa', textScaleFactor: 1),
                            background: AppImageWidget(
                              backgroundColor: AppColors.white,
                              url:
                                  '${NetworkConfig.baseProductMediaUrl}${product.mediaGalleryEntries?.first.file ?? ''}',
                              width: Get.width,
                            ),
                          ),
              ),
              (controller.rxLoadedList.value == LoadedType.start)
                  ? const SliverToBoxAdapter(child: AppLoadingWidget())
                  : SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name ?? '',
                              style: ThemeText.bodyStrong.s24,
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            Text(
                              '${currencySymbols[mainController.storeConfig.value.baseCurrencyCode ?? 'USD']}${product.price ?? 0}',
                              style: ThemeText.bodySemibold.s18,
                            ),
                            SizedBox(
                              height: 16.sp,
                            ),
                            RichText(
                              text: TextSpan(
                                  text:
                                      '${TransactionConstants.availability.tr}: ',
                                  style: ThemeText.bodyRegular,
                                  children: [
                                    TextSpan(
                                      text: product.extensionAttributes
                                                  ?.stockItem?.isInStock ??
                                              false
                                          ? TransactionConstants.inStock.tr
                                          : TransactionConstants.outOfStock.tr,
                                      style: ThemeText.bodyRegular.orange,
                                    )
                                  ]),
                            ),
                            SizedBox(
                              height: 16.sp,
                            ),
                            if (product.extensionAttributes?.stockItem
                                    ?.isInStock ??
                                false)
                              Row(
                                children: [
                                  Text(
                                    '${TransactionConstants.selectQuantity.tr}: ',
                                    style: ThemeText.bodyRegular,
                                  ),
                                  SizedBox(
                                    width: 16.sp,
                                  ),
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Expanded(
                                        child: AppTouchable(
                                          backgroundColor: AppColors.grey200,
                                          onPressed:
                                              controller.increaseQuantity,
                                          child: Text(
                                            "+",
                                            style: ThemeText.bodyMedium.s24,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Obx(
                                          () => Text(
                                            controller.quantity.value
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: ThemeText.bodySemibold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: AppTouchable(
                                          backgroundColor: AppColors.grey200,
                                          onPressed:
                                              controller.decreaseQuantity,
                                          child: Text(
                                            "-",
                                            style: ThemeText.bodyMedium.s24,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            product.extensionAttributes?.stockItem?.isInStock ??
                                    false
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: AppButton(
                                          title: TransactionConstants.buyNow.tr,
                                          onPressed: () async {
                                            await controller.addToCart();
                                            Get.back();
                                            Get.back();
                                            mainController.onChangedNav(2);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.sp,
                                      ),
                                      Expanded(
                                          child: AppButton(
                                        backgroundColor: AppColors.white,
                                        title: TransactionConstants
                                            .addToCartButton.tr,
                                        titleStyle:
                                            ThemeText.bodyMedium.colorBlack,
                                        titleColor: AppColors.black,
                                        onPressed: controller.addToCart,
                                      ))
                                    ],
                                  )
                                : AppButton(
                                    backgroundColor: AppColors.white,
                                    title: TransactionConstants.outOfStock.tr,
                                    titleStyle: ThemeText.bodyMedium.orange,
                                    titleColor: AppColors.black,
                                    onPressed: () {
                                      // debugPrint('fvdvdv');
                                    },
                                  ),
                            SizedBox(height: 16.sp),
                            _buildDescription(description?.value ?? ''),
                            SizedBox(height: 16.sp),
                            _buildAddReviewWidget(),
                            SizedBox(height: 16.sp),
                            _buildReviewWidget(),
                            SizedBox(height: 16.sp),
                          ],
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.sp),
          width: Get.width,
          color: AppColors.grey200,
          child: Text(
            TransactionConstants.description.tr,
            style: ThemeText.bodySemibold,
          ),
        ),
        SizedBox(height: 16.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: HtmlWidget(
            description,
            onLoadingBuilder: (context, element, loadingProgress) =>
                const AppLoadingWidget(),
            onErrorBuilder: (context, element, error) =>
                const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingWidget() {
    return RatingBar.builder(
      initialRating: controller.rating.value.toDouble(),
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemSize: 30.sp,
      onRatingUpdate: (rating) {
        controller.rating.value = rating.round();
      },
    );
  }

  Widget _buildAddReviewWidget() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.sp),
          width: Get.width,
          color: AppColors.grey200,
          child: Text(
            'Add Review',
            style: ThemeText.bodySemibold,
          ),
        ),
        SizedBox(height: 16.sp),
        Obx(() => _buildRatingWidget()),
        SizedBox(height: 16.sp),
        Obx(
          () => AppTextField(
            hintText: 'Title',
            controller: controller.titleController,
            keyboardType: TextInputType.text,
            errorText: controller.titleValidate.value,
            onChangedText: (value) => controller.onChangedTitle(),
            onTap: () => controller.onTapTitleTextField(),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => controller.onEditingCompleteTitle(),
            focusNode: controller.titleFocusNode,
          ),
        ),
        SizedBox(
          height: 16.sp,
        ),
        Obx(
          () => AppTextField(
            hintText: 'Detail',
            controller: controller.detailController,
            errorText: controller.detailValidate.value,
            maxLines: 5,
            onChangedText: (value) => controller.onChangedDetail(),
            onTap: () => controller.onTapDetailTextField(),
            textInputAction: TextInputAction.done,
            onEditingComplete: () => controller.onEditingCompleteDetail(),
            focusNode: controller.detailFocusNode,
          ),
        ),
        SizedBox(
          height: 20.sp,
        ),
        Obx(
          () => AppButton(
            backgroundColor: AppColors.black,
            title: 'Review',
            onPressed: () => controller.addReview(),
            loaded: controller.rxLoadedButton.value,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewWidget() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.sp),
          width: Get.width,
          color: AppColors.grey200,
          child: Text(
            'Review',
            style: ThemeText.bodySemibold,
          ),
        ),
        SizedBox(height: 16.sp),
        ...List.generate(controller.reviews.value.length,
            (index) => _buildReviewItem(controller.reviews[index])),
        SizedBox(height: 16.sp),
      ],
    );
  }

  Widget _buildReviewItem(ReviewModel reviewModel) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.sp),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 4.sp,),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    reviewModel.nickname ?? '',
                    style: ThemeText.bodyMedium.s12,
                  ),
                ),
                Text(
                  '${reviewModel.ratings?.first.value ?? 0}',
                  style: ThemeText.bodySemibold,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16.sp,
                )
              ],
            ),
            SizedBox(
              height: 4.sp,
            ),
            Text(
              reviewModel.title ?? '',
              style: ThemeText.bodyMedium,
            ),
            SizedBox(
              height: 4.sp,
            ),
            Text(
              reviewModel.detail ?? '',
              style: ThemeText.bodyRegular.s12,
            ),
          ],
        ),
      ),
    );
  }
}
