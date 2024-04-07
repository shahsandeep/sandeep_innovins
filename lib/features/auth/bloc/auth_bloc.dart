import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innovins_task/core/utils/shared_pref.dart';
import 'package:innovins_task/features/auth/models/user_registration_model.dart';

import 'package:innovins_task/features/auth/repo/auth_repo.dart';

part './auth_event.dart';
part './auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo repo;
  AuthBloc(
    this.repo,
  ) : super(AuthStateInitial()) {
    on<AuthEvent>(_onAuthEvent);
    on<SignUpWithEmailPasswordEvent>(_onUserSignUp);
    on<LoginWithEmailPasswordEvent>(_onUserLogin);
    on<CheckUserLoggedInEvent>(_onCheckUserLogin);
  }

  FutureOr<void> _onUserSignUp(
      SignUpWithEmailPasswordEvent event, Emitter<AuthState> emit) async {
    await repo
        .signUpWithEmailPassword(
      name: event.name,
      email: event.email,
      password: event.password,
      number: event.mobile,
    )
        .then((userResponse) {
      userResponse.fold(
          (failure) => emit(AuthStateFailure(failure.errorMessage)),
          (userResponse) =>
              emit(AuthStateLoaded(userRegisterModel: userResponse)));
    });
  }

  FutureOr<void> _onUserLogin(
      LoginWithEmailPasswordEvent event, Emitter<AuthState> emit) async {
    await repo
        .signInWithEmailPassword(
      email: event.email,
      password: event.password,
    )
        .then((userResponse) {
      userResponse.fold(
          (failure) => emit(AuthStateFailure(failure.errorMessage)),
          (userResponse) =>
              emit(AuthStateLoaded(userRegisterModel: userResponse)));
    });
  }

  FutureOr<void> _onCheckUserLogin(
      CheckUserLoggedInEvent event, Emitter<AuthState> emit) async {
    await SharedPref.getStringPreference(SharedPref.token).then((value) {
      if (value.isNotEmpty) {
        repo.apiConfig.setAuthToken(value);
        emit(UserIsLoggedIn());
      } else {
        emit(UserIsNotLoggedIn());
      }
    });
  }
}

FutureOr<void> _onAuthEvent(AuthEvent event, Emitter<AuthState> emit) {
  emit(AuthStateLoading());
}
