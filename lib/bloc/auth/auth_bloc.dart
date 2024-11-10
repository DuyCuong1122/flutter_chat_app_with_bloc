import 'dart:developer';

import 'package:chat_app/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final AppLocalizations? appLocalizations;

  AuthBloc({
    required this.authRepository,
    this.appLocalizations,
  }) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckStatus>(_onCheckStatus);
    on<AuthSignUpRequested>(_onSignUpRequested);
  }

  Future<void> _onSignUpRequested(
      AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.createUser(event.email, event.password);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      log(e.toString());
      emit(AuthFailure(appLocalizations!.failedSignUp));
    }
  }

  Future<void> _onLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user =
          await authRepository.signInWithEmail(event.email, event.password);
      if (user != null) {
        // await _saveUserToLocal(user); // Save to local storage
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      log(e.toString());
      emit(AuthFailure(appLocalizations!.failedSignIn));
    }
  }

  Future<void> _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await authRepository.signOut();
    // await _clearLocalUser(); // Clear local storage
    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckStatus(
      AuthCheckStatus event, Emitter<AuthState> emit) async {
    final user = authRepository.currentUser;
    if (user != null) {
      // await _saveUserToLocal(user);
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  // Future<void> _saveUserToLocal(User user) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('userId', user.uid);
  //   await prefs.setString('email', user.email ?? '');
  // }

  // Future<void> _clearLocalUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('userId');
  //   await prefs.remove('email');
  // }
}
