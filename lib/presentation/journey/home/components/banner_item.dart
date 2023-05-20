import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/config/network/network_config.dart';
import 'package:magento_app/common/utils/export.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class BannerItem extends StatelessWidget {
  const BannerItem({
    Key? key,
    this.title,
    this.image,
  }) : super(key: key);

  final String? title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: Stack(
        children: [
          AppImageWidget(
            url: '${NetworkConfig.baseProductMediaUrl}$image',
            size: Get.width - 16 * 2,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: Get.width - 16 * 2,
            width: Get.width - 16 * 2,
            child: Center(
              child: Container(
                width: double.infinity,
                // onPressed: () {},
                //   margin: EdgeInsets.only(bottom: 32.sp),
                color: AppColors.black.withOpacity(0.5),
                padding: EdgeInsets.all(16.sp),
                child: Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: ThemeText.bodySemibold.colorWhite.s24,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
