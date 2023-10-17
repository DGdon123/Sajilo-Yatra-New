import 'package:dio/dio.dart';

class DioException1 implements Exception {
  DioException1.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.unknown:
        message = "Connection failed due to internet connection";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
            dioError.response!.statusCode!, dioError.response!.data);
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String? message;

  String _handleError(
    int statuscode,
    dynamic error,
  ) {
    switch (statuscode) {
      case 400:
        return error["message"] ??
            error["success"] ??
            error["email"] ??
            error["error"] ??
            "error" ??
            "Error";
      case 401:
        return error["message"] ?? "error";
      case 404:
        return error["message"] ?? error["error"] ?? "Not found";
      case 406:
        return error["message"] ?? error["error"] ?? "Error";
      case 422:
        return error["message"] ?? error["error"] ?? "Error";

      case 500:
        return "Internal server error";
      default:
        return "Something went wrong";
    }
  }
}
