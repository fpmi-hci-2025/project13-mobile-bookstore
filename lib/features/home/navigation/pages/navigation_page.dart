import 'package:bookstore/features/home/cart/bloc/baske_bloc.dart';
import 'package:bookstore/features/home/cart/bloc/basket_event.dart';
import 'package:bookstore/features/home/cart/cart_page.dart';
import 'package:bookstore/features/home/category/category_page.dart';
import 'package:bookstore/features/home/home/presentation/page/home_page.dart';
import 'package:bookstore/features/home/profile/page/profile/presentation/page/profile_page.dart';
import 'package:bookstore/features/home/navigation/widget/navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  NavigationPageState createState() => NavigationPageState();
}

class NavigationPageState extends State<NavigationPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<BasketBloc>().add(LoadBasket());
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            IndexedStack(
              index: selectedIndex,
              children: [HomePage(), const CategoryPage(), const ProfilePage()],
            ),
          ],
        ),
        bottomNavigationBar: NavigationBarWidget(
          selectedIndex: selectedIndex,
          onItemTapped: onItemTapped,
        ),
      ),
    );
  }
}
