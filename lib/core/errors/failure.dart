import 'package:dio/dio.dart';

/// Abstract class for all kinds of failures.
abstract class Failure {
  final String errMessage;
  Failure({required this.errMessage});
}

/// Server failure class used for Dio errors.
class ServerFailure extends Failure {
  ServerFailure({required super.errMessage});

  /// Factory to create ServerFailure from DioException.
  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errMessage: 'The connection to the server timed out. Please try again later.',
        );

      case DioExceptionType.sendTimeout:
        return ServerFailure(
          errMessage: 'Sending data to the server timed out. Please try again later.',
        );

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          errMessage: 'Receiving data from the server timed out. Please try again later.',
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(
          errMessage: 'The server has a bad SSL certificate.',
        );

      case DioExceptionType.badResponse:
        if (e.response != null) {
          return ServerFailure.fromBadResponse(e.response!);
        } else {
          return ServerFailure(errMessage: 'Unexpected bad response from server.');
        }

      case DioExceptionType.cancel:
        return ServerFailure(
          errMessage: 'The request was cancelled before completing.',
        );

      case DioExceptionType.connectionError:
        return ServerFailure(
          errMessage: 'No internet connection. Please check your network.',
        );

      case DioExceptionType.unknown:
        return ServerFailure(
          errMessage: 'An unexpected error occurred. Please try again.',
        );
    }
  }

  /// Factory to create ServerFailure from response (bad status code).
  factory ServerFailure.fromBadResponse(Response response) {
    final statusCode = response.statusCode ?? 0;
    final dynamic data = response.data;

    if ([400, 401, 403].contains(statusCode)) {
      // Try to extract error message safely
      String message = 'Unauthorized request';
      if (data is Map && data.containsKey('error')) {
        message = data['error'].toString();
      }
      return ServerFailure(errMessage: message);
    } else if (statusCode == 404) {
      return ServerFailure(errMessage: 'The requested item was not found.');
    } else if (statusCode == 500) {
      return ServerFailure(errMessage: 'A server error occurred. Please try again later.');
    } else {
      return ServerFailure(errMessage: 'Something went wrong. Please try again.');
    }
  }
}
