import 'package:clean_arch_prac/core/errors/error_model.dart';
import 'package:dio/dio.dart';

//!ServerException
class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException(this.errorModel);
}
//!CacheExeption
class CacheExeption implements Exception {
  final String errorMessage;
  CacheExeption({required this.errorMessage});
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  BadResponseException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  ReceiveTimeoutException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  ConnectionErrorException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  SendTimeoutException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class CofficientException extends ServerException {
  CofficientException(super.errorModel);
}

class CancelException extends ServerException {
  CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(
          ErrorModel(errorMessage: e.message ?? 'Connection Error', status: 500));
    case DioExceptionType.badCertificate:
      throw BadCertificateException(
          ErrorModel(errorMessage: e.message ?? 'Bad Certificate', status: 500));
    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(
          ErrorModel(errorMessage: e.message ?? 'Connection Timeout', status: 408));

    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(
          ErrorModel(errorMessage: e.message ?? 'Receive Timeout', status: 408));

    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(
          ErrorModel(errorMessage: e.message ?? 'Send Timeout', status: 408));

    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw BadResponseException(
              ErrorModel(errorMessage: 'Bad Request', status: 400));

        case 401: //unauthorized
          throw UnauthorizedException(
              ErrorModel(errorMessage: 'Unauthorized', status: 401));

        case 403: //forbidden
          throw ForbiddenException(
              ErrorModel(errorMessage: 'Forbidden', status: 403));

        case 404: //not found
          throw NotFoundException(
              ErrorModel(errorMessage: 'Not Found', status: 404));

        case 409: //conflict
          throw CofficientException(
              ErrorModel(errorMessage: 'Conflict', status: 409));

        case 504: // Gateway timeout
          throw BadResponseException(
              ErrorModel(status: 504, errorMessage: 'Gateway Timeout'));
        default:
          throw BadResponseException(
              ErrorModel(errorMessage: 'Bad Response', status: e.response?.statusCode ?? 500));
      }

    case DioExceptionType.cancel:
      throw CancelException(
          ErrorModel(errorMessage: 'Request Cancelled', status: 500));

    case DioExceptionType.unknown:
      throw UnknownException(
          ErrorModel(errorMessage: e.message ?? 'Unknown Error', status: 500));
  }
}