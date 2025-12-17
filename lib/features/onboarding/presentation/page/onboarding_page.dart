import 'package:bookstore/features/onboarding/data/onboarding_data.dart';
import 'package:bookstore/features/onboarding/presentation/widget/onboarding_content.dart';
import 'package:bookstore/features/onboarding/presentation/widget/onboarding_footer.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: AppSizes.constSize150,
          right: AppSizes.sizeW16,
          left: AppSizes.sizeW16,
          bottom: AppSizes.sizeH34,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OnboardingContent(
              pageController: _pageController,
              onboardingData: OnboardingData.onboardingData,
              currentPage: currentPage,
            ),
             SizedBox(height: AppSizes.sizeH20),
            OnboardingFooter(),
          ],
        ),
      ),
    );
  }
}
