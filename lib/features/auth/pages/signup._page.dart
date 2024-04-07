import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:innovins_task/features/products/pages/products_page.dart';

import '../../../core/theme/app_pallete.dart';
import '../../../core/utils/toast.dart';

import '../bloc/auth_bloc.dart';
import '../../../core/widgets/custom_field.dart';
import '../../../core/widgets/custom_gradient_button.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  static route(BuildContext context) => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthStateFailure) {
              flutterShowSnackbar(
                  context: context, content: state.errorMessage);
            }
            if (state is AuthStateLoaded) {
              Navigator.pushAndRemoveUntil(
                  context, ProductsPage.route(context), (route) => false);
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      hintText: 'Name',
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      hintText: 'Mobile',
                      controller: numberController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      hintText: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      hintText: 'Password',
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomGradientButton(
                        isLoading: (state is AuthStateLoading),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  SignUpWithEmailPasswordEvent(
                                      name: nameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      mobile: numberController.text.trim()),
                                );
                          }
                        },
                        buttonText: 'Sign Up'),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          LoginPage.route(context),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account?',
                          style: Theme.of(context).textTheme.titleSmall,
                          children: [
                            TextSpan(
                              text: ' Sign In',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
