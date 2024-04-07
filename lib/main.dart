import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innovins_task/core/api_config/api_config.dart';
import 'package:innovins_task/core/common/pages/splash.dart';
import 'package:innovins_task/features/auth/bloc/auth_bloc.dart';

import 'package:innovins_task/features/auth/repo/auth_repo.dart';
import 'package:innovins_task/features/crud/repo/repo.dart';
import 'package:innovins_task/features/products/repo/repo.dart';

import 'core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ApiConfig apiConfig = ApiConfig();
  @override
  void initState() {
    super.initState();
    apiConfig.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepo(apiConfig: apiConfig),
        ),
        RepositoryProvider(
          create: (context) => ProductRepo(apiConfig: apiConfig),
        ),
        RepositoryProvider(
          create: (context) => CrudRepo(apiConfig: apiConfig),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepo>())
              ..add(CheckUserLoggedInEvent()),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Innovins Task',
          theme: AppTheme.getFlexTheme(),
          home: const SplashPage(),
        ),
      ),
    );
  }
}
