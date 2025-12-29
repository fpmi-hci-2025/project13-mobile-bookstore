import 'package:bookstore/shared/components/app_box_shadow.dart';
import 'package:bookstore/shared/components/app_text_field.dart';
import 'package:bookstore/shared/constants/app_constants.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AuthContent extends StatelessWidget {
  final ThemeData theme;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isEmailValid;
  final bool isPasswordVisible;
  final VoidCallback onTogglePassword;

  const AuthContent({
    super.key,
    required this.theme,
    required this.emailController,
    required this.passwordController,
    required this.isEmailValid,
    required this.isPasswordVisible,
    required this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        Text('Email', style: theme.textTheme.bodyLarge),
        SizedBox(height: AppSizes.sizeH8),
    
        Container(
          decoration: BoxDecoration(
            boxShadow: [AppBoxShadow.boxShadow()],
            borderRadius: BorderRadius.circular(AppSizes.borderSize16),
          ),
          child: AppTextField(
            borderColor: isEmailValid
                ? theme.colorScheme.secondary.withOpacity(0.5)
                : Colors.red,
            placeholderText: 'Your email',
            textFieldWidth: double.infinity,
            textFieldHeight: 46,
            borderRadius: AppSizes.borderSize16,
            horizantalPadding: AppSizes.constSize12,
            verticalPadding: 1,
            textLimit: AppConstants.textLimit150,
            showCursor: true,
            textAlign: TextAlign.start,
            controller: emailController,
            isNumericInput: false,
          ),
        ),
    
        if (!isEmailValid)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              'Invalid email format',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
    
        SizedBox(height: AppSizes.sizeH16),
    
       
        Text('Password', style: theme.textTheme.bodyLarge),
        SizedBox(height: AppSizes.sizeH8),
    
        Container(
          decoration: BoxDecoration(
            boxShadow: [AppBoxShadow.boxShadow()],
            borderRadius: BorderRadius.circular(AppSizes.borderSize16),
          ),
          child: AppTextField(
            borderColor: theme.colorScheme.secondary.withOpacity(0.5),
            placeholderText: 'Your password',
            textFieldWidth: double.infinity,
            textFieldHeight: AppSizes.constSize46,
            borderRadius: AppSizes.borderSize16,
            horizantalPadding: AppSizes.constSize12,
            verticalPadding: 1,
            textLimit: AppConstants.textLimit150,
            showCursor: true,
            textAlign: TextAlign.start,
            controller: passwordController,
            isNumericInput: false,
            maxLines: 1,
            obscureText: !isPasswordVisible,
            showSuffixIcon: true,
            suffixWidget: GestureDetector(
              onTap: onTogglePassword,
              child: Icon(
                isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: isPasswordVisible
                    ? theme.colorScheme.primary
                    : theme.colorScheme.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
