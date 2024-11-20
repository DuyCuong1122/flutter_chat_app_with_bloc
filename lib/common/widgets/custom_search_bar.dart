import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onSearch;
  final Function() onClear;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSearch,
    required this.onClear,
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
    FocusScope.of(context).unfocus();
    widget.onClear();
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
          text != '' ? widget.onSearch(text) : widget.onClear();
          _checkText();
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          hintText: widget.hintText,
          hintStyle:
              AppTypography.s16w500.copyWith(color: AppColors.normalColor),
          prefixIcon: const Icon(
            AppIcon.search,
            size: 20,
            color: AppColors.primaryColor,
          ),
          suffixIcon: _hasText
              ? InkWell(
                  onTap: _clearText,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: AppColors.f99Color,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 13,
                      color: AppColors.whiteColor,
                    ),
                  ),
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
