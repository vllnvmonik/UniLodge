import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:unilodge/bloc/authentication/auth_bloc.dart';
import 'package:unilodge/bloc/authentication/auth_event.dart';
import 'package:unilodge/bloc/authentication/auth_state.dart';
import 'package:unilodge/bloc/listing/listing_bloc.dart';
import 'package:unilodge/bloc/listing/listing_event.dart';
import 'package:unilodge/bloc/listing/listing_state.dart';
import 'package:unilodge/common/widgets/custom_text.dart';
import 'package:unilodge/core/configs/theme/app_colors.dart';
import 'package:unilodge/data/sources/auth/token_controller.dart';
import 'package:unilodge/presentation/widgets/settings_widg/logout_confirm_bottom_sheet.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late ListingBloc _listingBloc;
  bool isValidLandlord = false;

  @override
  void initState() {
    super.initState();

    _listingBloc = BlocProvider.of<ListingBloc>(context);
    _listingBloc.add(IsValidLandlordListing());
  }

  @override
  Widget build(BuildContext context) {
    final TokenControllerImpl _tokenController = TokenControllerImpl();

    return BlocListener<ListingBloc, ListingState>(
      listener: (context, state) {
        if (state is IsValidLandlordsSuccess) {
          setState(() {
            isValidLandlord = state.isValid;
          });
        } else if (state is IsValidLandlordsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Internet Connection Error")),
          );
        }
      },
      child: FutureBuilder<String?>(
        future: _tokenController.getAccessToken(),
        builder: (context, snapshot) {
          final accessToken = snapshot.data;

          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                context.go("/account-selection-login");
              } else if (state is LogoutError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: const CustomText(
                  text: 'Settings',
                  color: AppColors.primary,
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
                      leading:
                          const Icon(Icons.person, color: AppColors.textColor),
                      title: const CustomText(
                        text: 'My Profile',
                        fontSize: 16,
                        color: AppColors.textColor,
                      ),
                      onTap: () {
                        context.push('/my-profile');
                      },
                    ),
                    if (!isValidLandlord)
                      ListTile(
                        leading: const Icon(Icons.verified_user,
                            color: AppColors.textColor),
                        title: const CustomText(
                          text: 'Verify Account',
                          fontSize: 16,
                          color: AppColors.textColor,
                        ),
                        onTap: () {
                          context.push('/id-details');
                        },
                      ),
                    const Divider(),
                    ListTile(
                      leading:
                          const Icon(Icons.lock, color: AppColors.textColor),
                      title: const CustomText(
                        text: 'Change Password',
                        fontSize: 16,
                        color: AppColors.textColor,
                      ),
                      onTap: () {
                        if (accessToken != null) {
                          context.push('/change-password/$accessToken');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Token is unavailable')),
                          );
                        }
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading:
                          const Icon(Icons.logout, color: AppColors.textColor),
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
            ),
          );
        },
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthBloc>(context);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LogoutConfirmBottomSheet(
          onLogout: () {
            _authBloc.add(LogoutEvent());
            _showLoading(context);
          },
        );
      },
    );
  }

  void _showLoading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: Lottie.asset('assets/animation/home_loading.json'),
          ),
        );
      },
    );
  }
}
