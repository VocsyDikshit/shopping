import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;

class OrderItems extends StatefulWidget {
  final ord.OrderItem order;

  OrderItems(this.order);

  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeIn,
      height: _expanded
          ? min(widget.order.products.length * 20 + 120, 210).toDouble()
          : 110,
      duration: Duration(milliseconds: 300),
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "\$${widget.order.amount.toStringAsFixed(2)}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  DateFormat('dd/mm/yyyy hh:mm').format(widget.order.datetime)),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  icon:
                      Icon(_expanded ? Icons.expand_less : Icons.expand_more)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedContainer(
                height: _expanded
                    ? min(widget.order.products.length * 20 + 10, 100)
                        .toDouble()
                    : 0,
                duration: Duration(milliseconds: 300),
                child: ListView(
                  children: widget.order.products
                      .map((prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prod.title,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${prod.quantity} x ${prod.price}\$',
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.grey),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
