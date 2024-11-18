import 'package:chat_app/database/models/model.dart';

class CheckBoxEvent {}

class CheckBoxToggleEvent extends CheckBoxEvent {
  final User item;

  CheckBoxToggleEvent({required this.item});
}

