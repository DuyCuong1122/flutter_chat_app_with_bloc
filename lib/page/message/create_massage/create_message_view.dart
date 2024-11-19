import 'dart:developer';

import 'package:chat_app/bloc/check_box/check_box_bloc.dart';
import 'package:chat_app/bloc/check_box/check_box_state.dart';
import 'package:chat_app/bloc/message/message_bloc.dart';
import 'package:chat_app/bloc/message/message_event.dart';
import 'package:chat_app/bloc/message/message_state.dart';
import 'package:chat_app/bloc/user/user_bloc.dart';
import 'package:chat_app/bloc/user/user_state.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/page/chat_box/chat_box_view.dart';
import 'package:chat_app/page/message/widget/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/check_box/check_box_event.dart';
import '../../../common/values/typography.dart';
import '../../../common/widgets/custom_background.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../common/widgets/custom_search_bar.dart';
import '../widget/choice_friend_item.dart';

class CreateMessageView extends StatelessWidget {
  const CreateMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final searchFriends = TextEditingController();
    return BlocProvider(
      create: (context) => CheckBoxBloc(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              const CustomBackground(),
              Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: heightScreen * 0.05),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(
                                      AppIcon.back,
                                      color: Colors.white,
                                      size: 24,
                                    )),
                                Text(
                                  AppLocalizations.of(context)!.createMessage,
                                  style: AppTypography.s18w800.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Text(
                                      AppLocalizations.of(context)!.cancel,
                                      style: AppTypography.s16w500
                                          .copyWith(color: Colors.white),
                                    )),
                              ],
                            ),
                            SizedBox(height: heightScreen * 0.03),
                            CustomSearchBar(
                              controller: searchFriends,
                              hintText:
                                  '${AppLocalizations.of(context)!.searchFriends}...',
                              onSearch: (String query) {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Container(
                        height: heightScreen * 0.72,
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(12, 26, 12, 0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                AppLocalizations.of(context)!
                                    .listFriends
                                    .toUpperCase(),
                                style: AppTypography.s14w800
                                    .copyWith(color: AppColors.f99Color)),
                            const SizedBox(height: 27),
                            Expanded(
                              child: BlocBuilder<UserBloc, UserState>(
                                  builder: (context, state) {
                                if (state is UserGetAllFriendsSuccessState) {
                                  log('state: $state');
                                  log('state: ${state.users}');
                                  if (state.users.isNotEmpty) {
                                    return ListView.builder(
                                      itemCount: state.users.length,
                                      itemBuilder: (context, index) {
                                        final user = state.users[index];
                                        return GestureDetector(
                                          onTap: () => context
                                              .read<CheckBoxBloc>()
                                              .add(CheckBoxToggleEvent(
                                                  item: user)),
                                          child: ChoiceFriendItem(user: user),
                                        );
                                      },
                                    );
                                  }
                                }
                                return const SizedBox();
                              }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              BlocBuilder<CheckBoxBloc, CheckBoxState>(
                builder: (BuildContext context, CheckBoxState state) {
                  if (state is CheckBoxToggledState && state.users.isNotEmpty) {
                    return Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        color: AppColors.f6Color,
                        height: 80,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.users.length,
                                itemBuilder: (context, index) {
                                  final item = state.users[index];
                                  return CustomAvatar(user: item);
                                },
                              ),
                            ),
                            BlocListener<MessageBloc, MessageState>(
                              listener: (context, state) {
                                if (state is MessageCreateSuccessState) {
                                  log('state: $state');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatBoxView(
                                        message: state.message,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: InkWell(
                                onTap: () => context.read<MessageBloc>().add(
                                    MessageCreateEvent(
                                        toUser: state.users.first)),
                                child: Container(
                                  width: 58,
                                  height: 58,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
