import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unilodge/common/widgets/custom_text.dart';
import 'package:unilodge/core/configs/theme/app_colors.dart';
import 'package:unilodge/presentation/widgets/settings_widg/logout_confirm_bottom_sheet.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textColor),
          onPressed: () {
            context.go('/user-profile');
          },
        ),
        title: const CustomText(
          text: 'Settings',
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.textColor),
              title: const CustomText(
                text: 'My Profile',
                fontSize: 16,
                color: AppColors.textColor,
              ),
              onTap: () {
                context.go('/my-profile');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.lock, color: AppColors.textColor),
              title: const CustomText(
                text: 'Change Password',
                fontSize: 16,
                color: AppColors.textColor,
              ),
              onTap: () {
                context.go('/my-profile');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.textColor),
              title: const CustomText(
                text: 'Logout',
                fontSize: 16,
                color: AppColors.textColor,
              ),
              onTap: () {
                _showLogoutConfirmation(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LogoutConfirmBottomSheet(
          onLogout: () {
            //
          },
        );
      },
    );
  }
}
