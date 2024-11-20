import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chat_app/bloc/user/user_bloc.dart';
import 'package:chat_app/bloc/user/user_state.dart';
import 'package:chat_app/common/util/get_first_character_name.dart';
import 'package:chat_app/database/models/user.dart';
import 'package:chat_app/database/services/service.dart';
import 'package:chat_app/common/values/storage.dart';
import 'package:chat_app/page/friends/widget/all_friend_item.dart';
import 'package:chat_app/page/friends/widget/character_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllScreen extends StatelessWidget {
  AllScreen({super.key});
  List<String> friendIds = SharedPreferencesService().getList(LIST_FRIENDS);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
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
                      return AllFriendItem(user: user, isFriend: isFriend);
                    }),
                  ],
                );
              },
            );
          } else if (state is UserFailure) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text(AppLocalizations.of(context)!.noData));
          }
        },
      ),
    );
  }
}
