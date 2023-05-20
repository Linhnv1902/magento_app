import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/domain/models/get_messages_response_model.dart';
import 'package:magento_app/domain/usecases/account_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/widgets/export.dart';
import 'package:magento_app/services/local_notification_service.dart';

class MessageController extends GetxController with MixinController {
  Rx<LoadedType> rxLoadedList = LoadedType.start.obs;

  RxList<Message> messages = <Message>[].obs;

  final AccountUseCase accountUseCase;
  RxInt currentPage = 1.obs;
  RxBool canLoadMore = true.obs;
  final scrollController = ScrollController();
  TextEditingController chatController = TextEditingController();
  FocusNode chatFocusNode = FocusNode();
  RxBool shouldRefresh = false.obs;
  final mainController = Get.find<MainController>();

  MessageController({required this.accountUseCase});

  Future<void> getAllMessages() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }
    final result = await accountUseCase.getAllMessage(
        customerId: (mainController.rxCustomer.value?.id ?? 0).toString());
    if (result != null) {
      if (result.items != null &&
          result.items!.isNotEmpty &&
          messages.isNotEmpty &&
          mainController.rxCurrentNavIndex.value != 3) {
        final newMessages = [...result.items!];
        messages.forEach((oldMess) {
          newMessages.removeWhere((element) =>
              element.messageId?.compareTo(oldMess.messageId ?? '') == 0);
        });

        int id = 0;
        newMessages.forEach((element) {
          LocalNotificationService.setupNotification(
              title: 'Support Chat',
              content: element.bodyMsg ?? '',
              notiId: id);
          id++;
        });
      }
      messages.clear();
      messages.addAll(result.items ?? []);
    }
  }

  Future<void> sendMessage() async {
    if (chatController.text.trim().isEmpty) {
      return;
    }

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      return;
    }

    final result = await accountUseCase.sendMessage(
        customerId: (mainController.rxCustomer.value?.id ?? 0).toString(),
        message: chatController.text.trim());
    if (result) {
      messages.add(Message(bodyMsg: chatController.text.trim()));
      chatController.text = '';
    }
  }

  @override
  void onReady() async {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      await getAllMessages();
    });
  }
}
