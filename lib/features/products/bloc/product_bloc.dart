import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innovins_task/core/common/models/failure.dart';
import 'package:innovins_task/features/products/models/products_model.dart';
import 'package:innovins_task/features/products/repo/repo.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;
  ProductBloc({required this.productRepo}) : super(ProductInitial()) {
    on<ProductEvent>(_onProductEvent);
    on<GetProductList>(_onGetProductListEvent);
  }

  void _onProductEvent(
    ProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
  }

  void _onGetProductListEvent(
    ProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    await productRepo.getProducts().then((productResponse) {
      productResponse.fold(
        (failure) => emit(ProductFailure(failure)),
        (products) => emit(
          ProductLoaded(productsModel: products),
        ),
      );
    });
  }
}
