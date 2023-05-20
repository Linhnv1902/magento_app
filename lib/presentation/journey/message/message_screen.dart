import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/presentation/journey/message/components/input_message_widget.dart';
import 'package:magento_app/presentation/journey/message/components/message_cell.dart';
import 'package:magento_app/presentation/journey/message/message_controller.dart';
import 'package:magento_app/presentation/widgets/app_bar_widget.dart';

class MessageScreen extends GetView<MessageController> {
   MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // extendBody: true,
      appBar: const AppBarWidget(
        //  showBackButton: true,
        title: 'Support Chat',
        //onPressed: () => Get.back(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            reverse: true,
            child: Obx(() => Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      controller.messages.value.length,
                      (index) {
                        if (controller.messages[index].userName ==
                            'Admin Mageplaza') {
                          return AdminMessageCell(
                            mess: controller.messages[index].bodyMsg ?? '',
                          );
                        } else {
                          return CustomerMessageCell(
                              mess: controller.messages[index].bodyMsg ?? '');
                        }
                      },
                    ),
                  ],
                )),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: Get.mediaQuery.viewPadding.bottom +
              (Get.mediaQuery.viewInsets.bottom == 0 ? Get.width / 10 : 0),
        ),
        child: const InputMessageWidget(),
      ),
    );
  }
}
