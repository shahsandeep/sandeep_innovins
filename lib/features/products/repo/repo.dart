import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:innovins_task/core/api_config/api_config.dart';
import 'package:innovins_task/features/products/models/products_model.dart';

import '../../../core/common/models/failure.dart';
import '../../../core/endpoints/endpoints.dart';

class ProductRepo {
  final ApiConfig apiConfig;
  ProductRepo({
    required this.apiConfig,
  }) : _dio = apiConfig.dio;
  late final Dio _dio;

  Future<Either<Failure, ProductsModel>> getProducts() async {
    var formData = FormData.fromMap({
      'user_login_token': _dio.options.headers['X-API-Key'],
    });
    try {
      final res = await _dio.post(Endpoints.productList, data: formData);
      final products = ProductsModel.fromJson(res.data);

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
