import 'package:bookstore/shared/components/app_page_indicator.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  final PageController pageController;
  final List<Map<String, String>> onboardingData;
  final double currentPage;

  const OnboardingContent({
    super.key,
    required this.pageController,
    required this.onboardingData,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        onboardingData[index]['image']!,
                        width: 320,
                        height: 320,
                      ),
                    ),
                   SizedBox(height: AppSizes.sizeH16),
                    Text(
                      onboardingData[index]['title']!,
                      style: theme.textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                     SizedBox(height: AppSizes.sizeH8),
                    Text(
                      onboardingData[index]['description']!,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
          AppPageIndicator(
            currentPage: currentPage,
            totalPages: onboardingData.length,
            dotsSize: 6,
          ),
        ],
      ),
    );
  }
}
