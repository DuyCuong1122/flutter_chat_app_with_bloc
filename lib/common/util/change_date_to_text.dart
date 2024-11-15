import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String formatMessageTimestamp(Timestamp timestamp) {
  // Convert Firestore Timestamp to DateTime
  DateTime messageTime = timestamp.toDate();
  DateTime now = DateTime.now();

  // Kiểm tra xem tin nhắn có được gửi trong hôm nay không
  if (messageTime.year == now.year &&
      messageTime.month == now.month &&
      messageTime.day == now.day) {
    // Nếu hôm nay, chỉ hiển thị giờ (HH:mm)
    return DateFormat('HH:mm').format(messageTime);
  } else {
    // Nếu trước hôm nay, hiển thị ngày và giờ (dd/MM/yyyy HH:mm)
    return DateFormat('dd/MM/yyyy HH:mm').format(messageTime);
  }
}

String formatMessageDate(Timestamp timestamp, BuildContext context) {
  // Convert Firestore Timestamp to DateTime
  DateTime messageTime = timestamp.toDate();
  DateTime now = DateTime.now();

  // Kiểm tra xem tin nhắn có được gửi trong hôm nay không
  if (messageTime.year == now.year &&
      messageTime.month == now.month &&
      messageTime.day == now.day) {
    // Nếu hôm nay, hiển thị "Today"
    return AppLocalizations.of(context)!.today;
  } else if (messageTime.year == now.year &&
      messageTime.month == now.month &&
      messageTime.day == now.day - 1) {
    // Nếu hôm qua, hiển thị "Yesterday"
    return AppLocalizations.of(context)!.yesterday;
  } else {
    // Nếu trước hôm qua, hiển thị ngày (dd/MM/yyyy
    return DateFormat('dd/MM/yyyy').format(messageTime);
  }
}