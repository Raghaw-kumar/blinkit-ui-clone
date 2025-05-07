import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/category_list.dart';
import '../widgets/offer_banner.dart';
import '../widgets/product_grid.dart';
import '../providers/cart_provider.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onThemeToggle;
  final Function(int) onNavigationTap;

  const HomeScreen({
    super.key,
    this.onThemeToggle,
    required this.onNavigationTap,
  });

  void _navigateToCart() {
    onNavigationTap(2); // Cart tab index
  }

  void _navigateToAccount() {
    onNavigationTap(3); // Account tab index
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        onThemeToggle: onThemeToggle,
        onCartTap: _navigateToCart,
        onAccountTap: _navigateToAccount,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CategoryList(),
            const OfferBanner(),
            Consumer<CartProvider>(
              builder: (context, cart, child) => ProductGrid(
                onAddToCart: (id, name, price, image) {
                  cart.addItem(id, name, price, image);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Added to cart!'),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'View Cart',
                        onPressed: _navigateToCart,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
