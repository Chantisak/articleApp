import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shop/src/models/login_model.dart';

import '../models/article_model.dart';
import '../models/register_model.dart';

class NetService {
  NetService._internal();
  static final NetService _instance = NetService._internal();

  factory NetService() => _instance;
  static final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) async {
          requestOptions.connectTimeout = 5000;
          requestOptions.receiveTimeout = 5000;
          requestOptions.baseUrl = 'http://student.crru.ac.th/611413005/bn';

          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          return handler.next(response);
        },
        onError: (dioError, handler) async {
          return handler.next(dioError);
        },
      ),
    );

  Future<LoginModel> login(
    final String username,
    final String password,
  ) async {
    var formData = FormData.fromMap({
      'username': username,
      'password': password,
    });
    final response = await _dio.post(
      '/login/login.php',
      data: formData,
    );
    return loginModelFromJson(jsonEncode(response.data));
  }
  Future<RegisterModel> register(
    final String name,
    final String username,
    final String password,
  ) async {
    var formData = FormData.fromMap({
      'name': name,
      'username': username,
      'password': password,
    });
    final response = await _dio.post(
      '/login/singup.php',
      data: formData,
    );
    return registerModelFromJson(jsonEncode(response.data));
  }
  
  Future<List<ArticleModel>> getHotNew(
  ) async {
    final response = await _dio.post(
      '/article/get_his.php',
    );
    return articleModelFromJson(jsonEncode(response.data));
  }

  Future<List<ArticleModel>> getArticle(
  ) async {
    final response = await _dio.post(
      '/article/',
    );
    return articleModelFromJson(jsonEncode(response.data));
  }
}
