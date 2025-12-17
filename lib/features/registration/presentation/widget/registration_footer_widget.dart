import 'package:bookstore/core/config/app_routes.dart';
import 'package:bookstore/shared/components/app_box_shadow.dart';
import 'package:bookstore/shared/components/app_button.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class RegistrationFooterWidget extends StatelessWidget {
  const RegistrationFooterWidget({
    super.key,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
  }) : _firstNameController = firstNameController, _lastNameController = lastNameController;

  final TextEditingController _firstNameController;
  final TextEditingController _lastNameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        right: AppSizes.sizeW16,
        left: AppSizes.sizeW16,
      ),
    
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [AppBoxShadow.boxShadow()],
              borderRadius: BorderRadius.circular(AppSizes.borderSize24),
            ),
            child: AppButton(
              text: 'Register',
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.location);
              },
              buttonWidth: double.infinity,
              buttonHeight: AppSizes.constSize46,
              borderRadius: AppSizes.borderSize24,
              isEnabled:
                  _firstNameController.text.isNotEmpty &&
                  _lastNameController.text.isNotEmpty,
            ),
          ),
          SizedBox(height: AppSizes.sizeH34),
        ],
      ),
    );
  }
}
