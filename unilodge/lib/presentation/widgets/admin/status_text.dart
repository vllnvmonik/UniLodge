import 'package:flutter/material.dart';
import 'package:unilodge/common/widgets/custom_text.dart';
import 'package:unilodge/core/configs/theme/app_colors.dart';

class StatusText extends StatelessWidget {
  const StatusText({super.key, required this.statusText});

  final String statusText;

  @override
  Widget build(BuildContext context) {
    Color statusColor;

    if (statusText == "Declined") {
      statusColor = AppColors.redInactive;
    } else if (statusText == "Approved") {
      statusColor = AppColors.greenActive;
    } else {
      statusColor =
          AppColors.pending; // Fallback color in case of unknown status
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomText(
        text: statusText,
        color: AppColors.lightBackground,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
