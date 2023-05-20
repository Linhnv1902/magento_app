import 'package:flutter/material.dart';
import 'package:magento_app/common/utils/app_screen_utils/flutter_screenutils.dart';
import 'package:magento_app/gen/assets.gen.dart';

import 'app_image_widget.dart';

class AppLoadingWidget extends StatelessWidget {
  final double? width;

  const AppLoadingWidget({Key? key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Center(
        child: AppImageWidget(
          asset: Assets.images.loadingGif,
          size: 50.sp,
        ),
      ),
    );
  }
}
