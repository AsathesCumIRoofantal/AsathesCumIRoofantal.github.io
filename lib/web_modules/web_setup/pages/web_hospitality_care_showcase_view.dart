import 'package:air_app/web_modules/_shared/web_shell.dart';
import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class WebHospitalityCareShowcaseView extends StatefulWidget {
  const WebHospitalityCareShowcaseView({super.key});

  static const routeName = '/web-setup/hospitality-care-showcase';

  @override
  State<WebHospitalityCareShowcaseView> createState() =>
      _WebHospitalityCareShowcaseViewState();
}

class _WebHospitalityCareShowcaseViewState
    extends State<WebHospitalityCareShowcaseView> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> destinations = [
    {
      'name': 'Serenity Resort & Spa',
      'location': 'Maldives',
      'rating': 4.9,
      'price': 450,
      'image':
          'https://images.pexels.com/photos/164595/pexels-photo-164595.jpeg?auto=compress&cs=tinysrgb&w=800',
      'amenities': ['Pool', 'Spa', 'Beach Access'],
    },
    {
      'name': 'Mountain Lodge Retreat',
      'location': 'Swiss Alps',
      'rating': 4.8,
      'price': 320,
      'image':
          'https://images.pexels.com/photos/189296/pexels-photo-189296.jpeg?auto=compress&cs=tinysrgb&w=800',
      'amenities': ['Ski Access', 'Fireplace', 'Sauna'],
    },
    {
      'name': 'Urban Boutique Hotel',
      'location': 'Tokyo, Japan',
      'rating': 4.7,
      'price': 280,
      'image':
          'https://images.pexels.com/photos/1001965/pexels-photo-1001965.jpeg?auto=compress&cs=tinysrgb&w=800',
      'amenities': ['City View', 'Bar', 'Gym'],
    },
    {
      'name': 'Beachfront Paradise',
      'location': 'Bali, Indonesia',
      'rating': 4.9,
      'price': 180,
      'image':
          'https://images.pexels.com/photos/258154/pexels-photo-258154.jpeg?auto=compress&cs=tinysrgb&w=800',
      'amenities': ['Pool', 'Beach', 'Restaurant'],
    },
  ];

  final List<Map<String, dynamic>> testimonials = [
    {
      'name': 'Sarah Mitchell',
      'role': 'Solo Traveler',
      'avatar':
          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=100',
      'text':
          'The booking experience was seamless. Everything was handled perfectly.',
      'rating': 5,
    },
    {
      'name': 'James Wilson',
      'role': 'Family Vacation',
      'avatar':
          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=100',
      'text': 'Our family trip was amazing! The staff was incredibly helpful.',
      'rating': 5,
    },
  ];
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return WebShell(
      currentRoute: WebHospitalityCareShowcaseView.routeName,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF08111F)
            : const Color(0xFFF5F7FB),
        body: CustomScrollView(
          slivers: [
            // Hero Carousel
            SliverAppBar(
              expandedHeight: 400,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 400,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 4),
                        onPageChanged: (index, _) {
                          setState(() => _currentIndex = index);
                        },
                      ),
                      items: destinations.asMap().entries.map((entry) {
                        final destination = entry.value;
                        return Builder(
                          builder: (context) {
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: destination['image'],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.7),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  destinations[_currentIndex]['location'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber[400],
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${destinations[_currentIndex]['rating']}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ).animate().fadeIn().slideX(begin: -0.2, end: 0),
                          const SizedBox(height: 12),
                          Text(
                                destinations[_currentIndex]['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                              .animate(key: ValueKey(_currentIndex))
                              .fadeIn()
                              .slideY(begin: 0.2, end: 0),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: destinations[_currentIndex]['amenities']
                                .map<Widget>((amenity) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      amenity,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  );
                                })
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Starting from',
                                    style: TextStyle(
                                      color: Colors.amber[300],
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '\$${destinations[_currentIndex]['price']}/night',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                ),
                                label: const Text('Book Now'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink[500],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: destinations.asMap().entries.map((entry) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _currentIndex == entry.key ? 24 : 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: _currentIndex == entry.key
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Quick Services
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: const Offset(0, -30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildQuickServices(),
                ),
              ),
            ),

            // Testimonials
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Guest Experiences',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...testimonials.asMap().entries.map((entry) {
                      final index = entry.key;
                      final testimonial = entry.value;
                      return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Card(
                              elevation: 4,
                              shadowColor: Colors.black26,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                            testimonial['avatar'],
                                          ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            testimonial['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            testimonial['role'],
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: List.generate(
                                              testimonial['rating'],
                                              (_) => Icon(
                                                Icons.star,
                                                color: Colors.amber[500],
                                                size: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: (index * 150).ms)
                          .slideX(begin: 0.2, end: 0);
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickServices() {
    final services = [
      {'icon': Icons.calendar_today, 'label': 'Book Now', 'color': Colors.blue},
      {
        'icon': Icons.support_agent,
        'label': '24/7 Support',
        'color': Colors.green,
      },
      {'icon': Icons.security, 'label': 'Safe Stay', 'color': Colors.amber},
      {
        'icon': Icons.sentiment_satisfied,
        'label': 'Guest Care',
        'color': Colors.pink,
      },
    ];

    return Card(
      elevation: 8,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: services.asMap().entries.map((entry) {
            final service = entry.value;
            return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (service['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        service['icon'] as IconData,
                        color: service['color'] as Color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service['label'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
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
