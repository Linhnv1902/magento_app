import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class AppBarWidget extends GetView implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
//    this.leading,
//    this.flexibleSpace,
    this.showBackButton = false,
    this.showMenu = false,
    this.title = '',
    //   this.titleStyle,
    //   this.centerTitle = true,
    this.onPressed,
    this.actions,
    //   this.elevation,
    // this.titleSize,
    // this.backgroundColor,
    //  this.leadingIcon,
    //  this.leadingColor,
    //   this.titleColor,
  }) : super(key: key);

//  final Widget? leading;
//  final Widget? flexibleSpace;
//  final IconData? leadingIcon;
//  final Color? leadingColor;
  final bool showBackButton;
  final bool showMenu;
  final String title;
  // final TextStyle? titleStyle;
  final Function()? onPressed;
  final List<Widget>? actions;

  //final double? titleSize;

  @override
  Widget build(BuildContext context) {
    final hasLeading = showBackButton || showMenu;

    return AppBar(
      //   flexibleSpace: flexibleSpace ?? const SizedBox.shrink(),
      automaticallyImplyLeading: hasLeading,
      leading: _getLeadingIcon(onPressed: onPressed),
      leadingWidth: !hasLeading ? 0 : 40.sp,
      centerTitle: false,
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: ThemeText.bodySemibold.s16,
      ),
      actions: actions,
      elevation: 0,
      backgroundColor: AppColors.white,
      // ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.h);

  Widget _getLeadingIcon({Function()? onPressed}) {
    if (showMenu) {
      return AppTouchable(
        onPressed: onPressed,
        child: AppImageWidget(
          asset: Assets.images.icMenu,
        ),
      );
    }
    if (showBackButton) {
      return AppTouchable(
        onPressed: onPressed,
        child: AppImageWidget(
          asset: Assets.images.icArrowLeft,
          size: 18.sp,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
