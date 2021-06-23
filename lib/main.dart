import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Screens
import 'screens/products_overview_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/user_products_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/auth_screen.dart';

// Providers
import 'providers/auth.dart';
import 'providers/products_provider.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Auth provider
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),

        // Products Provider:
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
            auth.token == null ? '' : auth.token!,
            previousProducts == null ? [] : previousProducts.items,
          ),
          create: (ctx) => Products('', []),
        ),

        // Carts Provider:
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),

        // Orders Provider:
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          title: 'Shopping App',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: authData.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
            ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
