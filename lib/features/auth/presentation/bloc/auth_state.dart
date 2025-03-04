part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  Authenticated({required this.user});
}

class Unauthenticated extends AuthState {}

class AuthActionState extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}

class NavigateToSignUp extends AuthActionState {}

class NavigateToLogin extends AuthActionState {}

class AuthErrorBuilder extends AuthState {
  final String message;

  AuthErrorBuilder({required this.message});
}

class ShowSnackBar extends AuthActionState {
  final String message;

  ShowSnackBar({required this.message});
}
