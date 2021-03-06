import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/orders.dart' show Orders;
import 'package:shopping/widgets/app_drawer.dart';
import 'package:shopping/widgets/order_item.dart';

import '../providers/orders.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;

  @override
  void initState() {
    _isLoading = true;

    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<Orders>(context, listen: false)
          .fetchAndSetOrders()
          .then(
        ((_) {
          setState(() {
            _isLoading = false;
          });
        }),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Ordered"),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orders.orders.length,
              itemBuilder: (ctx, i) => OrderItems(orders.orders[i]),
            ),
    );
  }
}
