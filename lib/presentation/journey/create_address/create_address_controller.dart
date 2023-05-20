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

class CreateNewAddressController extends GetxController with MixinController {
  Rx<LoadedType> rxLoadedButton = LoadedType.finish.obs;
  AccountUseCase accountUsecase;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();

  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final streetFocusNode = FocusNode();
  final cityFocusNode = FocusNode();

  //RxString errorText = ''.obs;

  RxString firstNameValidate = ''.obs;
  RxString lastNameValidate = ''.obs;
  RxString phoneValidate = ''.obs;
  RxString streetValidate = ''.obs;
  RxString cityValidate = ''.obs;

  RxBool firstNameHasFocus = false.obs;
  RxBool lastNameHasFocus = false.obs;
  RxBool phoneHasFocus = false.obs;
  RxBool streetHasFocus = false.obs;
  RxBool cityHasFocus = false.obs;

  RxBool buttonEnable = false.obs;

  RxString errorText = ''.obs;

  CustomerModel customer = CustomerModel();

  final MainController _mainController = Get.find<MainController>();

  bool loadError = false;

  RxBool defaultBillingAddress = false.obs;
  RxBool defaultShippingAddress = false.obs;

  Addresses? editAddress;

  CreateNewAddressController({required this.accountUsecase});

  void checkButtonEnable() {
    if (firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty) {
      buttonEnable.value = true;
    } else {
      buttonEnable.value = false;
    }
  }

  void onChangeSetDefaultBillingAddress() {
    defaultBillingAddress.value = !defaultBillingAddress.value;
  }

  void onChangeSetDefaultShippingAddress() {
    defaultShippingAddress.value = !defaultShippingAddress.value;
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

    phoneValidate.value = AppValidator.validatePhoneNumber(phoneController);

    streetValidate.value = streetController.text.trim().isEmpty
        ? 'Street is a required value '
        : '';
    cityValidate.value =
        cityController.text.trim().isEmpty ? 'City is a required value ' : '';

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showTopSnackBarError(context, TransactionConstants.noConnectionError.tr);
      rxLoadedButton.value = LoadedType.finish;
      return;
    }

    if (phoneValidate.value.isEmpty &&
        firstNameValidate.value.isEmpty &&
        lastNameValidate.value.isEmpty &&
        cityValidate.value.isEmpty &&
        streetValidate.value.isEmpty) {
      if (editAddress != null) {
        (customer.addresses ?? [])
            .removeWhere((element) => element.id == editAddress?.id);
      }

      (customer.addresses ?? []).add(Addresses(
        customerId: customer.id,
        firstname: firstNameController.text.trim(),
        lastname: lastNameController.text.trim(),
        telephone: phoneController.text.trim(),
        city: cityController.text.trim(),
        street: [streetController.text.trim()],
        postcode: '000084',
        countryId: 'VN',
        defaultBilling: defaultBillingAddress.value,
        defaultShipping: defaultShippingAddress.value,
      ));

      final result = await accountUsecase.updateCustomer(
        customer: customer,
      );

      if (result != null) {
        debugPrint('cập nhật thành công');
        await _mainController.getUserProfile();
        showTopSnackBar(context,
            message: TransactionConstants.successfully.tr,
            type: SnackBarType.done);
        Get.back();
      }
    }

    rxLoadedButton.value = LoadedType.finish;
  }

  void onEditingCompleteCity() {
    cityHasFocus.value = false;
    FocusScope.of(context).unfocus();
    if (buttonEnable.value) {
      saveInfo();
    }
  }

  void onPressedSave() {
    phoneHasFocus.value = false;
    cityHasFocus.value = false;
    streetHasFocus.value = false;
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
    Map? args = Get.arguments;
    editAddress = args?['address'];
    debugPrint('============$editAddress');
    customer = _mainController.rxCustomer.value ?? CustomerModel();
  }

  @override
  void onReady() async {
    super.onReady();

    await getInitInfo();
  }

  Future<void> getInitInfo() async {
    if (editAddress != null) {
      firstNameController.text = editAddress?.firstname ?? '';
      lastNameController.text = editAddress?.lastname ?? '';
      phoneController.text = editAddress?.telephone ?? '';
      cityController.text = editAddress?.city ?? '';
      streetController.text = editAddress?.street?.first ?? '';
      defaultBillingAddress.value = editAddress?.defaultBilling ?? false;
      defaultShippingAddress.value = editAddress?.defaultShipping ?? false;
    }
  }
}
