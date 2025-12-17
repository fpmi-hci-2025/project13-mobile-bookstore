import 'package:bookstore/features/home/navigation/components/app_navigation_bar_icon.dart';
import 'package:bookstore/shared/components/app_box_shadow.dart';
import 'package:bookstore/shared/constants/app_icons.dart';
import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onItemTapped;
  const NavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          AppBoxShadow.boxShadow(
            color: theme.colorScheme.shadow,
            offset: const Offset(0, -3),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: theme.colorScheme.secondary,
        unselectedItemColor: theme.colorScheme.secondary,
        backgroundColor: theme.colorScheme.surface,
        items: [
          BottomNavigationBarItem(
            icon: AppNavigationBarIcon(
              selectedIndex: selectedIndex,
              index: 0,
              logo: AppIcons.home,
              logoFill: AppIcons.homeFill,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: AppNavigationBarIcon(
              selectedIndex: selectedIndex,
              index: 1,
              logo: AppIcons.category,
              logoFill: AppIcons.categoryFill,
            ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: AppNavigationBarIcon(
              selectedIndex: selectedIndex,
              index: 2,
              logo: AppIcons.profile,
              logoFill: AppIcons.profileFill,
            ),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.secondary,
        ),
        unselectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.secondary,
        ),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
