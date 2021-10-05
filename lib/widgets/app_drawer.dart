import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/auth.dart';
import 'package:shopping/screens/order_screen.dart';
import 'package:shopping/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Hello",
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: ClayContainer(
                curveType: CurveType.concave,
                borderRadius: 75,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.shop),
                )),
            title: Text(
              "Shop",
              style: TextStyle(shadows: <Shadow>[
                Shadow(
                  offset: Offset(10.0, 10.0),
                  blurRadius: 10.0,
                  color: Color.fromARGB(100, 0, 0, 0),
                ),
                Shadow(
                  offset: Offset(10.0, 10.0),
                  blurRadius: 4.0,
                  color: Color.fromARGB(50, 0, 0, 0),
                ),
              ], fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(),
          ListTile(
            leading: ClayContainer(
                curveType: CurveType.concave,
                borderRadius: 75,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.payment),
                )),
            title: Text(
              "Orders",
              style: TextStyle(shadows: <Shadow>[
                Shadow(
                  offset: Offset(10.0, 10.0),
                  blurRadius: 10.0,
                  color: Color.fromARGB(100, 0, 0, 0),
                ),
                Shadow(
                  offset: Offset(10.0, 10.0),
                  blurRadius: 4.0,
                  color: Color.fromARGB(50, 0, 0, 0),
                ),
              ], fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrderScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: ClayContainer(
                curveType: CurveType.concave,
                borderRadius: 75,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.edit),
                )),
            title: Text(
              "Manage Products",
              style: TextStyle(shadows: <Shadow>[
                Shadow(
                  offset: Offset(10.0, 10.0),
                  blurRadius: 10.0,
                  color: Color.fromARGB(100, 0, 0, 0),
                ),
                Shadow(
                  offset: Offset(10.0, 10.0),
                  blurRadius: 4.0,
                  color: Color.fromARGB(50, 0, 0, 0),
                ),
              ], fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName),
          ),
          Divider(),
          ListTile(
              leading: ClayContainer(
                  curveType: CurveType.concave,
                  borderRadius: 75,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.exit_to_app),
                  )),
              title: Text(
                "Log Out",
                style: TextStyle(shadows: <Shadow>[
                  Shadow(
                    offset: Offset(10.0, 10.0),
                    blurRadius: 10.0,
                    color: Color.fromARGB(100, 0, 0, 0),
                  ),
                  Shadow(
                    offset: Offset(10.0, 10.0),
                    blurRadius: 4.0,
                    color: Color.fromARGB(50, 0, 0, 0),
                  ),
                ], fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }
}
