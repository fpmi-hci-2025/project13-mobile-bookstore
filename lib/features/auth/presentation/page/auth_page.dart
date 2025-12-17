import 'package:bookstore/features/auth/presentation/widget/auth_content.dart';
import 'package:bookstore/features/auth/presentation/widget/auth_page_footer.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/components/app_title_component.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool _isPasswordVisible = false;
  bool _isEmailValid = true;

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
      });
    });

    _passwordController.addListener(() => setState(() {}));
  }

  bool get _isFormValid {
    return _emailRegExp.hasMatch(_emailController.text.trim()) &&
        _passwordController.text.isNotEmpty;
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
                    SizedBox(height: AppSizes.sizeH34),
                    AuthPageFooter(isFormValid: _isFormValid),
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
