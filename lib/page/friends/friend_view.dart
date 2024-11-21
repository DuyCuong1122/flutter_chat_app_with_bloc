import 'package:chat_app/bloc/message/message_bloc.dart';
import 'package:chat_app/bloc/request/request_bloc.dart';
import 'package:chat_app/bloc/request/request_event.dart';
import 'package:chat_app/bloc/user/user_bloc.dart';
import 'package:chat_app/bloc/user/user_event.dart';
import 'package:chat_app/bloc/user/user_state.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/common/widgets/custom_background.dart';
import 'package:chat_app/common/widgets/custom_search_bar.dart';
import 'package:chat_app/database/models/model.dart';
import 'package:chat_app/page/chat_box/chat_box_view.dart';
import 'package:chat_app/page/friends/screen/all_screen.dart';
import 'package:chat_app/page/friends/screen/friends_screen.dart';
import 'package:chat_app/page/friends/screen/request_screen.dart';
import 'package:chat_app/page/friends/widget/friend_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/message/message_event.dart';
import '../../bloc/message/message_state.dart';

class FriendView extends StatelessWidget {
  const FriendView({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final searchController = TextEditingController();
    final heightScreen = MediaQuery.of(context).size.height;
    User selectedUser = User();
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
                            translate.friends,
                            style: AppTypography.s30w700.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Image.asset(AppIcon.addFriend),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: heightScreen * 0.03),
                      CustomSearchBar(
                        controller: searchController,
                        hintText: '${translate.searchFriends}...',
                        onSearch: (query) => context
                            .read<UserBloc>()
                            .add(UserSearchEvent(query: query)),
                        onClear: () => context
                            .read<UserBloc>()
                            .add(UserGetAllFriendsEvent()),
                      ),
                      SizedBox(height: heightScreen * 0.03),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: BlocListener<MessageBloc, MessageState>(
                        listener: (context, state) {
                          if (state is MessageCreateSuccessState) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatBoxView(
                                  message: state.message,
                                ),
                              ),
                            );
                          } else if (state is MessageExistState) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatBoxView(
                                  message: state.message,
                                ),
                              ),
                            );
                          } else if (state is MessageFailure) {
                            context
                                .read<MessageBloc>()
                                .add(MessageCreateEvent(toUser: selectedUser));
                          }
                        },
                        child: BlocBuilder<UserBloc, UserState>(
                            bloc: context.read<UserBloc>(),
                            builder: (context, state) {
                              if (state is UserSearchSuccessState) {
                                if (state.users.isEmpty) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, top: 20, bottom: 0),
                                      child: Text(
                                        translate.friends.toUpperCase(),
                                        style: AppTypography.s14w800.copyWith(
                                            color: AppColors.f99Color),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: state.users.length,
                                        itemBuilder: (context, index) {
                                          final user = state.users[index];
                                          selectedUser = user;
                                          return FriendItem(
                                            user: user,
                                            onTap: () => context
                                                .read<MessageBloc>()
                                                .add(MessageCheckExistEvent(
                                                    user: user)),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return DefaultTabController(
                                length: 3,
                                child: Column(
                                  children: [
                                    TabBar(
                                      indicatorColor: AppColors.primaryColor,
                                      labelColor: AppColors.primaryColor,
                                      unselectedLabelColor:
                                          AppColors.normalColor,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicatorPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      tabs: [
                                        Tab(
                                            text: translate.friends
                                                .toUpperCase()),
                                        Tab(text: translate.all.toUpperCase()),
                                        Tab(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                translate.request.toUpperCase(),
                                              ),
                                              // if (context
                                              //         .watch<RequestBloc>()
                                              //         .state
                                              //         .requestCount >
                                              //     0)
                                              //   NotificationCircleContainer(
                                              //     number: context
                                              //         .watch<RequestBloc>()
                                              //         .state
                                              //         .requestCount,
                                              //   ),
                                            ],
                                          ),
                                        ),
                                      ],
                                      onTap: (value) {
                                        if (value == 0) {
                                          context
                                              .read<UserBloc>()
                                              .add(UserGetAllFriendsEvent());
                                        }
                                        if (value == 1) {
                                          context
                                              .read<UserBloc>()
                                              .add(UserGetAllEvent());
                                        }
                                        if (value == 2 || value == 1) {
                                          context
                                              .read<RequestBloc>()
                                              .add(RequestGetAllEvent());
                                        }
                                      },
                                    ),
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: TabBarView(
                                          children: [
                                            FriendsScreen(),
                                            AllScreen(),
                                            RequestScreen()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
