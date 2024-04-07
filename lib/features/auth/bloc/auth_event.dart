part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthEventInitial extends AuthEvent {}

class SignUpWithEmailPasswordEvent extends AuthEvent {
  final String name;
  final String email;
  final String mobile;
  final String password;
  SignUpWithEmailPasswordEvent({
    required this.mobile,
    required this.name,
    required this.email,
    required this.password,
  });
}

class LoginWithEmailPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  LoginWithEmailPasswordEvent({
    required this.email,
    required this.password,
  });
}

class CheckUserLoggedInEvent extends AuthEvent {}
