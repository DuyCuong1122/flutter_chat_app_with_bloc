import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserEvent {}

class UserAddEvent extends UserEvent {
  final String email;
  final String name;

  UserAddEvent({required this.email, required this.name});
}

class UserUpdateEvent extends UserEvent {
  final String? name;
  final String? phoneNumber;
  final Timestamp? dateOfBirth;
  final String? id;

  UserUpdateEvent({this.id, this.name, this.phoneNumber, this.dateOfBirth});
}

class UserGetAllEvent extends UserEvent {}

class UserGetEvent extends UserEvent {
  final String email;

  UserGetEvent({required this.email});
}

class UserGetAllFriendsEvent extends UserEvent {}

class UserSearchEvent extends UserEvent {
  final String query;

  UserSearchEvent({required this.query});
}
