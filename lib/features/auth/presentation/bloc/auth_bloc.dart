import 'dart:developer';

import 'package:authentication_bloc_firebase_2/core/errors/failure.dart';
import 'package:authentication_bloc_firebase_2/features/auth/domain/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SignUpWithEmailEvent>((event, emit) async {
      emit(AuthLoading());
      Either<Failure, User> result = await authRepository.signUp(
        event.email,
        event.password,
      );
      result.fold((failure) {
        emit(AuthError(message: failure.message));
        emit(ShowSnackBar(message: failure.message)); // UI effect
      }, (user) => emit(Authenticated(user: user)));
    });
    on<SignInWithEmailEvent>((event, emit) async {
      log("no error");
      emit(AuthLoading());
      Either<Failure, User> result = await authRepository.signIn(
        event.email,
        event.password,
      );
      result.fold((failure) {
        emit(AuthError(message: failure.message));
        emit(ShowSnackBar(message: failure.message)); // UI effect
      }, (user) => emit(Authenticated(user: user)));
    });
    on<SignOutEvent>((event, emit) async {
      Either<Failure, String> result = await authRepository.signOut();
      result.fold((failure) {
        emit(AuthError(message: failure.message));
        // emit(ShowSnackBar(message: failure.message)); // UI effect
        emit(AuthInitial());
      }, (success) => emit(Unauthenticated()));
    });
    on<SignInWithGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      Either<Failure, User> result = await authRepository.signInWithGoogle();
      result.fold((failure) {
        emit(AuthError(message: failure.message));
        emit(ShowSnackBar(message: failure.message)); // UI effect
      }, (user) => emit(Authenticated(user: user)));
    });
  }
}

//SIGN IN
// try {
//   final user = await signInWithGoogle();
//   emit(Authenticated(user: user));
// } catch (e) {
//   log("Error signing in with Google: $e");
//   emit(Unauthenticated());
// }
//SIGN OUT
// try {
//   await signOut();
//   // Navigate to the next screen or show a success message
// } catch (e) {
//   log("Error signing out: $e");
// }
