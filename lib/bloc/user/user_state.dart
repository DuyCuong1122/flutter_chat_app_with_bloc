
import 'package:chat_app/common/models/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
}

class UserFailure extends UserState {
  final String message;
  UserFailure(this.message);
}

class UserUpdateSuccessState extends UserState {
  final String message;
  UserUpdateSuccessState(this.message);
}

class UserGetAllSuccessState extends UserState {
  final List<User> users;
  UserGetAllSuccessState(this.users);
}