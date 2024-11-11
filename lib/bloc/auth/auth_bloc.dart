import 'dart:developer';

import 'package:chat_app/common/models/user.dart';
import 'package:chat_app/common/services/shared_preference_service.dart';
import 'package:chat_app/common/values/storage.dart';
import 'package:chat_app/repository/auth_repository.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final AppLocalizations? appLocalizations;
  final UserRepository userRepository = UserRepository();
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
        await user.sendEmailVerification();
        userRepository.addUser(event.email, event.name);
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
        final userData = await userRepository.getUserByEmail(user.email!);
        if (userData != null) {
          await SharedPreferencesService().setUserValue(
            userData.name ?? "",
            userData.phoneNumber ?? "",
            userData.dateOfBirth,
            id: userData.id ?? '',
            email :userData.email ?? '',
          );
        }
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth Error: ${e.code} - ${e.message}');
      String errorMessage;

      switch (e.code) {
        case 'user-not-found':
          errorMessage = appLocalizations?.userNotFound ?? 'User not found';
          break;
        case 'wrong-password':
          errorMessage =
              appLocalizations?.wrongPassword ?? 'Incorrect password';
          break;

        default:
          errorMessage = appLocalizations?.failedSignIn ??
              'Sign-in failed. Please try again.';
      }

      emit(AuthFailure(errorMessage));
    } catch (e) {
      log('Login Error: $e');
      emit(AuthFailure(appLocalizations?.failedSignIn ??
          'Sign-in failed. Please try again.'));
    }
  }

  Future<void> _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    SharedPreferencesService().clear();
    await authRepository.signOut();

    // await _clearLocalUser(); // Clear local storage
    emit(AuthLogout());
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
