import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/helper/custom_pageroute.dart';
import 'package:shopping/providers/auth.dart';
import 'package:shopping/providers/cart.dart';
import 'package:shopping/providers/orders.dart';
import 'package:shopping/providers/products.dart';
import 'package:shopping/screens/auth_screen.dart';
import 'package:shopping/screens/cart_screen.dart';
import 'package:shopping/screens/edit_product_screen.dart';
import 'package:shopping/screens/order_screen.dart';
import 'package:shopping/screens/product_detail_screen.dart';
import 'package:shopping/screens/products_overview_screen.dart';
import 'package:shopping/screens/splash_screen.dart';
import 'package:shopping/screens/user_products_screen.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ProxyProvider<Auth, Products>(
            update: (context, auth, products) => Products(
                  auth.token,
                  products == null ? [] : products.items,
                  auth.userId,
                )),
        ChangeNotifierProvider(create: (context) => Cart()),
        ProxyProvider<Auth, Orders>(
            update: (context, auth, orders) => Orders(
                auth.token, auth.userId, orders == null ? [] : orders.orders)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Mynew(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrderScreen.routeName: (context) => OrderScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.deepOrangeAccent,
          fontFamily: 'Lato',
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            },
          ),
        ),
      ),
    );
  }
}

class Mynew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    // return ProductsOverViewScreen();
    return auth.isAuth
        ? ProductsOverViewScreen()
        : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx, authResultSnapshot) =>
                authResultSnapshot.connectionState == ConnectionState.waiting
                    ? SplashScreen()
                    : AuthScreen(),
          );
  }
}
