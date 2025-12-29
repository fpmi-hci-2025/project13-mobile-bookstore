import 'package:bookstore/core/api/auth_repository.dart';
import 'package:bookstore/core/config/app_routes.dart';
import 'package:bookstore/core/di/di_container.dart';
import 'package:bookstore/features/auth/presentation/widget/auth_content.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/components/app_title_component.dart';
import 'package:bookstore/shared/components/app_box_shadow.dart';
import 'package:bookstore/shared/components/app_button.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthRepository _authRepository = locator<AuthRepository>();
  
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool _isPasswordVisible = false;
  bool _isEmailValid = true;
  bool _isLoading = false;
  String? _errorMessage;

  final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.addListener(() {
      final email = _emailController.text.trim();
      final isValid = _emailRegExp.hasMatch(email);

      setState(() {
        _isEmailValid = isValid || email.isEmpty;
        _errorMessage = null;
      });
    });

    _passwordController.addListener(() {
      setState(() {
        _errorMessage = null;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    return _emailRegExp.hasMatch(_emailController.text.trim()) &&
        _passwordController.text.isNotEmpty;
  }

  Future<void> _handleLogin() async {
    if (!_isFormValid || _isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _authRepository.login(
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

  void _goToRegistration() {
    Navigator.pushNamed(context, AppRoutes.registration);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: AppSizes.size47H),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeaderWidget(theme: theme, text: ''),
              AppTitleComponent(
                theme: theme,
                header: 'Welcome to bookstore!',
                description:
                    'Access your account by entering your email\nand password',
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: AppSizes.sizeW16,
                  top: AppSizes.sizeH34,
                  left: AppSizes.sizeW16,
                ),
                child: Column(
                  children: [
                    AuthContent(
                      theme: theme,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      isEmailValid: _isEmailValid,
                      isPasswordVisible: _isPasswordVisible,
                      onTogglePassword: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
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
                    
                    SizedBox(height: AppSizes.sizeH34),
                    
                    // Login button
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [AppBoxShadow.boxShadow()],
                        borderRadius: BorderRadius.circular(AppSizes.borderSize24),
                      ),
                      child: AppButton(
                        text: _isLoading ? 'Loading...' : 'Sign In',
                        onPressed: _isFormValid && !_isLoading ? _handleLogin : () {},
                        buttonWidth: double.infinity,
                        buttonHeight: AppSizes.constSize46,
                        borderRadius: AppSizes.borderSize24,
                        isEnabled: _isFormValid && !_isLoading,
                      ),
                    ),
                    
                    SizedBox(height: AppSizes.sizeH16),
                    
                    // Register link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: _goToRegistration,
                          child: Text(
                            'Sign Up',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
