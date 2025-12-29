import 'package:bookstore/shared/components/app_box_shadow.dart';
import 'package:bookstore/shared/components/app_text_field.dart';
import 'package:bookstore/shared/constants/app_constants.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class RegistrationContentWidget extends StatelessWidget {
  const RegistrationContentWidget({
    super.key,
    required this.theme,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
  }) : _firstNameController = firstNameController, _lastNameController = lastNameController;

  final ThemeData theme;
  final TextEditingController _firstNameController;
  final TextEditingController _lastNameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: AppSizes.sizeW16,
        top: AppSizes.sizeH34,
        left: AppSizes.sizeW16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('First name', style: theme.textTheme.bodyLarge),
          SizedBox(height: AppSizes.sizeH8),
          Container(
            decoration: BoxDecoration(
              boxShadow: [AppBoxShadow.boxShadow()],
              borderRadius: BorderRadius.circular(
                AppSizes.borderSize16,
              ),
            ),
            child: AppTextField(
              borderColor: theme.colorScheme.secondary.withOpacity(
                0.5,
              ),
              placeholderText: 'Enter first name',
              textFieldWidth: double.infinity,
              textFieldHeight: 46,
              borderRadius: AppSizes.borderSize16,
              horizantalPadding: AppSizes.constSize12,
              verticalPadding: 1,
              textLimit: AppConstants.textLimit150,
              showCursor: true,
              textAlign: TextAlign.start,
              controller: _firstNameController,
              isNumericInput: false,
            ),
          ),
          SizedBox(height: AppSizes.sizeH16),
          Text('Last name', style: theme.textTheme.bodyLarge),
          SizedBox(height: AppSizes.sizeH8),
          Container(
            decoration: BoxDecoration(
              boxShadow: [AppBoxShadow.boxShadow()],
              borderRadius: BorderRadius.circular(
                AppSizes.borderSize16,
              ),
            ),
            child: AppTextField(
              borderColor: theme.colorScheme.secondary.withOpacity(
                0.5,
              ),
              placeholderText: 'Enter last name',
              textFieldWidth: double.infinity,
              textFieldHeight: AppSizes.constSize46,
              borderRadius: AppSizes.borderSize16,
              horizantalPadding: AppSizes.constSize12,
              verticalPadding: 1,
              textLimit: AppConstants.textLimit150,
              showCursor: true,
              textAlign: TextAlign.start,
              controller: _lastNameController,
              isNumericInput: false,
            ),
          ),
          SizedBox(height: AppSizes.sizeH16),
          Text(
            'By creating a new account you agree to ',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
          Text(
            'Terms of Services & Privacy Policy',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          SizedBox(height: AppSizes.sizeH24),
        ],
      ),
    );
  }
}
