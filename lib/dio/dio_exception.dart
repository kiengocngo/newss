import 'package:dio/dio.dart';

class DioException implements Exception {
  late String errroMessage;
  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        errroMessage = 'err_cancel';
        break;
      case DioErrorType.connectTimeout:
        errroMessage = 'err_connect';
        break;
      case DioErrorType.receiveTimeout:
        errroMessage = 'err_receive';
        break;
      case DioErrorType.sendTimeout:
        errroMessage = 'err_send';
        break;
      case DioErrorType.response:
        errroMessage = _handleStatusCode(dioError.response?.statusCode);
        break;
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          errroMessage = 'err_internet';
          break;
        }
        errroMessage = 'err_other1';
        break;
      default:
        errroMessage = 'err_other2';
    }
  }
  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'err_400';
      case 401:
        return 'err_401';
      case 403:
        return 'err_403';
      case 404:
        return 'err_404';
      case 405:
        return 'err_405';
      case 415:
        return 'err_415';
      case 422:
        return 'err_422';
      case 429:
        return 'err_429';
      case 500:
        return 'err_500';
      default:
        return 'err_other3';
    }
  }

  @override
  String toString() => errroMessage;
}
