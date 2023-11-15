import 'package:assignment10/data/models/product/product_model.dart';
import 'package:assignment10/presentation/screens/auth/login_screen.dart';
import 'package:assignment10/presentation/screens/auth/providers/login_provider.dart';
import 'package:assignment10/presentation/screens/auth/providers/signup_provider.dart';
import 'package:assignment10/presentation/screens/auth/signup_screen.dart';
import 'package:assignment10/presentation/screens/cart/cart_screen.dart';
import 'package:assignment10/presentation/screens/home/home_screen.dart';
import 'package:assignment10/presentation/screens/product/product_details_screen.dart';
import 'package:assignment10/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (BuildContext context) => LoginProvider(context),
              child: const LoginScreen()),
        );
      case SignUpScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (BuildContext context) => SignupProvider(context),
              child: const SignUpScreen()),
        );
      case HomeScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case SplashScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case ProductDetailsScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ProductDetailsScreen(
            productModel: settings.arguments as ProductModel,
          ),
        );
      case CartScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const CartScreen(),
        );

      default:
        return null;
    }
  }
}
