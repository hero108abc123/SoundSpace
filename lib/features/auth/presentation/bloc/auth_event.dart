part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String displayName;
  final int age;
  final String? gender;

  AuthSignUp({
    required this.email,
    required this.password,
    required this.displayName,
    required this.age,
    required this.gender,
  });
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({
    required this.email,
    required this.password,
  });
}

final class AuthEmailCheck extends AuthEvent {
  final String email;

  AuthEmailCheck({
    required this.email,
  });
}
