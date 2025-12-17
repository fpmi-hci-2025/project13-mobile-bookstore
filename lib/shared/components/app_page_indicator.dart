import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class AppPageIndicator extends StatelessWidget {
  final double currentPage;
  final int totalPages;
  final Color? activeDotsColor;
  final Color? dotsColor;
  final double dotsSize;

  const AppPageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.activeDotsColor,
    this.dotsColor,
    required this.dotsSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DotsIndicator(
      dotsCount: totalPages,
      position: currentPage,
      decorator: DotsDecorator(
        size: Size(dotsSize, dotsSize),
        activeSize: Size(dotsSize, dotsSize),
        color: dotsColor ?? theme.colorScheme.secondary,
        activeColor: activeDotsColor ?? theme.colorScheme.primary,
      ),
    );
  }
}
