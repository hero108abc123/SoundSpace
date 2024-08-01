part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);
}

final class ProfileFailure extends AuthState {
  final String message;
  const ProfileFailure(this.message);
}

final class ProfileSuccess extends AuthState {
  final Profile profile;
  const ProfileSuccess(this.profile);
}

final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}

final class AccountFailure extends AuthState {
  final String message;
  const AccountFailure(this.message);
}

final class AccountSuccess extends AuthState {
  final String message;
  const AccountSuccess(this.message);
}

final class EmailFailure extends AuthState {
  final String message;
  const EmailFailure(this.message);
}

final class EmailSuccess extends AuthState {
  final String email;
  const EmailSuccess(this.email);
}
