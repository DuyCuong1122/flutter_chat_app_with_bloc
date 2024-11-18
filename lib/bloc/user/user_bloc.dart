import 'package:chat_app/bloc/user/user_event.dart';
import 'package:chat_app/bloc/user/user_state.dart';
import 'package:chat_app/database/models/user.dart';
import 'package:chat_app/database/services/service.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final AppLocalizations? appLocalizations;
  final List<User> getAllUsers = [];
  final List<User> getAllFriends = [];

  UserBloc({
    required this.userRepository,
    this.appLocalizations,
  }) : super(UserInitial()) {
    on<UserAddEvent>(_onAddUser);
    on<UserUpdateEvent>(_onUpdateUser);
    on<UserGetAllEvent>(_onGetAllUser);
    on<UserGetEvent>(_onGetUser);
    on<UserGetAllFriendsEvent>(_onGetAllFriends);
  }

  Future<void> _onAddUser(UserAddEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.addUser(event.email, event.name);
      emit(UserSuccess());
    } catch (e) {
      emit(UserFailure(appLocalizations!.failedAddUser));
    }
  }

  Future<void> _onGetAllFriends(
      UserGetAllFriendsEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await userRepository.getAllFriends();
      getAllFriends.clear();
      getAllFriends.addAll(users);
      emit(UserGetAllFriendsSuccessState(users));
    } catch (e) {
      emit(UserFailure(appLocalizations!.failedSignUp));
    }
  }

  Future<void> _onUpdateUser(
      UserUpdateEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.updateUser(
          event.name, event.phoneNumber, event.dateOfBirth);

      await SharedPreferencesService().setUserValue(
          event.name ?? "", event.phoneNumber ?? "", event.dateOfBirth);
      emit(UserUpdateSuccessState(appLocalizations!.successfullyUpdateUser));
    } catch (e) {
      emit(UserFailure(appLocalizations!.failedUpdatedUser));
    }
  }

  Future<void> _onGetAllUser(
      UserGetAllEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      List users = <User>[];
      getAllUsers.isEmpty
          ? {
              users = await userRepository.getAllUsers(),
              getAllUsers.addAll(users as List<User>),
            }
          : null;
      emit(UserGetAllSuccessState(getAllUsers));
    } catch (e) {
      emit(UserFailure(appLocalizations!.failedSignUp));
    }
  }

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
