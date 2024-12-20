import 'package:flutter/material.dart';
import 'package:unilodge/core/configs/theme/app_colors.dart';

class TextRow extends StatelessWidget {
  final String text1;
  final String text2;

  const TextRow({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              text1,
              style: const TextStyle(fontSize: 15, color: Color(0xff434343)),
            ),
          ),
          Spacer(),
          Expanded(
            flex: 9,
            child: Text(
              textAlign: TextAlign.end,
              text2,
              style:
                  const TextStyle(fontSize: 15, color: AppColors.formTextColor),
              softWrap: true, // Allows text wrapping
            ),
          ),
        ],
      ),
    );
  }
}
