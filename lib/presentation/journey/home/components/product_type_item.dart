import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class ProductTypeItem extends StatelessWidget {
  final SvgGenImage icon;
  final String title;
  final void Function()? onTap;

  const ProductTypeItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      onPressed: onTap,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: SizedBox(
        width: Get.width / 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Get.width / 4,
              width: Get.width / 4,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.grey400)),
              child: Padding(
                padding: EdgeInsets.all(20.sp),
                child: AppImageWidget(
                  asset: icon,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: ThemeText.bodySemibold,
            )
          ],
        ),
      ),
    );
  }
}
