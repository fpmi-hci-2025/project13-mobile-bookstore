import 'package:bookstore/features/home/profile/page/profile/presentation/widget/profile_content_widget.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.sizeW16,
              vertical: AppSizes.sizeH16,
            ),
            child: ProfileContentWidget(theme: theme),
          ),
        ),
      ),
    );
  }
}
