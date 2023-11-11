import 'dart:convert';

import 'package:assignment10/core/api.dart';
import 'package:assignment10/data/models/user/user_model.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final _api = Api();
  Future<UserModel> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _api.sendRequest.post('/user/createAccount',
          data: jsonEncode({
            'email': email,
            'password': password,
          }));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      //convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _api.sendRequest.post('/user/signIn',
          data: jsonEncode({
            'email': email,
            'password': password,
          }));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      //convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    } catch (error) {
      rethrow;
    }
  }
}
