part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final AccessToken? accessToken;
  final UserData? userData;

  AuthLoaded({
    required this.accessToken,
    required this.userData,
  });
}

class AuthError extends AuthState {
  final LoginResult loginResult;

  AuthError({required this.loginResult});
}
