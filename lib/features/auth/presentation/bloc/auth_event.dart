part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;

  AuthSignUp({
    required this.email,
    required this.password,
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

final class AuthEmailValidation extends AuthEvent {
  final String email;

  AuthEmailValidation({
    required this.email,
  });
}

final class AuthCreateProfile extends AuthEvent {
  final String displayName;
  final int age;
  final String gender;

  AuthCreateProfile({
    required this.displayName,
    required this.age,
    required this.gender,
  });
}

final class AuthIsUserLoggedIn extends AuthEvent {}
