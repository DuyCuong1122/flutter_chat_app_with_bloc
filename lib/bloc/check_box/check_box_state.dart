import '../../database/models/user.dart';

class CheckBoxState {}

class CheckBoxInitial extends CheckBoxState {}

class CheckBoxLoading extends CheckBoxState {}

class CheckBoxToggledState extends CheckBoxState {
  final List<User> users;
  CheckBoxToggledState({required this.users});
}