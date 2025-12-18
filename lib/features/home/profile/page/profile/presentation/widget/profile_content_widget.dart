import 'package:bookstore/core/api/auth_repository.dart';
import 'package:bookstore/core/config/app_routes.dart';
import 'package:bookstore/core/di/di_container.dart';
import 'package:bookstore/core/models/user.dart';
import 'package:bookstore/features/home/profile/page/profile/presentation/component/menu_item.dart';
import 'package:bookstore/shared/constants/app_icons.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class ProfileContentWidget extends StatefulWidget {
  const ProfileContentWidget({super.key, required this.theme});

  final ThemeData theme;

  @override
  State<ProfileContentWidget> createState() => _ProfileContentWidgetState();
}

class _ProfileContentWidgetState extends State<ProfileContentWidget> {
  final AuthRepository _authRepository = locator<AuthRepository>();
  
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = await _authRepository.getProfile();
    if (mounted) {
      setState(() {
        _user = user;
        _isLoading = false;
      });
    }
  }

  Future<void> _handleLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _authRepository.logout();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.auth,
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile',
          style: widget.theme.textTheme.headlineLarge?.copyWith(
            color: widget.theme.colorScheme.onPrimary,
          ),
        ),

        SizedBox(height: AppSizes.sizeH32),
        
        // User Info Section
        _buildUserInfoSection(),
        
        SizedBox(height: AppSizes.sizeH32),

        MenuItem(
          icon: Icons.person_outline,
          title: 'My Account',
          theme: widget.theme,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.myAccount);
          },
        ),
        SizedBox(height: AppSizes.sizeH16),
        MenuItem(
          icon: null,
          svgIcon: AppIcons.location,
          title: 'Address',
          theme: widget.theme,
          onTap: () {
             Navigator.pushNamed(context, AppRoutes.myLocation);
          },
        ),
        SizedBox(height: AppSizes.sizeH16),
        MenuItem(
          icon: Icons.favorite_outline,
          title: 'Your Favorites',
          theme: widget.theme,
          onTap: () {
             Navigator.pushNamed(context, AppRoutes.favorite);
          },
        ),
        SizedBox(height: AppSizes.sizeH16),
        MenuItem(
          icon: Icons.history,
          title: 'Order History',
          theme: widget.theme,
          onTap: () {
             Navigator.pushNamed(context, AppRoutes.order);
          },
        ),
        SizedBox(height: AppSizes.sizeH16),
        
        // Logout button
        MenuItem(
          icon: Icons.logout,
          title: 'Logout',
          theme: widget.theme,
          onTap: _handleLogout,
          textColor: Colors.red,
          iconColor: Colors.red,
        ),
      ],
    );
  }

  Widget _buildUserInfoSection() {
    if (_isLoading) {
      return Container(
        padding: EdgeInsets.all(AppSizes.sizeW16),
        decoration: BoxDecoration(
          color: widget.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.borderSize16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: widget.theme.colorScheme.secondary.withOpacity(0.2),
              child: Icon(
                Icons.person,
                size: 30,
                color: widget.theme.colorScheme.secondary,
              ),
            ),
            SizedBox(width: AppSizes.sizeW16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 16,
                  decoration: BoxDecoration(
                    color: widget.theme.colorScheme.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 160,
                  height: 12,
                  decoration: BoxDecoration(
                    color: widget.theme.colorScheme.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(AppSizes.sizeW16),
      decoration: BoxDecoration(
        color: widget.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.borderSize16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: widget.theme.colorScheme.primary.withOpacity(0.1),
            child: Text(
              _user?.username.isNotEmpty == true 
                  ? _user!.username[0].toUpperCase() 
                  : '?',
              style: widget.theme.textTheme.headlineMedium?.copyWith(
                color: widget.theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: AppSizes.sizeW16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _user?.username ?? 'Guest',
                  style: widget.theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: widget.theme.colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _user?.email ?? '',
                  style: widget.theme.textTheme.bodySmall?.copyWith(
                    color: widget.theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
