import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Helpers
import 'helpers/custom_route.dart';

// Screens
import 'screens/products_overview_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/user_products_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/splash_screen.dart';

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
          create: (ctx) => Products('', '', []),
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),

        // Carts Provider:
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),

        // Orders Provider:
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders('', '', []),
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(builder: (ctx, authData, _) {
        ifAuth(targetScreen) => authData.isAuth ? targetScreen : AuthScreen();
        return MaterialApp(
          title: 'Shopping App',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              }
            ),
          ),
          home: authData.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
            ProductDetailsScreen.routeName: (ctx) =>
                ifAuth(ProductDetailsScreen()),
            CartScreen.routeName: (ctx) => ifAuth(CartScreen()),
            OrdersScreen.routeName: (ctx) => ifAuth(OrdersScreen()),
            UserProductsScreen.routeName: (ctx) => ifAuth(UserProductsScreen()),
            EditProductScreen.routeName: (ctx) => ifAuth(EditProductScreen()),
          },
        );
      }),
    );
  }
}
