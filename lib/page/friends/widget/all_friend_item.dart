import 'package:chat_app/bloc/request/request_bloc.dart';
import 'package:chat_app/bloc/request/request_event.dart';
import 'package:chat_app/bloc/request/request_state.dart';
import 'package:chat_app/bloc/request_action/request_action_bloc.dart';
import 'package:chat_app/bloc/request_action/request_action_event.dart';
import 'package:chat_app/bloc/request_action/request_action_state.dart';
import 'package:chat_app/common/util/get_first_character_name.dart';
import 'package:chat_app/common/util/get_first_character_name.dart';
import 'package:chat_app/common/util/get_first_character_name.dart';
import 'package:chat_app/common/values/storage.dart';
import 'package:chat_app/common/widgets/default_avatar.dart';
import 'package:chat_app/database/models/model.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:chat_app/database/services/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllFriendItem extends StatelessWidget {
  final User user;
  final bool isFriend;

  const AllFriendItem({
    super.key,
    required this.user,
    this.isFriend = false,
  });

  @override
  Widget build(BuildContext context) {
    final userId = SharedPreferencesService().getString(ID);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          const DefaultAvatar(size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              user.name!,
              style:
                  AppTypography.s16w800.copyWith(color: AppColors.blackColor),
            ),
          ),
          buildButtonOption(context),
        ],
      ),
    );
  }

  Widget buildButtonOption(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    if (!isFriend) {
      final requestState = context.watch<RequestBloc>().state;
      if (requestState is RequestGetAllSuccessState) {
        final isSentRequest =
            requestState.sendRequest.any((element) => element.toUId == user.id);
        final isReceivedRequest = requestState.receivedRequest
            .any((element) => element.fromUId == user.id);

        return BlocConsumer<RequestActionBloc, RequestActionState>(
          listener: (context, state) {
            if (state is RequestActionSuccess) {
              context.read<RequestBloc>().add(
                  RequestGetAllEvent());
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () {
                if (isSentRequest) {
                  context.read<RequestActionBloc>().add(RequestDeleteEvent(
                      request: requestState.sendRequest
                          .firstWhere((element) => element.toUId == user.id)));
                } else if (isReceivedRequest) {
                  context.read<RequestActionBloc>().add(RequestAcceptEvent(
                      request: requestState.receivedRequest.firstWhere(
                          (element) => element.fromUId == user.id)));
                } else {
                  context.read<RequestActionBloc>().add(RequestCreateEvent(
                      request: Request(fromUId: userId, toUId: user.id)));
                  requestState.sendRequest
                      .add(Request(fromUId: userId, toUId: user.id));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                isSentRequest
                    ? translate.cancel
                    : isReceivedRequest
                        ? translate.accept
                        : translate.addFriend,
                style: AppTypography.s14w500.copyWith(color: Colors.white),
              ),
            );
          },
        );
      }
    }
    return const SizedBox.shrink();
  }
}
