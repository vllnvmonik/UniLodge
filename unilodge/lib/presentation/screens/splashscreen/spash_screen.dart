import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unilodge/bloc/authentication/auth_bloc.dart';
import 'package:unilodge/bloc/authentication/auth_event.dart';
import 'package:unilodge/bloc/authentication/auth_state.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        BlocProvider.of<AuthBloc>(context).add(AuthenticateTokenEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          print("typesh ${state.isAdmin}");
          if (state.isAdmin) {
            return context.go('/admin-dashboard');
          }
          return context.go('/home');
        } else if (state is AuthFailure) {
          context.go('/onboarding');
        }
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 250,
            child: Lottie.asset('assets/animation/animation.json'),
          ),
        ),
      ),
    );
  }
}
