abstract class UserEvent { }

class UserAddEvent extends UserEvent {
  final String email;
  final String name;

  UserAddEvent({required this.email, required this.name});
}

class UserUpdateEvent extends UserEvent {
  final String email;
  final String? name;
  final String? phoneNumber;
  final String? dateOfBirth;

  UserUpdateEvent({required this.email, this.name, this.phoneNumber, this.dateOfBirth});
}

class UserGetAllEvent extends UserEvent {
}

class UserGetEvent extends UserEvent {
  final String email;

  UserGetEvent({required this.email});
}