import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final List<Map<String, dynamic>> _allProducts = [
    {
      'id': '1',
      'name': 'Fresh Onions',
      'price': 40.0,
      'unit': '1 kg',
      'image':
          'https://5.imimg.com/data5/SELLER/Default/2024/5/419610158/MO/LQ/OO/160347834/white-onion.jpg',
    },
    {
      'id': '2',
      'name': 'Fresh Tomatoes',
      'price': 60.0,
      'unit': '1 kg',
      'image':
          'https://www.heddensofwoodtown.co.uk/wp-content/uploads/2020/05/tomatoes_opt.jpg',
    },
    {
      'id': '3',
      'name': 'Fresh Potatoes',
      'price': 35.0,
      'unit': '1 kg',
      'image':
          'https://m.media-amazon.com/images/I/51T6ABtzOxL._AC_UF1000,1000_QL80_.jpg',
    },
    {
      'id': '4',
      'name': 'Fresh Carrots',
      'price': 45.0,
      'unit': '1 kg',
      'image':
          'https://m.media-amazon.com/images/I/613sCMxt3tL._AC_UF1000,1000_QL80_.jpg',
    },
    {
      'id': '5',
      'name': 'Fresh Capsicum',
      'price': 80.0,
      'unit': '500 g',
      'image':
          'https://5.imimg.com/data5/UZ/QU/VQ/SELLER-62558122/green-capsicum-500x500.jpg',
    },
    {
      'id': '6',
      'name': 'Fresh Cauliflower',
      'price': 50.0,
      'unit': '1 pc',
      'image': 'https://m.media-amazon.com/images/I/91EdPVzD99L.jpg',
    },
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    if (_searchQuery.isEmpty) {
      return _allProducts;
    }
    return _allProducts.where((product) {
      return product['name']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for products...',
            hintStyle: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[400]
                  : Colors.grey[600],
            ),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
        actions: [
          if (_searchQuery.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                });
              },
            ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return _filteredProducts.isEmpty
              ? Center(
                  child: Text(
                    'No products found',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = _filteredProducts[index];
                    final cartItem = cart.items[product['id'] as String];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            product['image'] as String,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          product['name'] as String,
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${product['unit']} • ₹${product['price']}',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
                          ),
                        ),
                        trailing: cartItem != null
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon:
                                        const Icon(Icons.remove_circle_outline),
                                    onPressed: () => cart
                                        .removeItem(product['id'] as String),
                                    color: Theme.of(context).primaryColor,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      '${cartItem.quantity}',
                                      style: TextStyle(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () => cart.addItem(
                                      product['id'] as String,
                                      product['name'] as String,
                                      product['price'] as double,
                                      product['image'] as String,
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ],
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  cart.addItem(
                                    product['id'] as String,
                                    product['name'] as String,
                                    product['price'] as double,
                                    product['image'] as String,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Added to cart!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: const Text('ADD'),
                              ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
