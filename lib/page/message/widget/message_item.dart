import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/common/values/typography.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final int newMessageCount;
  final String name;
  final String message;
  final String time;
  const MessageItem(
      {super.key,
      this.newMessageCount = 0,
      required this.name,
      required this.message,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Stack(children: [
            Container(
              padding: EdgeInsets.all(newMessageCount == 0
                  ? 0
                  : 2), // Khoảng trắng giữa border và avatar
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Màu trắng làm viền cách biệt
                border: newMessageCount == 0
                    ? null
                    : Border.all(
                        color: AppColor.primaryColor,
                        width: 2,
                      ),
              ),
              child: Container(
                height: newMessageCount == 0 ? 58 : 54,
                width: newMessageCount == 0 ? 58 : 54,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    AppColor.primaryColor,
                    AppColor.secondaryColor,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.grey[300],
                ),
              ),
            ),
            if (newMessageCount > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color(0xFFC92323),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      newMessageCount.toString(),
                      style: AppTypography.s12w500.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ]),
          const SizedBox(width: 19),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 5, bottom: 29),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColor.normalColor,
                    width: 0.5,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style:
                            AppTypography.s16w800.copyWith(color: Colors.black),
                      ),
                      Text(
                        time,
                        style: AppTypography.s12w500.copyWith(
                            color: newMessageCount == 0
                                ? AppColor.normalColor
                                : Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message,
                    maxLines: 1, // Hiển thị tối đa 1 dòng
                    overflow: TextOverflow.ellipsis, // Thêm dấu "..." nếu quá dài
                 
                    style: newMessageCount == 0
                        ? AppTypography.s14w500
                            .copyWith(color: AppColor.normalColor)
                        : AppTypography.s14w700.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
