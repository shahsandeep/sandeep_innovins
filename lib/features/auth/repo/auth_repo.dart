import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:innovins_task/core/api_config/api_config.dart';
import 'package:innovins_task/core/common/models/failure.dart';
import 'package:innovins_task/core/endpoints/endpoints.dart';
import 'package:innovins_task/features/auth/models/user_registration_model.dart';

import '../../../core/utils/shared_pref.dart';

class AuthRepo {
  final ApiConfig apiConfig;
  AuthRepo({
    required this.apiConfig,
  }) : _dio = apiConfig.dio;
  late final Dio _dio;
  Future<Either<Failure, UserRegisterModel>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password,
      required String number}) async {
    var formData = FormData.fromMap(
        {'name': name, 'email': email, 'mobile': number, 'password': password});
    try {
      final res = await _dio.post(Endpoints.register, data: formData);
      final userData = UserRegisterModel.fromJson(res.data);

      await SharedPref.setStringPreference(
          SharedPref.token, userData.data!.userToken!);
      apiConfig.setAuthToken(userData.data!.userToken!);
      return right(userData);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return left(Failure(errorMessage: e.response!.data['message']));
      }
      return left(Failure());
    }
  }

  Future<Either<Failure, UserRegisterModel>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    var formData = FormData.fromMap({'email': email, 'password': password});
    try {
      final res = await _dio.post(Endpoints.login, data: formData);
      final userData = UserRegisterModel.fromJson(res.data);

      await SharedPref.setStringPreference(
          SharedPref.token, userData.data!.userToken!);
      apiConfig.setAuthToken(userData.data!.userToken!);
      return right(userData);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return left(Failure(errorMessage: e.response!.data['message']));
      }
      return left(Failure());
    } catch (e) {
      return left(Failure());
    }
  }
}
