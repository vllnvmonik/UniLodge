import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unilodge/core/configs/theme/app_colors.dart';
import 'package:unilodge/core/configs/theme/app_theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 174, 189, 201),
              Color(0xff2E3E4A),
            ])),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 180,
              ),
              Text(
                'UniLodge',
                style: TextStyle(
                    fontFamily: AppTheme.logoFont,
                    fontSize: 36,
                    color: AppColors.lightBlueTextColor),
              ),
              Text('Sign Up Page',
                  style: TextStyle(color: AppColors.textColor)),
              SizedBox(
                height: 450,
              ),
              SizedBox(
                width: 270,
                height: 50,
                child: OutlinedButton(
                    onPressed: () async {
                      context.go('/login');
                    },
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white)),
                    child: Text(
                      'Sign Up',
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}