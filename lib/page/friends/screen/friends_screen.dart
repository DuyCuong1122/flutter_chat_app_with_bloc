import 'package:chat_app/bloc/user/user_bloc.dart';
import 'package:chat_app/bloc/user/user_state.dart';
import 'package:chat_app/common/util/get_first_character_name.dart';
import 'package:chat_app/database/models/user.dart';
import 'package:chat_app/page/friends/widget/character_container.dart';
import 'package:chat_app/page/friends/widget/friend_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserGetAllFriendsSuccessState) {
          Map<String, List<User>> groupedUsers =
              groupUsersByInitial(state.users);
          List<String> initials = groupedUsers.keys.toList()..sort();
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              String initial = initials[index];
              List<User> userList = groupedUsers[initial]!;
              return Column(
                children: [
                  CharacterContainer(character: initial),
                  ...userList.map((user) {
                    return FriendItem(user: user);
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
      }),
    );
  }
}
