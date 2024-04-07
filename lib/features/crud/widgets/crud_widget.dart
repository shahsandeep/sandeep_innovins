import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innovins_task/core/theme/app_pallete.dart';
import 'package:innovins_task/features/crud/bloc/product_crud_bloc.dart';
import 'package:innovins_task/features/crud/repo/repo.dart';
import 'package:innovins_task/features/products/bloc/product_bloc.dart';
import 'package:innovins_task/features/products/models/products_model.dart';

import '../../../core/utils/toast.dart';
import '../../../core/widgets/custom_field.dart';
import '../../../core/widgets/custom_gradient_button.dart';

class CrudWidget extends StatefulWidget {
  final String title;
  final bool isDelete;
  final ProductModel? productModel;

  const CrudWidget(
      {super.key,
      required this.title,
      this.productModel,
      this.isDelete = false});

  @override
  State<CrudWidget> createState() => _CrudWidgetState();
}

class _CrudWidgetState extends State<CrudWidget> {
  late final ProductCrudBloc productCrudBloc;
  final TextEditingController nameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController discountedPriceController =
      TextEditingController();

  final TextEditingController moqController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    productCrudBloc = ProductCrudBloc(crudRepo: context.read<CrudRepo>());
    if (widget.productModel != null) {
      nameController.text = widget.productModel!.name!;
      moqController.text = widget.productModel!.moq!;
      priceController.text = widget.productModel!.price!;
      discountedPriceController.text = widget.productModel!.discountedPrice!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => productCrudBloc,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<ProductCrudBloc, ProductCrudState>(
            listener: (context, state) {
              if (state is ProductCrudSuccess) {
                flutterShowSnackbar(
                    context: context, content: state.crudModel.messge);
                BlocProvider.of<ProductBloc>(context).add(GetProductList());
                Navigator.of(context).pop();
              } else if (state is ProductCrudFailure) {
                flutterShowSnackbar(
                    context: context, content: state.failure.errorMessage);
              }
            },
            builder: (context, state) {
              if (!widget.isDelete) {
                return Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: 'Product name',
                          controller: nameController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          hintText: 'Moq',
                          controller: moqController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          hintText: 'Price',
                          controller: priceController,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          hintText: 'Discounted price',
                          controller: discountedPriceController,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomGradientButton(
                          isLoading: (state is ProductCrudLoading),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (widget.title == 'Update Product') {
                                productCrudBloc.add(
                                  UpdateProduct(
                                    product: ProductModel(
                                      id: widget.productModel!.id,
                                      discountedPrice:
                                          discountedPriceController.text,
                                      moq: moqController.text,
                                      name: nameController.text,
                                      price: priceController.text,
                                    ),
                                  ),
                                );
                              } else if (widget.title == 'Add Product') {
                                productCrudBloc.add(AddProduct(
                                  product: ProductModel(
                                    discountedPrice:
                                        discountedPriceController.text,
                                    moq: moqController.text,
                                    name: nameController.text,
                                    price: priceController.text,
                                  ),
                                ));
                              }
                              // context.read<AuthBloc>().add(
                              //       SignUpWithEmailPasswordEvent(
                              //           name: nameController.text.trim(),
                              //           email: emailController.text.trim(),
                              //           password: passwordController.text.trim(),
                              //           mobile: numberController.text.trim()),
                              //     );
                            }
                          },
                          buttonText: widget.title,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return AlertDialog(
                  title: Text(
                    'Are you sure want to delete this product?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {}, child: const Text('No')),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppPallete.errorColor,
                            ),
                            onPressed: () {
                              productCrudBloc.add(
                                  DeleteProduct(product: widget.productModel!));
                            },
                            child: const Text('Yes',
                                style: TextStyle(color: AppPallete.whiteColor)))
                      ],
                    )
                  ],
                );
              }
            },
          ),
        ));
  }
}
