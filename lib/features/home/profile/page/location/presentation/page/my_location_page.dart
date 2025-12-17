import 'package:bookstore/features/home/profile/page/location/presentation/widget/my_location_content_widget.dart';
import 'package:bookstore/shared/constants/app_images.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';

class MyLocationPage extends StatelessWidget {
  const MyLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: AppSizes.size47H),
        child: Column(
          children: [
            AppHeaderWidget(theme: theme, text: 'My location'),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: AppSizes.sizeW16,
                    left: AppSizes.sizeW16,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.borderSize16),
                    child: Image.asset(
                      AppImages.map,
                      width: double.infinity,
                      height: AppSizes.constSize240,
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.sizeH24),
                MyLocationContentWidget(theme: theme),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
