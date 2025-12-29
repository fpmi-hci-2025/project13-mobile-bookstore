import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Profile Picture
        CircleAvatar(
          radius: AppSizes.borderSize32,
          backgroundImage: const NetworkImage(
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
          ),
        ),
         SizedBox(width: AppSizes.sizeW16),
        // User Name
        Expanded(
          child: Text(
            'John Doe',
            style: theme.textTheme.headlineLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontSize: 22
            ),
          ),
        ),
       
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Logout',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
