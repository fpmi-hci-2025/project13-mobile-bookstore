import 'package:bookstore/core/config/app_routes.dart';
import 'package:bookstore/features/home/profile/page/profile/presentation/component/menu_item.dart';
import 'package:bookstore/features/home/profile/page/profile/presentation/component/user_info_section.dart';
import 'package:bookstore/shared/constants/app_icons.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class ProfileContentWidget extends StatelessWidget {
  const ProfileContentWidget({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile',
          style: theme.textTheme.headlineLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),

        SizedBox(height: AppSizes.sizeH32),
        // User Info Section
        UserInfoSection(theme: theme),
        SizedBox(height: AppSizes.sizeH32),

        MenuItem(
          icon: Icons.person_outline,
          title: 'My Account',
          theme: theme,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.myAccount);
          },
        ),
        SizedBox(height: AppSizes.sizeH16),
        MenuItem(
          icon: null,
          svgIcon: AppIcons.location,
          title: 'Address',
          theme: theme,
          onTap: () {
             Navigator.pushNamed(context, AppRoutes.myLocation);
          },
        ),
        SizedBox(height: AppSizes.sizeH16),
        MenuItem(
          icon: Icons.favorite_outline,
          title: 'Your Favorites',
          theme: theme,
          onTap: () {
             Navigator.pushNamed(context, AppRoutes.favorite);
          },
        ),
        SizedBox(height: AppSizes.sizeH16),
        MenuItem(
          icon: Icons.history,
          title: 'Order History',
          theme: theme,
          onTap: () {
             Navigator.pushNamed(context, AppRoutes.order);
          },
        ),
      ],
    );
  }
}
