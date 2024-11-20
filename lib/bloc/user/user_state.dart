import 'package:chat_app/database/models/user.dart';

class UserState {}


class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {}

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
  UserGetAllSuccessState(this.users) : super();
}

class UserGetAllFriendsSuccessState extends UserState {
  final List<User> users;
  UserGetAllFriendsSuccessState(this.users);
}

class UserSearchSuccessState extends UserState {
  final List<User> users;
  UserSearchSuccessState(this.users);
}
