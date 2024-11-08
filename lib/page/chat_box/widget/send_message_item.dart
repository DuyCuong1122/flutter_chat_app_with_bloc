import 'dart:io';

import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class SendMessageItem extends StatefulWidget {
  const SendMessageItem({super.key});

  @override
  _SendMessageItemState createState() => _SendMessageItemState();
}

class _SendMessageItemState extends State<SendMessageItem> {
  Color albumIconColor = Colors.grey;
  Color emojiIconColor = Colors.grey;
    final ImagePicker _picker = ImagePicker();

  void _toggleAlbumIconColor() {
    setState(() {
      albumIconColor = albumIconColor ==  Colors.grey ? AppColor.primaryColor : Colors.grey;
      albumIconColor == AppColor.primaryColor ? emojiIconColor = Colors.grey : null;
    });
  }

  void _toggleEmojiIconColor() {
    setState(() {
      emojiIconColor = emojiIconColor == Colors.grey ? AppColor.primaryColor : Colors.grey;
      emojiIconColor == AppColor.primaryColor ? albumIconColor = Colors.grey : null;
    });
  }

  XFile? selectedImage;

  // Mở thư viện ảnh và chọn một ảnh
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = image;
        albumIconColor = AppColor.primaryColor;
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
              : Center(child: Text("Không có ảnh nào được chọn")),
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
              color: Color(0xFFF6F6F6),
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
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20, top: 12),
                hintText: '${AppLocalizations.of(context)!.enterMessage}...',
                hintStyle: AppTypography.s16w500.copyWith(color: const Color(0xFF676767)),
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
          onPressed: () {},
          icon: const Icon(
            AppIcon.send,
            color: AppColor.primaryColor,
            size: 24,
          ),
        ),
      ],
    );
  }
}
