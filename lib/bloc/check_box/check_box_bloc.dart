import 'package:chat_app/database/models/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'check_box_event.dart';
import 'check_box_state.dart';

class CheckBoxBloc extends Bloc<CheckBoxEvent, CheckBoxState> {
  final List<User> users = [];

  CheckBoxBloc() : super(CheckBoxInitial()) {
    on<CheckBoxToggleEvent>(_onToggleCheckbox);
  }

  void _onToggleCheckbox(
      CheckBoxToggleEvent event, Emitter<CheckBoxState> emit) {
    if (users.isEmpty) {
      users.add(event.item);
    } else {
      if (users.contains(event.item)) {
        users.remove(event.item);
      } else {
        users.clear();
        users.add(event.item);
      }
    }
    emit(CheckBoxToggledState(users: users));
  }
}
