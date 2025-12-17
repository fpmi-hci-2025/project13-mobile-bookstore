import 'package:bookstore/shared/components/app_button.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.constSize20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderSize24),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white.withOpacity(0.85)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Special Offer',
                  style: theme.textTheme.bodyMedium?.copyWith(),
                ),
               SizedBox(height: AppSizes.sizeH4),
                Text(
                  'Discount 25%',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
               Spacer(),
                AppButton(
                  text: 'Buy',
                  onPressed: () {},
                  buttonWidth: AppSizes.sizeW111,
                  buttonHeight: AppSizes.constSize40,
                  isEnabled: true,
                  borderRadius: AppSizes.borderSize24,
                ),
              ],
            ),
          ),
          SizedBox(width: AppSizes.sizeW16),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.borderSize16),
            child: Image.network(
              'https://images.unsplash.com/photo-1507842217343-583bb7270b66?auto=format&fit=crop&w=160&q=80',
              width:AppSizes.sizeW103 ,
              height: AppSizes.sizeH120,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
