import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/utils/export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/journey/message/message_controller.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class InputMessageWidget extends GetView<MessageController> {
  const InputMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.sp,
      margin: EdgeInsets.all(16.sp),
      padding: EdgeInsets.zero,
      child: TextFormField(
        controller: controller.chatController,
        style: ThemeText.bodyRegular,
        decoration: InputDecoration(
          filled: true,
          hintStyle: ThemeText.bodyRegular.grey200Color,
          fillColor: AppColors.grey200,
          suffixIcon: AppImageWidget(
            onTap: () async => await controller.sendMessage(),
            asset: Assets.images.icSendSms,
            margin: EdgeInsets.only(top: 4.sp),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
        ),
      ),
    );
  }
}
