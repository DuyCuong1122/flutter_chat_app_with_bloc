import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onSearch;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSearch,
  });

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_checkText);
  }

  void _checkText() {
    setState(() {
      _hasText = widget.controller.text.isNotEmpty;
    });
  }

  void _clearText() {
    widget.controller.clear();
    widget.onSearch('');
    setState(() {
      _hasText = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: widget.controller,
        onChanged: (text) {
          widget.onSearch(text);
          _checkText();
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          hintText: widget.hintText,
          hintStyle: AppTypography.s16w500.copyWith(color: AppColor.normalColor),
          prefixIcon: const Icon(
            AppIcon.search,
            size: 20,
            color: AppColor.primaryColor,
          ),
          suffixIcon: _hasText
              ? IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.grey,
                  ),
                  onPressed: _clearText,
                )
              : null,
              border: InputBorder.none,
        ),
        style: AppTypography.s16w500.copyWith(color: Colors.black),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkText);
    super.dispose();
  }
}
