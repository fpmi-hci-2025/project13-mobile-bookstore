import 'package:bookstore/features/home/home/presentation/components/header.dart';
import 'package:bookstore/features/home/home/presentation/widget/home_content_widget.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.sizeW24,
            vertical: AppSizes.sizeH24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(theme: theme),
              SizedBox(height: AppSizes.sizeH24),
              HomeContentWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
