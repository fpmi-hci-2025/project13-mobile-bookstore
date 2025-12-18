import 'package:bookstore/core/api/auth_repository.dart';
import 'package:bookstore/core/config/app_routes.dart';
import 'package:bookstore/core/di/di_container.dart';
import 'package:bookstore/shared/components/app_box_shadow.dart';
import 'package:bookstore/shared/components/app_button.dart';
import 'package:bookstore/shared/components/app_text_field.dart';
import 'package:bookstore/shared/components/app_title_component.dart';
import 'package:bookstore/shared/constants/app_constants.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final AuthRepository _authRepository = locator<AuthRepository>();

  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;

  final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _usernameController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
    _confirmPasswordController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {
      _errorMessage = null;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _isEmailValid {
    final email = _emailController.text.trim();
    return email.isEmpty || _emailRegExp.hasMatch(email);
  }

  bool get _isPasswordMatch {
    return _passwordController.text == _confirmPasswordController.text;
  }

  bool get _isFormValid {
    return _usernameController.text.trim().isNotEmpty &&
        _emailRegExp.hasMatch(_emailController.text.trim()) &&
        _passwordController.text.length >= 6 &&
        _isPasswordMatch;
  }

  Future<void> _handleRegister() async {
    if (!_isFormValid || _isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _authRepository.register(
      _usernameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (result.isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.navigation,
        (route) => false,
      );
    } else {
      setState(() {
        _errorMessage = result.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: AppSizes.size47H),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeaderWidget(
                  theme: theme,
                  text: '',
                  showButton: true,
                  backFunction: () => Navigator.pop(context),
                  buttonColor: AppColors.background,
                ),
                AppTitleComponent(
                  theme: theme,
                  header: 'Create your account',
                  description: 'Fill in the details to get started',
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: AppSizes.sizeW16,
                    top: AppSizes.sizeH24,
                    left: AppSizes.sizeW16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Username field
                      _buildField(
                        theme: theme,
                        label: 'Username',
                        placeholder: 'Enter your username',
                        controller: _usernameController,
                      ),
                      SizedBox(height: AppSizes.sizeH16),
                      
                      // Email field
                      _buildField(
                        theme: theme,
                        label: 'Email',
                        placeholder: 'Enter your email',
                        controller: _emailController,
                        isValid: _isEmailValid,
                        errorText: !_isEmailValid ? 'Invalid email format' : null,
                      ),
                      SizedBox(height: AppSizes.sizeH16),
                      
                      // Password field
                      _buildField(
                        theme: theme,
                        label: 'Password',
                        placeholder: 'At least 6 characters',
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        suffixIcon: GestureDetector(
                          onTap: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                          child: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: _isPasswordVisible
                                ? theme.colorScheme.primary
                                : theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSizes.sizeH16),
                      
                      // Confirm Password field
                      _buildField(
                        theme: theme,
                        label: 'Confirm Password',
                        placeholder: 'Repeat your password',
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        isValid: _confirmPasswordController.text.isEmpty || _isPasswordMatch,
                        errorText: _confirmPasswordController.text.isNotEmpty && !_isPasswordMatch
                            ? 'Passwords do not match'
                            : null,
                        suffixIcon: GestureDetector(
                          onTap: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                          child: Icon(
                            _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: _isConfirmPasswordVisible
                                ? theme.colorScheme.primary
                                : theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: AppSizes.sizeH16),
                      
                      // Terms text
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
                      
                      // Error message
                      if (_errorMessage != null) ...[
                        SizedBox(height: AppSizes.sizeH16),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(AppSizes.constSize12),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppSizes.borderSize8),
                            border: Border.all(color: Colors.red.withOpacity(0.3)),
                          ),
                          child: Text(
                            _errorMessage!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      
                      SizedBox(height: AppSizes.sizeH24),
                      
                      // Register button
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [AppBoxShadow.boxShadow()],
                          borderRadius: BorderRadius.circular(AppSizes.borderSize24),
                        ),
                        child: AppButton(
                          text: _isLoading ? 'Creating account...' : 'Register',
                          onPressed: _isFormValid && !_isLoading ? _handleRegister : () {},
                          buttonWidth: double.infinity,
                          buttonHeight: AppSizes.constSize46,
                          borderRadius: AppSizes.borderSize24,
                          isEnabled: _isFormValid && !_isLoading,
                        ),
                      ),
                      
                      SizedBox(height: AppSizes.sizeH16),
                      
                      // Login link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              'Sign In',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: AppSizes.sizeH34),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required ThemeData theme,
    required String label,
    required String placeholder,
    required TextEditingController controller,
    bool obscureText = false,
    bool isValid = true,
    String? errorText,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodyLarge),
        SizedBox(height: AppSizes.sizeH8),
        Container(
          decoration: BoxDecoration(
            boxShadow: [AppBoxShadow.boxShadow()],
            borderRadius: BorderRadius.circular(AppSizes.borderSize16),
          ),
          child: AppTextField(
            borderColor: isValid
                ? theme.colorScheme.secondary.withOpacity(0.5)
                : Colors.red,
            placeholderText: placeholder,
            textFieldWidth: double.infinity,
            textFieldHeight: AppSizes.constSize46,
            borderRadius: AppSizes.borderSize16,
            horizantalPadding: AppSizes.constSize12,
            verticalPadding: 1,
            textLimit: AppConstants.textLimit150,
            showCursor: true,
            textAlign: TextAlign.start,
            controller: controller,
            isNumericInput: false,
            maxLines: 1,
            obscureText: obscureText,
            showSuffixIcon: suffixIcon != null,
            suffixWidget: suffixIcon,
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              errorText,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
