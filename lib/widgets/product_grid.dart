import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final Function(String, String, double, String) onAddToCart;

  const ProductGrid({
    super.key,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : 3;
    final spacing = 16.0;

    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(spacing),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.75,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: productProvider.products.length,
          itemBuilder: (context, index) {
            final product = productProvider.products[index];
            return ProductCard(
              product: product,
              onAddToCart: () => onAddToCart(
                product.id,
                product.name,
                product.price,
                product.image,
              ),
            );
          },
        );
      },
    );
  }
}