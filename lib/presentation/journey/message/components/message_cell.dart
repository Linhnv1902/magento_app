import 'package:flutter/widgets.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/gen/assets.gen.dart';
import 'package:magento_app/presentation/theme/export.dart';
import 'package:magento_app/presentation/widgets/export.dart';

class AdminMessageCell extends StatelessWidget {
  const AdminMessageCell({Key? key, required this.mess}) : super(key: key);

  final String mess;
  // final MessageSmsModel smsModel;
  // final PeopleChat? peopleChat;
  // const SmsCell({Key? key, required this.smsModel, required this.peopleChat})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 25.sp,
            height: 25.sp,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              //   color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: AppImageWidget(
              asset: Assets.images.icShop,
              // isCircle: true,
            ),
          ),
          SizedBox(
            width: 8.sp,
          ),
          Flexible(
            child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(20.sp)),
                child: Text(
                  mess,
                  style: ThemeText.bodyRegular,
                  softWrap: true,
                )),
          ),
          SizedBox(
            width: 33.sp,
          ),
        ],
      ),
    );
  }
}

class CustomerMessageCell extends StatelessWidget {
  const CustomerMessageCell({Key? key, required this.mess}) : super(key: key);

  final String mess;
  // final MessageSmsModel smsModel;
  // final PeopleChat? peopleChat;
  // const SmsCell({Key? key, required this.smsModel, required this.peopleChat})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 33.sp,
          ),
          Flexible(
            child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(20.sp)),
                child: Text(
                  mess,
                  style: ThemeText.bodyRegular,
                  softWrap: true,
                )),
          ),
          SizedBox(
            width: 8.sp,
          ),
          Container(
            width: 25.sp,
            height: 25.sp,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              //   color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: AppImageWidget(
              asset: Assets.images.icUser,
              // isCircle: true,
            ),
          ),
        ],
      ),
    );
  }
}
