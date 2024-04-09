import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/features/auth/domain/entities/user.dart';
import 'package:soundspace/features/auth/domain/usecases/user_email_check.dart';
import 'package:soundspace/features/auth/domain/usecases/user_login.dart';
import 'package:soundspace/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final Userlogin _userlogin;
  final UserEmailCheck _userEmailCheck;
  AuthBloc({
    required UserSignUp userSignUp,
    required Userlogin userlogin,
    required UserEmailCheck userEmailCheck,
  })  : _userSignUp = userSignUp,
        _userlogin = userlogin,
        _userEmailCheck = userEmailCheck,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthEmailCheck>(_onAuthEmailCheck);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        displayName: event.displayName,
        age: event.age,
        gender: event.gender,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userlogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthEmailCheck(AuthEmailCheck event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userEmailCheck(
      UserEmailCheckParams(
        email: event.email,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
