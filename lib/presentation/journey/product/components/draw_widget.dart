import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/category_tree_model.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/home/home_controller.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/journey/product/product_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class DrawerWidget extends GetView<ProductController> {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  final mainController = Get.find<MainController>();
    return Obx(() {
      return controller.rxLoadedList.value == LoadedType.start
          ? const SizedBox.shrink()
          : Drawer(
              width: Get.width,
              backgroundColor: AppColors.white,
              child: SizedBox(
                height: Get.height,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: Get.mediaQuery.padding.top),
                    child: Column(children: [
                      ListTile(
                        //    tileColor: AppColors.grey200,
                        title: Text(
                          TransactionConstants.filterByCategory.tr,
                          style: ThemeText.bodySemibold.s18,
                        ),
                        trailing: AppTouchable(
                          onPressed: () => controller.closeDrawer(),
                          child: const Icon(
                            Icons.clear,
                            color: AppColors.black45,
                          ),
                        ),
                      ),
                      if (controller.category.value != null)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: AppTouchable(
                            onPressed: () {},
                            backgroundColor: AppColors.orange50,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.sp, vertical: 4.sp),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.category.value?.name ?? '',
                                    style: ThemeText.bodySemibold.orange,
                                  ),
                                ),
                                AppTouchable(
                                  onPressed: () =>
                                      controller.filterByCategory(null),
                                  child: Icon(
                                    Icons.clear,
                                    size: 20.sp,
                                    color: AppColors.orange,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ...List.generate(
                          controller.categories.length,
                          (index) => Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.sp),
                                child: _buildSubCategory(
                                    controller.categories.value[index]),
                              ))
                    ]),
                  ),
                ),
              ),
            );
    });
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
          .map<Widget>((e) => _buildSubCategory(e))
          .toList(),
    );
  }

  Widget _buildSubCategoryTile(CategoryTreeModel e) {
    return AppTouchable(
      onPressed: () => controller.filterByCategory(e),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.sp),
        child: Row(
          children: [
            Expanded(
              child: Text(
                e.name ?? '',
                textAlign: TextAlign.start,
                style: ThemeText.bodyRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
