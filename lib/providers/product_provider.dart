import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String unit;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.unit,
    required this.image,
  });
}

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Fresh Onions',
      price: 40.0,
      unit: '1 kg',
      image: 'https://5.imimg.com/data5/SELLER/Default/2024/5/419610158/MO/LQ/OO/160347834/white-onion.jpg',
    ),
    Product(
      id: '2',
      name: 'Fresh Tomatoes',
      price: 60.0,
      unit: '1 kg',
      image: 'https://www.heddensofwoodtown.co.uk/wp-content/uploads/2020/05/tomatoes_opt.jpg',
    ),
    Product(
      id: '3',
      name: 'Fresh Potatoes',
      price: 35.0,
      unit: '1 kg',
      image: 'https://m.media-amazon.com/images/I/51T6ABtzOxL._AC_UF1000,1000_QL80_.jpg',
    ),
    Product(
      id: '4',
      name: 'Fresh Carrots',
      price: 45.0,
      unit: '1 kg',
      image: 'https://m.media-amazon.com/images/I/613sCMxt3tL._AC_UF1000,1000_QL80_.jpg',
    ),
    Product(
      id: '5',
      name: 'Fresh Capsicum',
      price: 80.0,
      unit: '500 g',
      image: 'https://5.imimg.com/data5/UZ/QU/VQ/SELLER-62558122/green-capsicum-500x500.jpg',
    ),
    Product(
      id: '6',
      name: 'Fresh Cauliflower',
      price: 50.0,
      unit: '1 pc',
      image: 'https://m.media-amazon.com/images/I/91EdPVzD99L.jpg',
    ),
  ];

  List<Product> get products => _products;

  List<Product> searchProducts(String query) {
    if (query.isEmpty) return _products;
    return _products.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
} 