import 'package:bookstore/core/config/app_routes.dart';
import 'package:bookstore/shared/components/app_box_shadow.dart';
import 'package:bookstore/shared/components/app_button.dart';
import 'package:bookstore/shared/components/app_title_component.dart';
import 'package:bookstore/shared/constants/app_images.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.only(top: AppSizes.size47H),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSizes.sizeH24),
            AppTitleComponent(
              theme: theme,

              header: 'Select Location',
              description:
                  'Choose a free location to make it easier to\nreceive books',
            ),
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(AppImages.map),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.only(
          right: AppSizes.sizeW16,
          left: AppSizes.sizeW16,
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [AppBoxShadow.boxShadow()],
                borderRadius: BorderRadius.circular(AppSizes.borderSize24),
              ),
              child: AppButton(
                text: 'Use my current location',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.navigation);
                },
                buttonWidth: double.infinity,
                buttonHeight: AppSizes.constSize46,
                borderRadius: AppSizes.borderSize24,
                isEnabled: true,
              ),
            ),
            SizedBox(height: AppSizes.sizeH8),
            Container(
              decoration: BoxDecoration(
                boxShadow: [AppBoxShadow.boxShadow()],
                borderRadius: BorderRadius.circular(AppSizes.borderSize24),
              ),
              child: AppButton(
                text: 'Enter address manually',
                onPressed: () {
                Navigator.pushNamed(context, AppRoutes.selectLocation);
                },
                buttonColor: theme.colorScheme.surface,
                textStyle: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
                buttonWidth: double.infinity,
                buttonHeight: AppSizes.constSize46,
                borderRadius: AppSizes.borderSize24,
                isEnabled: true,
              ),
            ),
            SizedBox(height: AppSizes.sizeH34),
          ],
        ),
      ),
    );
  }
}
