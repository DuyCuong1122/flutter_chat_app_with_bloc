import 'package:chat_app/common/values/storage.dart';
import 'package:chat_app/database/models/user.dart';
import 'package:chat_app/database/services/shared_preference_service.dart';

String? userId = SharedPreferencesService().getString(ID);

Map<String, List<User>> groupUsersByInitial(List<User> users) {
  users.removeWhere((element) => element.id == userId);
  // Sắp xếp người dùng theo first name
  users.sort((a, b) => a.name!.toUpperCase().compareTo(b.name!.toUpperCase()));

  Map<String, List<User>> groupedUsers = {};
  for (var user in users) {
    String initial = initialName(user.name!);
    if (groupedUsers.containsKey(initial)) {
      groupedUsers[initial]!.add(user);
    } else {
      groupedUsers[initial] = [user];
    }
  }
  return groupedUsers;
}

String initialName(String name) {
  return name.split(' ').last[0].toUpperCase();
}
