import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:innovins_task/core/api_config/api_config.dart';
import 'package:innovins_task/features/crud/models/crud_model.dart';
import 'package:innovins_task/features/products/models/products_model.dart';

import '../../../core/common/models/failure.dart';
import '../../../core/endpoints/endpoints.dart';

class CrudRepo {
  final ApiConfig apiConfig;

  CrudRepo({required this.apiConfig}) : _dio = apiConfig.dio;

  late final Dio _dio;
  Future<Either<Failure, CrudModel>> addProducts(
      ProductModel productModel) async {
    var formData = FormData.fromMap({
      'user_login_token': _dio.options.headers['X-API-Key'],
      'name': productModel.name,
      'moq': productModel.moq,
      'price': productModel.price,
      'discounted_price': productModel.discountedPrice,
    });
    try {
      final res = await _dio.post(Endpoints.addProduct, data: formData);
      final products = CrudModel.fromJson(res.data);

      return right(products);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return left(Failure(errorMessage: e.response!.data['message']));
      }
      return left(Failure());
    } catch (e) {
      return left(Failure());
    }
  }

  Future<Either<Failure, CrudModel>> updateProducts(
      ProductModel productModel) async {
    var formData = FormData.fromMap({
      'user_login_token': _dio.options.headers['X-API-Key'],
      'id': productModel.id,
      'name': productModel.name,
      'moq': productModel.moq,
      'price': productModel.price,
      'discounted_price': productModel.discountedPrice,
    });
    try {
      final res = await _dio.post(Endpoints.editProduct, data: formData);
      final products = CrudModel.fromJson(res.data);

      return right(products);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return left(Failure(errorMessage: e.response!.data['message']));
      }
      return left(Failure());
    } catch (e) {
      return left(Failure());
    }
  }

  Future<Either<Failure, CrudModel>> deleteProducts(
      ProductModel productModel) async {
    var formData = FormData.fromMap({
      'user_login_token': _dio.options.headers['X-API-Key'],
      'id': productModel.id,
    });
    try {
      final res = await _dio.post(Endpoints.deleteProduct, data: formData);
      final products = CrudModel.fromJson(res.data);

      return right(products);
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
