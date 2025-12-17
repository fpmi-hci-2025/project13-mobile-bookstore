import 'package:bookstore/core/config/app_routes.dart';
import 'package:bookstore/shared/components/app_box_shadow.dart';
import 'package:bookstore/shared/components/app_button.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AuthPageFooter extends StatelessWidget {
  const AuthPageFooter({super.key, required bool isFormValid})
    : _isFormValid = isFormValid;

  final bool _isFormValid;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [AppBoxShadow.boxShadow()],
        borderRadius: BorderRadius.circular(AppSizes.borderSize24),
      ),
      child: AppButton(
        text: 'Continue',
        onPressed: _isFormValid
            ? () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.registration,
                  (route) => false,
                );
              }
            : () {},
        buttonWidth: double.infinity,
        buttonHeight: AppSizes.constSize46,
        borderRadius: AppSizes.borderSize24,
        isEnabled: _isFormValid,
      ),
    );
  }
}
