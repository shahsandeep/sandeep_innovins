import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:innovins_task/core/common/models/failure.dart';
import 'package:innovins_task/features/crud/models/crud_model.dart';
import 'package:innovins_task/features/crud/repo/repo.dart';

import '../../products/models/products_model.dart';

part 'product_crud_event.dart';
part 'product_crud_state.dart';

class ProductCrudBloc extends Bloc<ProductCrudEvent, ProductCrudState> {
  final CrudRepo crudRepo;
  ProductCrudBloc({required this.crudRepo}) : super(ProductCrudInitial()) {
    on<ProductCrudEvent>(_onProductCrudEvent);
    on<AddProduct>(_onProductAddEvent);
    on<UpdateProduct>(_onProductUpdateEvent);
    on<DeleteProduct>(_onProductDeleteEvent);
  }

  FutureOr<void> _onProductCrudEvent(
      ProductCrudEvent event, Emitter<ProductCrudState> emit) async {
    emit(ProductCrudLoading());
  }

  FutureOr<void> _onProductAddEvent(
      AddProduct event, Emitter<ProductCrudState> emit) async {
    await crudRepo.addProducts(event.product).then((productResp) {
      productResp.fold((failure) => emit(ProductCrudFailure(failure: failure)),
          (success) => emit(ProductCrudSuccess(crudModel: success)));
    });
  }

  FutureOr<void> _onProductUpdateEvent(
      UpdateProduct event, Emitter<ProductCrudState> emit) async {
    await crudRepo.updateProducts(event.product).then((productResp) {
      productResp.fold((failure) => emit(ProductCrudFailure(failure: failure)),
          (success) => emit(ProductCrudSuccess(crudModel: success)));
    });
  }

  FutureOr<void> _onProductDeleteEvent(
      DeleteProduct event, Emitter<ProductCrudState> emit) async {
    await crudRepo.deleteProducts(event.product).then((productResp) {
      productResp.fold((failure) => emit(ProductCrudFailure(failure: failure)),
          (success) => emit(ProductCrudSuccess(crudModel: success)));
    });
  }
}
