import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  Failure({required this.errMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errMessage});

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
            errMessage: 'The connection to server timed out, please try later');
      case DioExceptionType.sendTimeout:
        return ServerFailure(
            errMessage: 'The connection to server timed out, please try later');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
            errMessage: 'Receiving data from server timed out, please try later');
      case DioExceptionType.badCertificate:
        return ServerFailure(errMessage: 'Bad certificate from server');
      case DioExceptionType.badResponse:
        if (e.response != null) {
          return ServerFailure.fromBadResponse(e.response!);
        } else {
          return ServerFailure(errMessage: 'Unexpected server error');
        }
      case DioExceptionType.cancel:
        return ServerFailure(errMessage: 'Request was cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure(errMessage: 'No internet connection');
      case DioExceptionType.unknown:
      default:
        return ServerFailure(errMessage: 'Unexpected error, please try again');
    }
  }

  factory ServerFailure.fromBadResponse(Response response) {
    final statusCode = response.statusCode ?? 0;

    if ([400, 401, 403].contains(statusCode)) {
      final errorMsg = response.data['error'] ?? 'Unauthorized request';
      return ServerFailure(errMessage: errorMsg);
    } else if (statusCode == 404) {
      return ServerFailure(errMessage: 'The requested item was not found.');
    } else if (statusCode == 500) {
      return ServerFailure(
          errMessage: 'Server error. Please try again later.');
    } else {
      return ServerFailure(
          errMessage: 'Something went wrong. Please try again.');
    }
  }
}
