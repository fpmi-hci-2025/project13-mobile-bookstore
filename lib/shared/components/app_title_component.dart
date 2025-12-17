import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AppTitleComponent extends StatelessWidget {
  const AppTitleComponent({
    super.key,
    required this.theme,
    required this.header,
    required this.description,
    this.textStyle
  });

  final ThemeData theme;
  final String header;
  final String description;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSizes.sizeH8,
        right: AppSizes.sizeH16,
        left: AppSizes.sizeH16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style:textStyle ?? theme.textTheme.headlineLarge),
          SizedBox(height: AppSizes.sizeH8),
          Text(
            description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
