import 'package:bookstore/core/api/auth_repository.dart';
import 'package:bookstore/core/di/di_container.dart';
import 'package:bookstore/core/models/user.dart';
import 'package:bookstore/shared/components/app_button.dart';
import 'package:bookstore/shared/components/app_text_field.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final AuthRepository _authRepository = locator<AuthRepository>();
  
  late final TextEditingController _emailController;
  late final TextEditingController _nameController;

  User? _user;
  bool _isLoading = true;
  bool _isSaving = false;
  String? _error;

  String _initialEmail = '';
  String _initialName = '';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    
    
    _emailController.addListener(_updateState);
    _nameController.addListener(_updateState);
    
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final user = await _authRepository.getProfile();
    
    if (mounted) {
      setState(() {
        _user = user;
        _isLoading = false;
        
        if (user != null) {
          _initialEmail = user.email;
          _initialName = user.username;
          _emailController.text = user.email;
          _nameController.text = user.username;
        } else {
          _error = 'Failed to load profile';
        }
      });
    }
  }

  void _updateState() {
    setState(() {}); 
  }

  bool get _isChanged {
    return _emailController.text != _initialEmail ||
        _nameController.text != _initialName;
  }

  Future<void> _saveChanges() async {
    if (!_isChanged) return;

    setState(() {
      _isSaving = true;
      _error = null;
    });

    final result = await _authRepository.updateProfile(
      username: _nameController.text != _initialName ? _nameController.text : null,
      email: _emailController.text != _initialEmail ? _emailController.text : null,
    );

    if (mounted) {
      setState(() {
        _isSaving = false;
      });

      if (result.isSuccess && result.user != null) {
        setState(() {
          _user = result.user;
          _initialEmail = result.user!.email;
          _initialName = result.user!.username;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.error ?? 'Failed to update profile'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
            children: [
              AppHeaderWidget(theme: theme, text: 'My account'),
              
              if (_isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_error != null && _user == null)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _error!,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: AppSizes.sizeH16),
                        ElevatedButton(
                          onPressed: _loadProfile,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: AppSizes.sizeW16,
                        left: AppSizes.sizeW16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: AppColors.primary.withOpacity(0.2),
                                  child: Text(
                                    _user?.username.isNotEmpty == true
                                        ? _user!.username[0].toUpperCase()
                                        : 'U',
                                    style: theme.textTheme.headlineLarge?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppSizes.sizeH24),
                          Text('Username', style: theme.textTheme.bodyMedium),
                          SizedBox(height: AppSizes.sizeH4),
                          AppTextField(
                            textFieldWidth: double.infinity,
                            textFieldHeight: AppSizes.constSize46,
                            borderRadius: AppSizes.borderSize16,
                            horizantalPadding: AppSizes.sizeW12,
                            verticalPadding: 1,
                            textLimit: 50,
                            showCursor: true,
                            textAlign: TextAlign.start,
                            controller: _nameController,
                            isNumericInput: false,
                          ),
                          SizedBox(height: AppSizes.sizeH16),
                          Text('Email', style: theme.textTheme.bodyMedium),
                          SizedBox(height: AppSizes.sizeH4),
                          AppTextField(
                            textFieldWidth: double.infinity,
                            textFieldHeight: AppSizes.constSize46,
                            borderRadius: AppSizes.borderSize16,
                            horizantalPadding: AppSizes.sizeW12,
                            verticalPadding: 1,
                            textLimit: 100,
                            showCursor: true,
                            textAlign: TextAlign.start,
                            controller: _emailController,
                            isNumericInput: false,
                          ),
                          SizedBox(height: AppSizes.sizeH24),
                          // Member since info
                          if (_user?.createdAt != null)
                            Container(
                              padding: EdgeInsets.all(AppSizes.constSize16),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(AppSizes.borderSize12),
                                border: Border.all(
                                  color: AppColors.secondary.withOpacity(0.2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: AppColors.secondary,
                                    size: 20,
                                  ),
                                  SizedBox(width: AppSizes.sizeW12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Member since',
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                      Text(
                                        _formatDate(_user!.createdAt!),
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
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
                ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: AppSizes.sizeH34,
            right: AppSizes.sizeW16,
            left: AppSizes.sizeW16,
          ),
          child: AppButton(
            text: _isSaving ? 'Saving...' : 'Save changes',
            borderRadius: AppSizes.borderSize24,
            onPressed: _isChanged && !_isSaving ? _saveChanges : () {},
            buttonWidth: double.infinity,
            buttonHeight: AppSizes.constSize46,
            isEnabled: _isChanged && !_isSaving,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
