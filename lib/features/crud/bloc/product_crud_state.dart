part of 'product_crud_bloc.dart';

abstract class ProductCrudState {}

class ProductCrudInitial extends ProductCrudState {}

class ProductCrudLoading extends ProductCrudState {}

class ProductCrudSuccess extends ProductCrudState {
  final CrudModel crudModel;
  ProductCrudSuccess({
    required this.crudModel,
  });
}

class ProductCrudFailure extends ProductCrudState {
  final Failure failure;
  ProductCrudFailure({
    required this.failure,
  });
}
