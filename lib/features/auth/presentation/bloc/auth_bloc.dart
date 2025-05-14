import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:soundspace/core/common/entities/user.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/auth/domain/usecases/current_user.dart';
import 'package:soundspace/features/auth/domain/usecases/user_email_validation.dart';
import 'package:soundspace/features/auth/domain/usecases/user_login.dart';
import 'package:soundspace/features/auth/domain/usecases/user_profile.dart';
import 'package:soundspace/features/auth/domain/usecases/user_sign_up.dart';

import '../../../../core/common/entities/user_profile.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserProfile _userProfile;
  final UserSignUp _userSignUp;
  final Userlogin _userlogin;
  final UserEmailValidation _userEmailValidation;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserProfile userProfile,
    required Userlogin userlogin,
    required UserEmailValidation userEmailValidation,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userProfile = userProfile,
        _userSignUp = userSignUp,
        _userlogin = userlogin,
        _userEmailValidation = userEmailValidation,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthCreateProfile>(_onAuthCreateProfile);
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthEmailValidation>(_onAuthEmailValidation);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<UserLoggedOut>(_onUserLoggedOut);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (profile) => _emitAuthSuccess(profile, emit),
    );
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (failure) => emit(AccountFailure(failure.message)),
      (status) => emit(AccountSuccess(status)),
    );
  }

  void _onAuthCreateProfile(
    AuthCreateProfile event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userProfile(
      UserProfileParams(
        displayName: event.displayName,
        age: event.age,
        gender: event.gender,
      ),
    );

    res.fold(
      (failure) => emit(AccountFailure(failure.message)),
      (status) => emit(AccountSuccess(status)),
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
      (user) => emit(AuthSuccess(user)),
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
      (failure) => emit(EmailFailure(failure.message)),
      (email) => emit(EmailSuccess(email)),
    );
  }

  void _emitAuthSuccess(
    Profile profile,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(profile);
    emit(ProfileSuccess(profile));
  }

  void _onUserLoggedOut(UserLoggedOut event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
