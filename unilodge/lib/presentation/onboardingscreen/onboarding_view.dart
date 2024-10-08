import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unilodge/bloc/authentication/auth_state.dart';
import 'onboarding_items.dart';
import 'package:unilodge/core/configs/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unilodge/bloc/authentication/auth_bloc.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: AppColors.lightBackground,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? getStarted(context) 
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  TextButton(
                      onPressed: () => pageController.jumpToPage(
                          controller.items.length - 1), // Go to last page
                      style: TextButton.styleFrom(
                          foregroundColor: AppColors.linearGreen),
                      child: const Text("Skip")),
                  // Indicator
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn),
                    effect: const WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        activeDotColor: AppColors.linearGreen),
                  ),
                  // Next Button
                  TextButton(
                      onPressed: () => pageController.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeIn),
                      style: TextButton.styleFrom(
                          foregroundColor: AppColors.linearGreen),
                      child: const Text("Next")),
                ],
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = controller.items.length - 1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image),
                  const SizedBox(height: 15),
                  Text(
                    controller.items[index].title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(controller.items[index].descriptions,
                      style: const TextStyle(
                          color: AppColors.logoTextColor, fontSize: 17),
                      textAlign: TextAlign.center),
                ],
              );
            }),
      ),
    );
  }

  // Get started button
  Widget getStarted(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), 
        color: AppColors.linearGreen),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
          onPressed: () async {
            // check user auth
            final authBloc = BlocProvider.of<AuthBloc>(context);
            if (authBloc.state is AuthSuccess) {
              // user auth
              context.go('/home');
            } else {
              // user not auth
              context.go('/account-selection-login');
            }
          },
          child: const Text(
            "Get started",
            style: TextStyle(color: AppColors.lightBackground),
          )),
    );
  }
}
