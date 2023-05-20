import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/domain/models/category_tree_model.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/category/category_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class CategoryScreen extends GetView<CategoryController> {
  CategoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarWidget(
        title: TransactionConstants.mainNavigationCategory.tr,
      ),
      body: SingleChildScrollView(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Obx(() => Column(
          children: [
            SizedBox(
              height: 100.sp,
              child: controller.rxLoadedLeftList.value == LoadedType.start
                  ? const AppLoadingWidget()
                  : ListView.builder(
                      itemBuilder: (context, index) => AppTouchable(
                        onPressed: () async =>
                            await controller.onSelectCategory(index),
                        child: _buildCategoryWidget(
                            category: controller.categories.value[index],
                            image: controller.categoryImages[index],
                            isSelected:
                                index == controller.selectedIndex.value),
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categories.value.length,
                    ),
            ),
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: controller.rxLoadedRightList.value == LoadedType.start
                  ? Padding(
                      padding: EdgeInsets.only(top: 30.sp),
                      child: const AppLoadingWidget(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => controller.productsOfCategory.value.isEmpty
                              ? const SizedBox.shrink()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          TransactionConstants.viewAll.tr,
                                          style: ThemeText.bodySemibold.s16,
                                        )),
                                        AppImageWidget(
                                          asset: Assets.images.icArrowRight,
                                          size: 18.sp,
                                          color: AppColors.black,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.sp,
                                    ),
                                    Wrap(
                                      children: controller
                                          .productsOfCategory.value
                                          .map((e) => AppTouchable(
                                                onPressed: () {
                                                  Get.toNamed(
                                                      AppRoutes.productDetail,
                                                      arguments: e.sku);
                                                },
                                                child: _buildItem(
                                                    title: e.name,
                                                    image: e.mediaGalleryEntries
                                                        ?.first.file),
                                              ))
                                          .toList(),
                                    ),
                                    SizedBox(
                                      height: 20.sp,
                                    ),
                                  ],
                                ),
                        ),
                        Obx(() => controller.subCategories.value.isEmpty
                            ? const SizedBox.shrink()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    TransactionConstants.subCategories.tr,
                                    style: ThemeText.bodySemibold.s16,
                                  ),
                                  SizedBox(
                                    height: 8.sp,
                                  ),
                                  Column(
                                      children: controller.subCategories.value
                                          .map((e) => _buildSubCategory(e))
                                          .toList())
                                ],
                              ))
                      ],
                    ),
            ),
            SizedBox(
              height: 30.sp,
            )
          ],
        ));
  }

  Widget _buildItem({String? title, String? image}) {
    return Container(
      margin: EdgeInsets.only(right: 16.sp),
      width: Get.width / 5,
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      //    padding: EdgeInsets.all(16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImageWidget(
            border: Border.all(color: AppColors.grey200),
            borderRadius: BorderRadius.circular(10),
            url: '${NetworkConfig.baseProductMediaUrl}$image',
            //  fit: ,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title ?? '',
            style: ThemeText.bodyRegular,
          )
        ],
      ),
    );
  }

  Widget _buildSubCategory(CategoryTreeModel category) {
    if ((category.childrenData ?? []).isEmpty) {
      return _buildSubCategoryTile(category);
    }
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        category.name ?? '',
        style: ThemeText.bodyRegular,
      ),
      iconColor: AppColors.black,
      collapsedIconColor: AppColors.black,
      childrenPadding: EdgeInsets.only(left: 10.sp, top: 0.sp),
      children: (category.childrenData ?? [])
          .map<Widget>((e) => _buildSubCategoryTile(e))
          .toList(),
    );
  }

  Widget _buildSubCategoryTile(CategoryTreeModel e) {
    return AppTouchable(
      onPressed: () async => await controller.onViewProductList(e),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.sp),
        child: Row(
          children: [
            AppImageWidget(
              asset: Assets.images.icCircle,
              size: 10.sp,
            ),
            SizedBox(
              width: 8.sp,
            ),
            Expanded(
                child: Text(
              e.name ?? '',
              style: ThemeText.bodyRegular,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryWidget(
      {required CategoryTreeModel category,
      required String image,
      bool isSelected = false}) {
    return Container(
      height: 100.sp,
      width: 100.sp,
      color: isSelected ? AppColors.white : AppColors.grey100,
      padding: EdgeInsets.all(4.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImageWidget(
            url: '${NetworkConfig.baseMediaUrl}$image',
            height: 60.sp,
            width: 60.sp,
            //  fit: ,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            category.name ?? '',
            style: ThemeText.bodyRegular,
          )
        ],
      ),
    );
  }
}
