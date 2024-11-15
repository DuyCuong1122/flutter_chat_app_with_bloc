import 'package:chat_app/bloc/request/request_bloc.dart';
import 'package:chat_app/bloc/request/request_state.dart';
import 'package:chat_app/bloc/request_action/request_action_bloc.dart';
import 'package:chat_app/bloc/request_action/request_action_event.dart';
import 'package:chat_app/bloc/user/user_bloc.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/page/friends/widget/sent_friend_item.dart';
import 'package:chat_app/page/friends/widget/slidable_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocBuilder<RequestBloc, RequestState>(
        builder: (context, state) {
          if (context.watch<UserBloc>().state.usersList.isNotEmpty) {
            if (state is RequestLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RequestGetAllSuccessState) {
              return Padding(
                padding: const EdgeInsets.only(top: 22, left: 12, right: 12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.receivedRequest.isNotEmpty) ...[
                        Text(
                          AppLocalizations.of(context)!
                              .friendRequests
                              .toUpperCase(),
                          style: AppTypography.s14w800
                              .copyWith(color: AppColors.f99Color),
                        ),
                        ...state.receivedRequest.map((request) {
                          return SlidableItem(
                            user: context
                                .watch<UserBloc>()
                                .state
                                .usersList
                                .firstWhere(
                                    (element) => element.id == request.fromUId),
                            onAccept: () {
                              context
                                  .read<RequestActionBloc>()
                                  .add(RequestAcceptEvent(request: request));
                            },
                            onReject: () {
                              context
                                  .read<RequestActionBloc>()
                                  .add(RequestDeleteEvent(request: request));
                            },
                          );
                        }),
                        Container(
                          height: 5,
                          width: double.infinity,
                          color: AppColors.fefeeColor,
                        ),
                        const SizedBox(height: 22),
                      ],
                      if (state.sendRequest.isNotEmpty) ...[
                        Text(
                          AppLocalizations.of(context)!
                              .sentFriend
                              .toUpperCase(),
                          style: AppTypography.s14w800
                              .copyWith(color: AppColors.f99Color),
                        ),
                        ...state.sendRequest.map((request) {
                          return SentFriendItem(
                              user: context
                                  .watch<UserBloc>()
                                  .state
                                  .usersList
                                  .firstWhere((element) =>
                                      element.id == request.toUId));
                        }),
                      ]
                    ],
                  ),
                ),
              );
            } else if (state is RequestFailure) {
              return Center(child: Text(state.message));
            }
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}
