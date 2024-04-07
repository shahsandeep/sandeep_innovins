part of 'product_crud_bloc.dart';

abstract class ProductCrudEvent {}

class UpdateProduct extends ProductCrudEvent {
  final ProductModel product;
  UpdateProduct({
    required this.product,
  });
}

class AddProduct extends ProductCrudEvent {
  final ProductModel product;
  AddProduct({
    required this.product,
  });
}

class DeleteProduct extends ProductCrudEvent {
  final ProductModel product;
  DeleteProduct({
    required this.product,
  });
}
