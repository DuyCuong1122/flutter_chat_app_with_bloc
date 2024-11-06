import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onSearch;

  const SearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSearch,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
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
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: widget.controller,
        onChanged: (text) {
          widget.onSearch(text);
          _checkText();
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.lato(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: const Color(0xFF999999),
          ),
          prefixIcon: const Icon(
            AppIcon.search,
            size: 18,
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkText);
    super.dispose();
  }
}
