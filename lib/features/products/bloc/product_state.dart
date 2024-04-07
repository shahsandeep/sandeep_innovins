part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final ProductsModel productsModel;
  ProductLoaded({
    required this.productsModel,
  });
}

final class ProductFailure extends ProductState {
  final Failure failure;

  ProductFailure(this.failure);
}
