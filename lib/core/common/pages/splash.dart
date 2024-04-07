import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:innovins_task/core/widgets/loader.dart';
import 'package:innovins_task/features/auth/bloc/auth_bloc.dart';
import 'package:innovins_task/features/auth/pages/login_page.dart';
import 'package:innovins_task/features/products/pages/products_page.dart';

class SplashPage extends StatelessWidget {
  static(BuildContext context) => MaterialPageRoute(
        builder: (context) => const SplashPage(),
      );
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/innovinslogo.png'),
              const SizedBox(
                height: 20,
              ),
              const Loader(),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Loading Please Wait...',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Made By Sandeep Shah',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.grey),
              ),
            ],
          )),
        );
      },
      listener: (context, state) async {
        if (state is UserIsLoggedIn) {
          Future.delayed(const Duration(seconds: 1)).then((value) =>
              Navigator.pushAndRemoveUntil(
                  context, ProductsPage.route(context), (route) => false));
        } else if (state is UserIsNotLoggedIn) {
          Future.delayed(const Duration(seconds: 1)).then((value) =>
              Navigator.pushAndRemoveUntil(
                  context, LoginPage.route(context), (route) => false));
        }
      },
    );
  }
}
