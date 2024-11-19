import 'dart:io';

import 'package:chat_app/bloc/message_chat/message_chat_event.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../bloc/message_chat/message_chat_bloc.dart';
import '../../../database/models/message.dart';
import '../../../database/models/message_content.dart';

class SendMessageItem extends StatefulWidget {
  final Message message;
  const SendMessageItem({super.key, required this.message});

  @override
  _SendMessageItemState createState() => _SendMessageItemState();
}

class _SendMessageItemState extends State<SendMessageItem> {
  Color albumIconColor = Colors.grey;
  Color emojiIconColor = Colors.grey;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController messageController = TextEditingController();

  void _toggleAlbumIconColor() {
    setState(() {
      albumIconColor =
          albumIconColor == Colors.grey ? AppColors.primaryColor : Colors.grey;
      albumIconColor == AppColors.primaryColor
          ? emojiIconColor = Colors.grey
          : null;
    });
  }

  void _toggleEmojiIconColor() {
    setState(() {
      emojiIconColor =
          emojiIconColor == Colors.grey ? AppColors.primaryColor : Colors.grey;
      emojiIconColor == AppColors.primaryColor
          ? albumIconColor = Colors.grey
          : null;
    });
  }

  XFile? selectedImage;

  // Mở thư viện ảnh và chọn một ảnh
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = image;
        albumIconColor = AppColors.primaryColor;
      });
      _showAlbumSheet();
    }
  }

  // Hiển thị danh sách ảnh trong BottomSheet
  void _showAlbumSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          height: 250,
          child: selectedImage != null
              ? Image.file(File(selectedImage!.path))
              : const Center(child: Text("Không có ảnh nào được chọn")),
        );
      },
    ).whenComplete(() {
      setState(() {
        albumIconColor = Colors.grey;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 52,
            width: 52,
            decoration: const BoxDecoration(
              color: AppColors.f6Color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              AppIcon.album,
              color: albumIconColor,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.f6Color,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20, top: 12),
                hintText: '${AppLocalizations.of(context)!.enterMessage}...',
                hintStyle: AppTypography.s16w500
                    .copyWith(color: const Color(0xFF676767)),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: _toggleEmojiIconColor,
                  icon: Icon(
                    AppIcon.emoji,
                    size: 24,
                    color: emojiIconColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        IconButton(
          onPressed: () {
            if (messageController.text.isNotEmpty) {
              final messageContent = MessageContent(
                content: messageController.text,
              );
              context.read<MessageChatBloc>().add(
                    MessageSendEvent(
                      messageContent: messageContent,
                      message: widget.message
                    ),
                  );
            }
            messageController.clear();
          },
          icon: const Icon(
            AppIcon.send,
            color: AppColors.primaryColor,
            size: 24,
          ),
        ),
      ],
    );
  }
}
