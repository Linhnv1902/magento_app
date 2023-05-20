import 'package:magento_app/common/utils/logger.dart';

abstract class APIErrors implements Exception {
  final dynamic code;
  final dynamic message;
  final dynamic success;

  APIErrors({
    this.code,
    this.message,
    this.success,
  }) {
    logger.e(
      success,
      '[$code] $message',
    );
  }

  @override
  String toString() {
    return '[$code]: $message \n $success';
  }
}

class FetchDataError extends APIErrors {
  FetchDataError({super.message, super.code, super.success});
}

class BadRequestError extends APIErrors {
  BadRequestError({super.message, super.code, super.success});
}

class NotFoundError extends APIErrors {
  NotFoundError({super.message, super.code, super.success});
}

class UnauthorizedError extends APIErrors {
  UnauthorizedError({super.message, super.code, super.success});
}

class InvalidInputError extends APIErrors {
  InvalidInputError({super.message, super.code, super.success});
}

class InternalServerError extends APIErrors {
  InternalServerError({super.message, super.code, super.success});
}

class TimeOutError extends APIErrors {
  TimeOutError({super.message, super.code, super.success});
}

class WrongPasswordError extends APIErrors {
  WrongPasswordError({super.message, super.code, super.success});
}
