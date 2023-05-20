import 'package:flutter/material.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

import 'app_image_widget.dart';

class AppButton extends StatelessWidget {
  final String title;
  final LoadedType? loaded;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? width;
  final Function()? onPressed;
  final TextStyle? titleStyle;

  const AppButton({
    Key? key,
    required this.title,
    this.loaded = LoadedType.finish,
    this.backgroundColor = AppColors.primary,
    this.titleColor = AppColors.white,
    this.width,
    this.onPressed,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width ?? double.infinity,
          height: AppDimens.height_52,
          child: TextButton(
            onPressed: () {
              hideKeyboard();
              if (!isNullEmpty(onPressed)) {
                loaded == LoadedType.finish ? onPressed!(): null;
              }
            },
            style: ButtonStyle(
              textStyle: MaterialStateProperty.resolveWith(
                (states) => titleStyle ?? ThemeText.bodyMedium,
              ),
              // padding: MaterialStateProperty.resolveWith(
              //   (states) => widget.padding,
              // ),
              enableFeedback: true,
              foregroundColor: MaterialStateColor.resolveWith(
                (states) => titleColor!,
              ),
              overlayColor: MaterialStateColor.resolveWith(
                (states) => AppColors.white.withOpacity(0.1),
              ),
              splashFactory: null,
              elevation: MaterialStateProperty.resolveWith(
                (states) => 0.0,
              ),
              backgroundColor: MaterialStateColor.resolveWith(
                (states) {
                  if (isNullEmpty(onPressed)) {
                    return AppColors.grey;
                  } else {
                    if (loaded == LoadedType.start) {
                      return backgroundColor!;
                    } else {
                      return backgroundColor!;
                    }
                  }
                },
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radius_12),
                ),
              ),
            ),
            child: loaded == LoadedType.start
                ? const SizedBox.shrink()
                : Text(
                    title,
                  ),
          ),
        ),
        loaded == LoadedType.start
            ? SizedBox(
                height: 60.h,
                child: AppImageWidget(
                  asset: Assets.images.loadingButton,
                  //   color: AppColors.white,
                  size: 20.sp,
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
