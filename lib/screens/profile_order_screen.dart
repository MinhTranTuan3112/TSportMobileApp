import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/models/account_details.dart';
import 'package:tsport_mobile_app/models/basic_account.dart';
import 'package:tsport_mobile_app/models/paged_order.dart';
import 'package:tsport_mobile_app/models/pagedresult.dart';
import 'package:tsport_mobile_app/services/account_service.dart';
import 'package:tsport_mobile_app/services/order_service.dart';
import '../widgets/empty_indicator.dart';
import '../widgets/error_indicator.dart';
import '../widgets/order_card.dart';
import '../widgets/order_status_button.dart';
// ignore: depend_on_referenced_packages
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProfileOrderScreen extends StatefulWidget {
  const ProfileOrderScreen({super.key});

  @override
  State<ProfileOrderScreen> createState() => _ProfileOrderScreenState();
}

class _ProfileOrderScreenState extends State<ProfileOrderScreen> {
  final PagingController<int, PagedOrder> _pagingController =
      PagingController(firstPageKey: 1);
  static const _pageSize = 4;
  String _orderStatus = "Pending";

  bool isAuthenticated = (Supabase.instance.client.auth.currentUser != null);

  @override
  void initState() {
    super.initState();
    if (isAuthenticated) {
      _pagingController.addPageRequestListener((pageKey) async {
        await fetchPagedOrders(pageKey);
      });
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future fetchPagedOrders(int pageKey, [String? orderStatus]) async {
    final account = await AccountService().fetchBasicAccountInfo();
    
    setState(() {
      _orderStatus = orderStatus ?? _orderStatus;
    });

    try {
      final orderService = OrderService();
      final newItems = await orderService.fetchOrders(
          pageKey, _pageSize, account?.id, _orderStatus);

      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      final errorMessage =
          error is HttpException ? error.message : 'An unknown error occurred';
      _pagingController.error = errorMessage;
    }
  }

  void updateOrderStatusAndRefresh(String? status) {

    setState(() {
      _orderStatus = status ?? _orderStatus; // Update the order status
    });

    _pagingController.refresh(); // Trigger a refresh of the orders list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Đơn hàng của tôi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))),
      body: bodyContent(),
    );
  }

  Widget bodyContent() {
    return Column(
      children: [
        const SizedBox(height: 20),
        statusBar(),
        const SizedBox(height: 20),
        orderList()
      ],
    );
  }

  Widget statusBar() {
    final statuses = ["Pending", "Processed", "Cancelled"];
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...statuses.map((status) => OrderStatusButton(
                status: status,
                isActive: _orderStatus == status,
                onPressed: () => updateOrderStatusAndRefresh(status),
              )),
        ],
      ),
    );
  }

  Widget orderList() {
    
    if (isAuthenticated) {
      return Expanded(
        child: PagedListView<int, PagedOrder>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<PagedOrder>(
            itemBuilder: (context, order, index) => OrderCard(order: order),
            firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
              message: 'Failed to load orders',
              onTryAgain: () => _pagingController.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (context) => const EmptyIndicator(message: 'Không có đơn hàng',),
          ),
        ),
      );
    }

    return const Center(
      child: Text('Không có đơn hàng nào'),
    );
  }
}
