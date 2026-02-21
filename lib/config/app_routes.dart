import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/about_screen.dart';
import '../screens/collections_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/gallery_screen.dart';
import '../screens/contact_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String about = '/about';
  static const String collections = '/collections';
  static const String productDetail = '/product-detail';
  static const String gallery = '/gallery';
  static const String contact = '/contact';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _fadeRoute(const HomeScreen());
      case about:
        return _fadeRoute(const AboutScreen());
      case collections:
        return _fadeRoute(const CollectionsScreen());
      case productDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return _fadeRoute(ProductDetailScreen(productId: args?['id'] ?? '1'));
      case gallery:
        return _fadeRoute(const GalleryScreen());
      case contact:
        return _fadeRoute(const ContactScreen());
      default:
        return _fadeRoute(const HomeScreen());
    }
  }

  static PageRoute _fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;

        final tween = Tween<double>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}