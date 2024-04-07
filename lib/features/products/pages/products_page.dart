import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innovins_task/core/theme/app_pallete.dart';
import 'package:innovins_task/core/widgets/loader.dart';
import 'package:innovins_task/features/crud/widgets/crud_widget.dart';
import 'package:innovins_task/features/products/bloc/product_bloc.dart';
import 'package:innovins_task/features/products/repo/repo.dart';
import 'package:innovins_task/features/products/widget/drawer.dart';

import '../../../core/utils/toast.dart';
import '../../../core/widgets/custom_gradient_button.dart';

class ProductsPage extends StatefulWidget {
  static route(BuildContext context) => MaterialPageRoute(
        builder: (context) => const ProductsPage(),
      );
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final ProductBloc productBloc;
  @override
  void initState() {
    super.initState();
    productBloc = ProductBloc(productRepo: context.read<ProductRepo>());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => productBloc..add(GetProductList()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Products',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        drawer: const SideDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
          child: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductFailure) {
                flutterShowSnackbar(
                    context: context, content: state.failure.errorMessage);
              }
            },
            builder: (context, state) {
              if (state is ProductFailure &&
                  state.failure.errorMessage ==
                      'No products found in the database') {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'No Products Found! \nPlease add some Products.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    CustomGradientButton(
                      buttonText: 'Add Product',
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: BlocProvider<ProductBloc>.value(
                                value: productBloc,
                                child: const CrudWidget(
                                  title: 'Add Product',
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  if (state is ProductLoading) ...[
                    SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.6,
                        child: const Loader())
                  ],
                  if (state is ProductLoaded) ...[
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.6,
                      child: RefreshIndicator(
                        onRefresh: () {
                          return Future.delayed(
                                  const Duration(milliseconds: 600))
                              .then(
                                  (value) => productBloc.add(GetProductList()));
                        },
                        child: ListView.builder(
                            itemCount: state.productsModel.productModel?.length,
                            itemBuilder: (context, index) {
                              final data =
                                  state.productsModel.productModel![index];
                              return Card(
                                child: ListTile(
                                  title: Text(
                                    "Name: ${data.name!}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Moq: ${data.moq!}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Price:  ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              Text(
                                                data.price!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                data.price!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding:
                                                      MediaQuery.of(context)
                                                          .viewInsets,
                                                  child: BlocProvider<
                                                      ProductBloc>.value(
                                                    value: productBloc,
                                                    child: CrudWidget(
                                                      productModel: data,
                                                      title: 'Update Product',
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return BlocProvider<
                                                  ProductBloc>.value(
                                                value: productBloc,
                                                child: CrudWidget(
                                                  title: 'Product Delete',
                                                  isDelete: true,
                                                  productModel: data,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: AppPallete.errorColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    const Spacer(),
                    CustomGradientButton(
                      buttonText: 'Add Product',
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: BlocProvider<ProductBloc>.value(
                                value: productBloc,
                                child: const CrudWidget(
                                  title: 'Add Product',
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                  if (state is ProductFailure) ...[
                    Center(
                      child: Text(
                        'Error Occured!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: AppPallete.errorColor),
                      ),
                    ),
                  ]
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
