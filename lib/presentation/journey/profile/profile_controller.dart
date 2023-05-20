import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magento_app/common/common_export.dart';
import 'package:magento_app/common/utils/app_validator.dart';
import 'package:magento_app/domain/models/customer_model.dart';
import 'package:magento_app/domain/usecases/account_usecase.dart';
import 'package:magento_app/presentation/controllers/mixin/export.dart';
import 'package:magento_app/presentation/journey/main/main_controller.dart';
import 'package:magento_app/presentation/widgets/export.dart';

enum Gender {
  man(0),
  woman(1);

  const Gender(this.value);
  final int value;
}

class ProfileController extends GetxController with MixinController {
  Rx<LoadedType> rxLoadedButton = LoadedType.finish.obs;
  AccountUseCase accountUsecase;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();

  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final dobFocusNode = FocusNode();

  //RxString errorText = ''.obs;

  RxString firstNameValidate = ''.obs;
  RxString lastNameValidate = ''.obs;
  RxString dobValidate = ''.obs;

  RxBool firstNameHasFocus = false.obs;
  RxBool lastNameHasFocus = false.obs;
  RxBool dobHasFocus = false.obs;

  RxBool buttonEnable = false.obs;

  RxString errorText = ''.obs;

  CustomerModel customer = CustomerModel();

  Rx<Gender?> selectedGender = (null as Gender?).obs;
  RxString selectedDate = ''.obs;

  final MainController _mainController = Get.find<MainController>();

  bool loadError = false;

  ProfileController({required this.accountUsecase});

  void checkButtonEnable() {
    if (firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty) {
      buttonEnable.value = true;
    } else {
      buttonEnable.value = false;
    }
  }

  void updateSelectedGender(Gender gender) {
    selectedGender.value = gender;
  }

  void saveInfo() async {
    rxLoadedButton.value = LoadedType.start;
    hideKeyboard();
    // errorText.value = '';

    firstNameValidate.value = AppValidator.validateName(
      TransactionConstants.firstName.tr,
      firstNameController,
    );

    lastNameValidate.value = AppValidator.validateName(
      TransactionConstants.lastName.tr,
      lastNameController,
    );

    if (dobController.text.trim().isNotEmpty) {
      dobValidate.value = AppValidator.validateDob(dobController);
    }

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      rxLoadedButton.value = LoadedType.finish;
      return;
    }

    if (dobValidate.value.isEmpty &&
        firstNameValidate.value.isEmpty &&
        lastNameValidate.value.isEmpty) {
      final result = await accountUsecase.updateCustomer(
        customer: customer.copyWith(
          firstname: firstNameController.text.trim(),
          lastname: lastNameController.text.trim(),
          dob: dobController.text.trim(),
          gender: selectedGender.value?.value,
        ),
      );

      if (result != null) {
        debugPrint('cập nhật thành công');
        await _mainController.getUserProfile();
        showTopSnackBar(context,
            message: TransactionConstants.successfully.tr,
            type: SnackBarType.done);
        Get.back();
      }
      // else {
      //   showTopSnackBarError(context, TransactionConstants.unknownError.tr);
      //   //
      //   // } else {
      //   //   debugPrint('đăng nhập thất bại');
      //   //   errorText.value = TransactionConstants.loginError.tr;
      // }
    }

    rxLoadedButton.value = LoadedType.finish;
  }

  void onEditingCompleteDob() {
    dobHasFocus.value = false;
    FocusScope.of(context).unfocus();
    if (buttonEnable.value) {
      saveInfo();
    }
  }

  void onPressedSave() {
    dobHasFocus.value = false;
    lastNameHasFocus.value = false;
    firstNameHasFocus.value = false;
    checkButtonEnable();
    if (buttonEnable.value) {
      saveInfo();
    }
  }

  @override
  void onInit() {
    super.onInit();
    customer = _mainController.rxCustomer.value ?? CustomerModel();
  }

  @override
  void onReady() async {
    super.onReady();

    await getInitInfo();
  }

  Future<void> getInitInfo() async {
    firstNameController.text = customer.firstname ?? '';
    lastNameController.text = customer.lastname ?? '';
    dobController.text = customer.dob ?? '';
    if (customer.gender != null) {
      selectedGender.value = (customer.gender == 1) ? Gender.woman : Gender.man;
    }
  }
}
