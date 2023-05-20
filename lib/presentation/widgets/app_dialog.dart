import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/constants/constants_export.dart';
import 'package:magento_app/common/utils/export.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

Future showAppDialog(BuildContext context, String titleText,
    {Widget? messageWidget,
    String? iconPath,
    bool isIconSvg = false,
    bool customBody = false,
    Widget? widgetBody,
    required String firstButtonText,
    Color firstButtonColor = AppColors.primary,
    VoidCallback? firstButtonCallback,
    LoadedType? firstButtonState,
    String? secondButtonText,
    Color secondButtonColor = AppColors.white,
    VoidCallback? secondButtonCallback,
    bool dismissAble = false,
    WidgetBuilder? builder,
    bool? delayConfirm,
    required TextAlign messageTextAlign}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissAble,
    builder: builder ??
        (BuildContext context) => AppDialog(
              delayConfirm: delayConfirm,
              title: titleText,
              messageWidget: messageWidget,
              iconPath: iconPath,
              isIconSvg: isIconSvg,
              customBody: customBody,
              widgetBody: widgetBody,
              firstButtonText: firstButtonText,
              firstButtonColor: firstButtonColor,
              firstButtonCallback: firstButtonCallback,
              firstButtonState: firstButtonState,
              secondButtonText: secondButtonText,
              secondButtonCallback: secondButtonCallback,
              //  firstBtnState: firstBtnState,
              messageTextAlign: messageTextAlign,
            ),
  );
}

class AppDialog extends StatefulWidget {
  final String? title;
  final Widget? messageWidget;
  final String? iconPath;
  final bool isIconSvg;
  final bool customBody;
  final bool dismissAble;
  final Widget? widgetBody;
  final String firstButtonText;
  final Color firstButtonColor;
  final VoidCallback? firstButtonCallback;
  final LoadedType? firstButtonState;
  final String? secondButtonText;
  final Color? secondButtonColor;
  final VoidCallback? secondButtonCallback;
  final bool? delayConfirm;
//  final ButtonState? firstBtnState;
  final TextAlign messageTextAlign;

  const AppDialog(
      {Key? key,
      this.title,
      this.messageWidget,
      this.iconPath,
      this.isIconSvg = false,
      this.customBody = false,
      this.dismissAble = false,
      this.widgetBody,
      required this.firstButtonText,
      required this.firstButtonColor,
      this.firstButtonCallback,
      this.secondButtonText,
      this.secondButtonColor,
      this.secondButtonCallback,
      required this.messageTextAlign,
      this.firstButtonState,
      this.delayConfirm = false})
      : super(key: key);

  @override
  State<AppDialog> createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {
  bool enableConfirm = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var dialogWidth = min<double>(width * 0.86, 400);
    return WillPopScope(
      onWillPop: () async => widget.dismissAble,
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(
        //     AppDimens.radius_5,
        //   ),
        // ),
        // elevation: 0.0,
        backgroundColor: AppColors.white,
        child: Container(
          //     margin: EdgeInsets.all(24.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.white,
          ),
          width: Get.width - 16.sp * 2,
          child: Padding(
            padding: EdgeInsets.all(24.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // isNullEmpty(widget.title)
                //     ? const SizedBox.shrink()
                //     :
                Text(
                        widget.title ?? '',
                        textAlign: TextAlign.start,
                        style: ThemeText.bodyRegular,
                      ),
                SizedBox(height: 16.sp),
                // Text(
                //   widget.message,
                //   textAlign: widget.messageTextAlign,
                //   style: ThemeText.bodyRegular.grey500Color,
                // ),
                SizedBox(height: 16.sp),
                Visibility(
                  visible: enableConfirm,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppButton(
                          //   margin: EdgeInsets.all(0),
                          title: widget.firstButtonText,
                          onPressed: widget.firstButtonCallback,
                          loaded: widget.firstButtonState ?? LoadedType.finish,
                        ),
                      ),
                      SizedBox(width: 8.sp,),
                      if (widget.secondButtonText != null)
                        Expanded(
                          child: AppButton(
                            // margin: EdgeInsets.all(0),
                            // borderRadius: BorderRadius.circular(0),
                            // textStyle:
                            //     ThemeText.button.copyWith(color: AppColors.grey),
                            title: widget.secondButtonText ?? '',
                            //     bgColor: AppColors.transparent,
                            onPressed: widget.secondButtonCallback,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    if (!isNullEmpty(widget.delayConfirm)) {
      setState(() {
        enableConfirm = false;
      });
      Future.delayed(const Duration(seconds: 5)).then((value) => setState(() {
            enableConfirm = true;
          }));
    }
  }
}
