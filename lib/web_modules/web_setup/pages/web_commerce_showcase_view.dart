import 'package:air_app/web_modules/_shared/web_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class WebCommerceShowcaseView extends StatefulWidget {
  const WebCommerceShowcaseView({super.key});

  static const routeName = '/web-setup/commerce-showcase';

  @override
  State<WebCommerceShowcaseView> createState() =>
      _WebCommerceShowcaseViewState();
}

class _WebCommerceShowcaseViewState extends State<WebCommerceShowcaseView> {
  String selectedCategory = 'All';
  final List<int> favorites = [];
  final List<Map<String, dynamic>> products = [
    {
      'id': 1,
      'name': 'Premium Wireless Headphones',
      'price': 299,
      'rating': 4.8,
      'reviews': 1247,
      'category': 'Electronics',
      'image':
          'https://images.pexels.com/photos/3394650/pexels-photo-3394650.jpeg?auto=compress&cs=tinysrgb&w=400',
    },
    {
      'id': 2,
      'name': 'Organic Cotton T-Shirt',
      'price': 49,
      'rating': 4.9,
      'reviews': 892,
      'category': 'Fashion',
      'image':
          'https://images.pexels.com/photos/5632402/pexels-photo-5632402.jpeg?auto=compress&cs=tinysrgb&w=400',
    },
    {
      'id': 3,
      'name': 'Smart Fitness Watch',
      'price': 199,
      'rating': 4.7,
      'reviews': 2341,
      'category': 'Electronics',
      'image':
          'https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?auto=compress&cs=tinysrgb&w=400',
    },
    {
      'id': 4,
      'name': 'Leather Crossbody Bag',
      'price': 159,
      'rating': 4.6,
      'reviews': 567,
      'category': 'Fashion',
      'image':
          'https://images.pexels.com/photos/1154885/pexels-photo-1154885.jpeg?auto=compress&cs=tinysrgb&w=400',
    },
    {
      'id': 5,
      'name': 'Minimalist Desk Lamp',
      'price': 89,
      'rating': 4.9,
      'reviews': 1876,
      'category': 'Home',
      'image':
          'https://images.pexels.com/photos/1112597/pexels-photo-1112597.jpeg?auto=compress&cs=tinysrgb&w=400',
    },
    {
      'id': 6,
      'name': 'Ceramic Plant Pot Set',
      'price': 45,
      'rating': 4.8,
      'reviews': 423,
      'category': 'Home',
      'image':
          'https://images.pexels.com/photos/10861873/pexels-photo-10861873.jpeg?auto=compress&cs=tinysrgb&w=400',
    },
  ];
  final categories = ['All', 'Electronics', 'Fashion', 'Home'];

  void toggleFavorite(int id) {
    setState(() {
      if (favorites.contains(id)) {
        favorites.remove(id);
      } else {
        favorites.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return WebShell(
      currentRoute: WebCommerceShowcaseView.routeName,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF08111F)
            : const Color(0xFFF5F7FB),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.amber[600]!,
                        Colors.orange[500]!,
                        Colors.pink[400]!,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                                child: Text(
                                  'Commerce Showcase',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 600.ms)
                              .slideY(begin: -0.3, end: 0),
                          const SizedBox(height: 8),
                          Text(
                                'Experience seamless shopping',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(color: Colors.amber[100]),
                              )
                              .animate()
                              .fadeIn(delay: 200.ms)
                              .slideY(begin: -0.2, end: 0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Stats
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: const Offset(0, -30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildStats(),
                ),
              ),
            ),

            // Search & Filter
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Category Filter
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() => selectedCategory = category);
                        },
                        selectedColor: Colors.amber,
                        checkmarkColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[700],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Products Grid
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  // Each row will contain two products
                  final firstIndex = index * 2;
                  final secondIndex = firstIndex + 1;

                  final firstProduct = products[firstIndex];
                  final isFirstFavorite = favorites.contains(
                    firstProduct['id'],
                  );

                  Widget firstCard =
                      ProductCard(
                            product: firstProduct,
                            isFavorite: isFirstFavorite,
                            onFavoriteToggle: () =>
                                toggleFavorite(firstProduct['id']),
                          )
                          .animate()
                          .fadeIn(delay: (firstIndex * 100).ms)
                          .slideY(begin: 0.2, end: 0);

                  Widget? secondCard;
                  if (secondIndex < products.length) {
                    final secondProduct = products[secondIndex];
                    final isSecondFavorite = favorites.contains(
                      secondProduct['id'],
                    );

                    secondCard =
                        ProductCard(
                              product: secondProduct,
                              isFavorite: isSecondFavorite,
                              onFavoriteToggle: () =>
                                  toggleFavorite(secondProduct['id']),
                            )
                            .animate()
                            .fadeIn(delay: (secondIndex * 100).ms)
                            .slideY(begin: 0.2, end: 0);
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Expanded(child: firstCard),
                        const SizedBox(width: 16),
                        Expanded(child: secondCard ?? const SizedBox()),
                      ],
                    ),
                  );
                }, childCount: (products.length / 2).ceil()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats() {
    final stats = [
      {'label': 'Active Sellers', 'value': '50K+', 'icon': Icons.trending_up},
      {'label': 'Products', 'value': '2M+', 'icon': Icons.inventory_2},
      {'label': 'Reviews', 'value': '10M+', 'icon': Icons.star},
      {'label': 'Countries', 'value': '120+', 'icon': Icons.public},
    ];

    return Card(
      elevation: 8,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: stats.asMap().entries.map((entry) {
            final stat = entry.value;
            return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        stat['icon'] as IconData,
                        color: Colors.amber[700],
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      stat['value'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      stat['label'] as String,
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                  ],
                )
                .animate()
                .fadeIn(delay: (entry.key * 100).ms)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
          }).toList(),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: CachedNetworkImage(
                  imageUrl: product['image'],
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isFavorite ? Colors.pink : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.white : Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    product['category'],
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber[600], size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${product['rating']}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' (${product['reviews']})',
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product['price']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.amber[600]!, Colors.orange[500]!],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
