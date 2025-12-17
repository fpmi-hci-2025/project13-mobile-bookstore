import 'package:bookstore/core/config/app_routes.dart';
import 'package:bookstore/shared/components/app_box_shadow.dart';
import 'package:bookstore/shared/components/app_button.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          AppBoxShadow.boxShadow()
        ],
        borderRadius: BorderRadius.circular(AppSizes.borderSize24),
      ),
      child: AppButton(
        text: 'Get started',
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.auth);
        },
        buttonWidth: double.infinity,
        borderRadius: AppSizes.borderSize24,
        buttonHeight: AppSizes.constSize46,
        isEnabled: true,
      ),
    );
  }
}
