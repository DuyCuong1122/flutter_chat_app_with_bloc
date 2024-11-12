import 'package:chat_app/bloc/user/user_bloc.dart';
import 'package:chat_app/bloc/user/user_state.dart';
import 'package:chat_app/database/models/user.dart';
import 'package:chat_app/common/services/service.dart';
import 'package:chat_app/common/values/storage.dart';
import 'package:chat_app/page/friends/widget/character_container.dart';
import 'package:chat_app/page/friends/widget/friend_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllScreen extends StatelessWidget {
   AllScreen({super.key});
  String? userId = SharedPreferencesService().getString(ID);
  List<String> friendIds = SharedPreferencesService().getList(LIST_FRIENDS);

  Map<String, List<User>> groupUsersByInitial(List<User> users) {
    users.removeWhere((element) => element.id == userId);
    // Sắp xếp người dùng theo first name
    users
        .sort((a, b) => a.name!.toUpperCase().compareTo(b.name!.toUpperCase()));

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (BuildContext context, UserState state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserGetAllSuccessState) {
            Map<String, List<User>> groupedUsers =
                groupUsersByInitial(state.users);
            List<String> initials = groupedUsers.keys.toList()..sort();
            return ListView.builder(
              itemCount: initials.length,
              itemBuilder: (context, index) {
                String initial = initials[index];
                List<User> userList = groupedUsers[initial]!;
                return Column(
                  children: [
                    CharacterContainer(character: initial),
                    ...userList.map((user) {
                      final isFriend = friendIds.contains(user.id);
                      return FriendItem(
                          user: user,
                          type: AppLocalizations.of(context)!.all,
                          isFriend: isFriend
                        );
                    }),
                  ],
                );
              },
            );
          } else if (state is UserFailure) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
