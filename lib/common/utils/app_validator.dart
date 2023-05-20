import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:magento_app/common/common_export.dart';

enum AppValidation {
  name,
  phoneNo,
  address,
  email,
  username,
  password,
  dateTime,
  amount,
  imageUpload,
  fileUpload,
  bankAccNo,
  creditCardNo,
  visaCardNo,
  dob,
}

final _pattern = <AppValidation, Pattern>{
  AppValidation.name:
      r'^[a-zA-Z0-9ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêếìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹý ]{1,255}$',
  AppValidation.phoneNo:
      r'(086|096|097|098|032|033|034|035|036|037|038|039|091|094|088|083|084|085|081|082|089|090|093|070|079|077|076|078|092|056|058|099|059)+([0-9]{7,12})\b',
  AppValidation.address: r'^((\\d,)?\\d,\\d,\\d,){3,255}$',
  AppValidation.email:
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  AppValidation.username: r'^([a-zA-Z0-9\.\-]{1,50})$',
  AppValidation.password:
      r'^(?=.*[A-Za-z])(?=.*?[0-9])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z0-9\d@$!%*#?&]{8,}$',
  //^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$
  AppValidation.dateTime:
      r'^(([0-9]{4}\-[0-9]{2}\-[0-9]{2}T[0-9]{2}\:[0-9]{2}\:[0-9]{2}Z))|(([0-9]{4}\-[0-9]{2}\-[0-9]{2}T[0-9]{2}\:[0-9]{2}\:[0-9]{2}\+[0-9]{2}\:[0-9]{2}))$',
  AppValidation.amount: r'^(?:\\d{1,3}(?:,\\d{3})*|\\d+)(?:.\\d+)?$',
  AppValidation.imageUpload: r'',
  AppValidation.fileUpload: r'',
  AppValidation.bankAccNo: r'^[0-9A-Za-z?]{5,16}$',
  AppValidation.creditCardNo: r'^(9704|6201) \d{4} \d{4} ?\d{0,4}$',
  AppValidation.visaCardNo: r'^4[0-9]{12}(?:[0-9]{3})?$',
  AppValidation.dob: r'^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$',
};

class AppValidator {
  static String error(String? value, AppValidation type, String illegal) {
    if (value == null || value.trim().isEmpty) {
      return '';
    }

    RegExp regExp = RegExp(_pattern[type] as String);
    if (regExp.hasMatch(value.replaceAll(RegExp(r"\s+"), ""))) {
      return '';
    }
    return illegal;
  }

  static String validateEmail(TextEditingController emailCtrl) {
    return error(
      emailCtrl.text.trim(),
      AppValidation.email,
      'Email is not a valid email address',
    );
  }

  static String validateDob(TextEditingController emailCtrl) {
    return error(
      emailCtrl.text.trim(),
      AppValidation.dob,
      'DOB is not a valid datetime',
    );
  }

  static String validatePhoneNumber(TextEditingController phoneCtrl) {
    String phone = phoneCtrl.text.replaceAll(' ', '');
    return error(
      phone,
      AppValidation.phoneNo,
      StringConstants.invalidPhone.tr,
    );
  }

  static String validatePassword(TextEditingController passwordCtrl) {
    return error(
      passwordCtrl.text.trim().replaceAll('.', ''),
      AppValidation.password,
      'A minimum 8 characters password contains a combination of letter, number and special character are required.',
    );
  }

  static String validateName(String typeName, TextEditingController nameCtrl) {
    debugPrint('====${nameCtrl.text}00');
    return error(
      nameCtrl.text.trim(),
      AppValidation.name,
      '$typeName is a required value',
    );
  }

  static String validateAccNumber(TextEditingController accNumberCtrl) {
    return error(
      accNumberCtrl.text.trim(),
      AppValidation.bankAccNo,
      'Số tài khoản không đúng định dạng',
    );
  }
}
