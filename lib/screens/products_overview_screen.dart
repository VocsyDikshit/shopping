import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/cart.dart';
import 'package:shopping/providers/products.dart';
import 'package:shopping/screens/cart_screen.dart';
import 'package:shopping/widgets/app_drawer.dart';
import 'package:shopping/widgets/products_grid.dart';

enum FilterOptions { Favourite, All }

class ProductsOverViewScreen extends StatefulWidget {
  @override
  _ProductsOverViewScreenState createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  var _showOnlyFavourits = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProduct().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 5.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              child: Consumer<Cart>(
                builder: (_, cart, child) => Badge(
                  child: child,
                  animationType: BadgeAnimationType.slide,
                  badgeContent: Text(
                    cart.itemCount.toString(),
                  ),
                ),
                child: Icon(Icons.shopping_cart_rounded),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(
                  () {
                    if (selectedValue == FilterOptions.Favourite) {
                      _showOnlyFavourits = true;
                    } else {
                      _showOnlyFavourits = false;
                    }
                  },
                );
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                    child: Text("Only Favourite Item"),
                    value: FilterOptions.Favourite),
                PopupMenuItem(child: Text("Show All"), value: FilterOptions.All)
              ],
            ),
          ),
        ],
        title: Text(
          "My Shop",
        ),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavourits),
    );
  }
}
