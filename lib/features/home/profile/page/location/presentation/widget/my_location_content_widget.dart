import 'package:bookstore/core/config/app_routes.dart';
import 'package:bookstore/shared/components/app_button.dart';
import 'package:bookstore/shared/constants/app_icons.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyLocationContentWidget extends StatelessWidget {
  const MyLocationContentWidget({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.borderSize16),
          topRight: Radius.circular(AppSizes.borderSize16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.10),
            offset: const Offset(0, 4),
            blurRadius: 24,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: AppSizes.sizeW16,
          left: AppSizes.sizeW16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSizes.sizeH16),
            Center(
              child: Container(
                width: AppSizes.sizeW50,
                height: AppSizes.constSize5,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(
                    AppSizes.borderSize4,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSizes.sizeH16),
            Row(
              children: [
                Text(
                  'Detail adress',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                SvgPicture.asset(AppIcons.detail),
              ],
            ),
            SizedBox(height: AppSizes.sizeH24),
            Row(
              children: [
                Container(
                  width: AppSizes.constSize40,
                  height: AppSizes.constSize40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppIcons.location,
                      width: AppSizes.constSize20,
                      height: AppSizes.constSize20,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: AppSizes.sizeW16),
                Text(
                  'Street',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.sizeH16),
            Container(
              width: double.infinity,
              height: 1,
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary.withOpacity(0.4),
                borderRadius: BorderRadius.circular(
                  AppSizes.borderSize4,
                ),
              ),
            ),
            SizedBox(height: AppSizes.sizeH240),
            AppButton(
              text: 'Change location',
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.selectLocation);
              },
              borderRadius: AppSizes.borderSize24,
              buttonWidth: double.infinity,
              buttonHeight: AppSizes.constSize46,
              isEnabled: true,
            ),
            SizedBox(height: AppSizes.constSize34),
          ],
        ),
      ),
    );
  }
}
