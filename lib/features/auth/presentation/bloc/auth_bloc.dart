import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:soundspace/core/common/entities/user.dart';
import 'package:soundspace/features/auth/domain/entities/email.dart';
import 'package:soundspace/features/auth/domain/usecases/user_email_validation.dart';
import 'package:soundspace/features/auth/domain/usecases/user_login.dart';
import 'package:soundspace/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final Userlogin _userlogin;
  final UserEmailValidation _userEmailValidation;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required Userlogin userlogin,
    required UserEmailValidation userEmailValidation,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userlogin = userlogin,
        _userEmailValidation = userEmailValidation,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthEmailValidation>(_onAuthEmailValidation);
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
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
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userlogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthEmailValidation(
    AuthEmailValidation event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userEmailValidation(
      UserEmailValidationParams(
        email: event.email,
      ),
    );

    res.fold(
      (failure) {
        print(failure.message);
        emit(AuthFailure(failure.message));
      },
      (email) {
        print(email);
        emit(EmailSuccess(email));
      },
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
