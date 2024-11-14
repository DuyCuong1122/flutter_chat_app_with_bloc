import 'package:chat_app/database/models/user.dart';

class UserState {
  final List<User> usersList;
  UserState({this.usersList = const [] });}

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
  UserGetAllSuccessState(this.users) : super(usersList: users);
}

class UserGetAllFriendsSuccessState extends UserState {
  final List<User> users;
  UserGetAllFriendsSuccessState(this.users);
}
