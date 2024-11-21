import 'package:chat_app/bloc/user/user_bloc.dart';
import 'package:chat_app/bloc/user/user_event.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/common/widgets/custom_background.dart';
import 'package:chat_app/common/widgets/custom_search_bar.dart';
import 'package:chat_app/database/models/message.dart';
import 'package:chat_app/page/message/widget/message_item.dart';
import 'package:chat_app/page/message/widget/search_message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/message/message_bloc.dart';
import '../../bloc/message/message_event.dart';
import '../../bloc/message/message_state.dart';
import 'create_massage/create_message_view.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final heightScreen = MediaQuery.of(context).size.height;
    final translate = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            const CustomBackground(),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      SizedBox(height: heightScreen * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate.message,
                            style: AppTypography.s30w700.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                context
                                    .read<UserBloc>()
                                    .add(UserGetAllFriendsEvent());
                                return const CreateMessageView();
                              }));
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Image.asset(AppIcon.newMessage),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: heightScreen * 0.03),
                      CustomSearchBar(
                        controller: searchController,
                        hintText: '${translate.searchMessage}...',
                        onSearch: (String query) {
                          context
                              .read<MessageBloc>()
                              .add(MessageSearchEvent(query: query));
                        },
                        onClear: () {
                          context.read<MessageBloc>().add(MessageGetAllEvent());
                        },
                      ),
                      SizedBox(height: heightScreen * 0.03),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: BlocBuilder<MessageBloc, MessageState>(
                      bloc: BlocProvider.of<MessageBloc>(context),
                      builder: (context, state) {
                        if (state is MessageLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is MessageSuccess) {
                          final messages = state.messagesList;
                          return ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              return MessageItem(message: message);
                            },
                          );
                        } else if (state is MessageSearchSuccess) {
                          final results = state.results;
                          if (results.isEmpty) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppIcon.searchPNG),
                                Text(
                                  translate.noSuitableResult,
                                  style: AppTypography.s16w800.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            );
                          }
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: Text(translate.listFriends,
                                    style: AppTypography.s14w800
                                        .copyWith(color: AppColors.f99Color)),
                              ),
                              ListView.builder(
                                itemCount: results.length,
                                itemBuilder: (context, index) {
                                  final response = results[index];
                                  return SearchMessageItem(
                                      message: Message.fromFirestore(
                                          response['message']),
                                      count: response['count']);
                                },
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
