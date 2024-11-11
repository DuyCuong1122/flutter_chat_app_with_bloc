import 'package:chat_app/bloc/user/user_event.dart';
import 'package:chat_app/bloc/user/user_state.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final AppLocalizations? appLocalizations;

  UserBloc({
    required this.userRepository,
    this.appLocalizations,
  }) : super(UserInitial()) {
    on<UserAddEvent>(_onAddUser);
    on<UserUpdateEvent>(_onUpdateUser);
    // on<UserGetAllEvent>(_onGetAllUser);
    on<UserGetEvent>(_onGetUser);
  }

  Future<void> _onAddUser(UserAddEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await userRepository.addUser(event.email, event.name);
      if (user != null) {
        emit(UserSuccess());
      } else {
        emit(UserFailure(appLocalizations!.failedAddUser));
      }
    } catch (e) {
      emit(UserFailure(appLocalizations!.failedAddUser));
    }
  }

  Future<void> _onUpdateUser(
      UserUpdateEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await userRepository.updateUser(
          event.name, event.phoneNumber, event.dateOfBirth, event.id!);
      if (user != null) {
        emit(UserSuccess());
      } else {
        emit(UserFailure(appLocalizations!.failedUpdatedUser));
      }
    } catch (e) {
      emit(UserFailure(appLocalizations!.failedUpdatedUser));
    }
  }

  // Future<void> _onGetAllUser(UserGetAllEvent event, Emitter<UserState> emit) async {
  //   emit(UserLoading());
  //   try {
  //     final users = await userRepository.ge();
  //     if (users != null) {
  //       emit(UserSuccess(users));
  //     } else {
  //       emit(UserFailure());
  //     }
  //   } catch (e) {
  //     emit(UserFailure(appLocalizations!.failedSignUp));
  //   }
  // }

  Future<void> _onGetUser(UserGetEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await userRepository.getUserByEmail(event.email);
      if (user != null) {
        emit(UserSuccess());
      } else {
        emit(UserFailure(appLocalizations!.failedGetUser));
      }
    } catch (e) {
      emit(UserFailure(appLocalizations!.failedSignUp));
    }
  }
}
