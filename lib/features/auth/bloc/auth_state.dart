part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthStateInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateLoaded extends AuthState {
  final UserRegisterModel userRegisterModel;
  AuthStateLoaded({
    required this.userRegisterModel,
  });
}

class AuthStateFailure extends AuthState {
  final String errorMessage;

  AuthStateFailure(this.errorMessage);
}

class UserIsLoggedIn extends AuthState {}

class UserIsNotLoggedIn extends AuthState {}
