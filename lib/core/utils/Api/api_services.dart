
import 'package:bookly_app/core/utils/constants/app_constants.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  final baseUrl = AppConstants.baseUrl;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await _dio.get('$baseUrl$endPoint');
    return response.data;
  }
}