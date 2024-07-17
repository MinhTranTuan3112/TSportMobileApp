import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/models/account_details.dart';
import 'package:tsport_mobile_app/models/basic_account.dart';
import 'package:tsport_mobile_app/models/paged_order.dart';
import 'package:tsport_mobile_app/models/pagedresult.dart';
import 'package:tsport_mobile_app/services/account_service.dart';
import 'package:tsport_mobile_app/services/order_service.dart';
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
  BasicAccount? _account;
  final PagingController<int, PagedOrder> _pagingController =
      PagingController(firstPageKey: 1);
  static const _pageSize = 4;

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

  Future fetchProfileInfo() async {
    final account = await AccountService().fetchBasicAccountInfo();
    setState(() {
      _account = account;
    });
  }

  // Future fetchPagedOrders(int pageKey) async {
  //   try {
  //     final orderService = OrderService();
  //     final newItems = await orderService.fetchOrders(
  //         pageKey, _pageSize, _account?.id, null);

  //     return newItems;
  //   } catch (error) {
  //     final errorMessage =
  //         error is HttpException ? error.message : 'An unknown error occurred';
  //     return [];
  //   }
  // }

  Future fetchPagedOrders(int pageKey) async {
    final account = await AccountService().fetchBasicAccountInfo();
    setState(() {
      _account = account;
    });
    try {
      final orderService = OrderService();
      final newItems =
          await orderService.fetchOrders(pageKey, _pageSize, account?.id, null);

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
    final statuses = ["Đã giao", "Đang giao", "Đã hủy"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...statuses.map((status) => OrderStatusButton(status: status)),
      ],
    );
  }

  Widget orderList() {
    // // Check if the orders list is not empty
    // if (_account?.orders != null && _account!.orders.isNotEmpty) {
    //   return Column(
    //     children: [
    //       // Map through the orders and display them
    //       ..._account!.orders.map((order) => OrderCard(order: order)),
    //     ],
    //   );
    // }

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
            noItemsFoundIndicatorBuilder: (context) => const EmptyIndicator(),
          ),
        ),
      );
    }

    return const Center(
      child: Text('Không có đơn hàng nào'),
    );
  }
}

class ErrorIndicator extends StatelessWidget {
  final String message;
  final VoidCallback onTryAgain;

  const ErrorIndicator(
      {required this.message, required this.onTryAgain, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onTryAgain,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}

class EmptyIndicator extends StatelessWidget {
  const EmptyIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No items found'),
    );
  }
}
