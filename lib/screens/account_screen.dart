import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // Open settings
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'john.doe@example.com',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () {
                            // Edit profile
                          },
                          child: const Text('Edit Profile'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Orders Section
          _buildSection(
            context,
            'My Orders',
            [
              _buildMenuItem(
                context,
                Icons.shopping_bag_outlined,
                'All Orders',
                () {},
              ),
              _buildMenuItem(
                context,
                Icons.local_shipping_outlined,
                'Track Order',
                () {},
              ),
              _buildMenuItem(
                context,
                Icons.receipt_long_outlined,
                'Order History',
                () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Account Settings
          _buildSection(
            context,
            'Account Settings',
            [
              _buildMenuItem(
                context,
                Icons.location_on_outlined,
                'Delivery Addresses',
                () {},
              ),
              _buildMenuItem(
                context,
                Icons.payment_outlined,
                'Payment Methods',
                () {},
              ),
              _buildMenuItem(
                context,
                Icons.notifications_outlined,
                'Notifications',
                () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Support
          _buildSection(
            context,
            'Support',
            [
              _buildMenuItem(
                context,
                Icons.help_outline,
                'Help Center',
                () {},
              ),
              _buildMenuItem(
                context,
                Icons.info_outline,
                'About Us',
                () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> items) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          ...items,
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
} 