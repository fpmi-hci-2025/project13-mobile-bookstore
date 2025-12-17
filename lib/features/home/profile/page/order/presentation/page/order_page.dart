import 'package:bookstore/core/api/order_repository.dart';
import 'package:bookstore/core/di/di_container.dart';
import 'package:bookstore/core/models/order_item.dart';
import 'package:bookstore/features/home/profile/page/order/presentation/widget/order_content_widget.dart';
import 'package:bookstore/shared/constants/app_sizes.dart';
import 'package:bookstore/shared/widgets/app_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final OrderRepository _orderRepository = locator<OrderRepository>();
  
  List<Order> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() => _isLoading = true);
    
    final orders = await _orderRepository.getOrders();
    
    if (mounted) {
      setState(() {
        _orders = orders;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: AppSizes.size47H),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeaderWidget(theme: theme, text: 'Order History'),
            Expanded(
              child: _isLoading
                  ? _buildShimmerList()
                  : _orders.isEmpty
                      ? _buildEmptyState(theme)
                      : RefreshIndicator(
                          onRefresh: _loadOrders,
                          child: OrderContentWidget(
                            orders: _orders,
                            theme: theme,
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.sizeW16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => SizedBox(height: AppSizes.sizeH8),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: theme.colorScheme.secondary.withOpacity(0.5),
          ),
          SizedBox(height: AppSizes.sizeH16),
          Text(
            'No orders yet',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
          SizedBox(height: AppSizes.sizeH8),
          Text(
            'Start shopping to see your orders here',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.secondary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
