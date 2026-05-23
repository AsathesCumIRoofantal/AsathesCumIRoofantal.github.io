import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class FlutterCapabilities {
  int activeCategory = 0;

  final List<Map<String, dynamic>> capabilities = [
    {
      'category': 'Cross-Platform',
      'icon': Icons.layers,
      'color': [Colors.blue[400]!, Colors.cyan[500]!],
      'items': [
        {'icon': Icons.phone_iphone, 'label': 'iOS', 'desc': 'Native iOS apps'},
        {'icon': Icons.android, 'label': 'Android', 'desc': 'Material Design'},
        {'icon': Icons.web, 'label': 'Web', 'desc': 'Progressive Web Apps'},
        {
          'icon': Icons.desktop_windows,
          'label': 'Desktop',
          'desc': 'Windows, macOS, Linux',
        },
      ],
    },
    {
      'category': 'Developer Experience',
      'icon': Icons.code,
      'color': [Colors.purple[400]!, Colors.pink[500]!],
      'items': [
        {
          'icon': Icons.bolt,
          'label': 'Hot Reload',
          'desc': 'Instant UI updates',
        },
        {
          'icon': Icons.developer_mode,
          'label': 'DevTools',
          'desc': 'Performance profiling',
        },
        {
          'icon': Icons.extension,
          'label': 'Platform Channels',
          'desc': 'Native integration',
        },
      ],
    },
    {
      'category': 'UI & Design',
      'icon': Icons.palette,
      'color': [Colors.green[400]!, Colors.teal[500]!],
      'items': [
        {
          'icon': Icons.widgets,
          'label': 'Widget System',
          'desc': 'Reusable components',
        },
        {
          'icon': Icons.animation,
          'label': 'Animations',
          'desc': 'Smooth 60fps',
        },
        {
          'icon': Icons.brush,
          'label': 'Theming',
          'desc': 'Complete customization',
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> features = [
    {
      'title': 'Impeller Engine',
      'desc': 'Next-gen rendering for 60fps',
      'stat': '60fps',
      'icon': Icons.speed,
      'color': [Colors.green[400]!, Colors.teal[500]!],
    },
    {
      'title': 'AOT Compilation',
      'desc': 'Native performance',
      'stat': 'Native',
      'icon': Icons.rocket_launch,
      'color': [Colors.blue[400]!, Colors.cyan[500]!],
    },
    {
      'title': 'State Management',
      'desc': 'Multiple patterns',
      'stat': 'Flexible',
      'icon': Icons.settings_suggest,
      'color': [Colors.purple[400]!, Colors.pink[500]!],
    },
    {
      'title': 'Security First',
      'desc': 'Built-in protection',
      'stat': 'Safe',
      'icon': Icons.security,
      'color': [Colors.amber[400]!, Colors.orange[500]!],
    },
  ];

  List<Widget> get slivers => [
    // Header
    SliverAppBar(
      expandedHeight: 280,
      floating: false,
      pinned: true,
      backgroundColor: Colors.grey[900],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[900]!,
                Colors.blue[900]!.withOpacity(0.7),
                Colors.cyan[800]!.withOpacity(0.5),
              ],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // Animated dots
                ...List.generate(30, (index) {
                  return Positioned(
                    left: (index * 13) % 400,
                    top: (index * 17) % 280,
                    child:
                        Container(
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.cyan.withOpacity(0.4),
                                shape: BoxShape.circle,
                              ),
                            )
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .fadeOut(duration: 3000.ms, delay: (index * 100).ms)
                            .fadeIn(duration: 3000.ms, delay: (index * 100).ms)
                            .scale(
                              begin: const Offset(0.5, 0.5),
                              end: const Offset(2, 2),
                              duration: 3000.ms,
                            ),
                  );
                }),
                // Content
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.cyan.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.cyan.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.auto_awesome,
                                color: Colors.cyan[400],
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Flutter 2026',
                                style: TextStyle(
                                  color: Colors.cyan[300],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'What Flutter',
                          style: Theme.of(Get.context!).textTheme.headlineLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Colors.cyan[400]!, Colors.blue[400]!],
                          ).createShader(bounds),
                          child: Text(
                            'Can Do',
                            style: Theme.of(Get.context!)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Build beautiful apps for any platform',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),

    // Capabilities Carousel
    SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildCapabilitiesPanel(),
      ),
    ),

    // Feature Stats
    SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.3,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final feature = features[index];
          return _buildFeatureCard(feature, index);
        }, childCount: features.length),
      ),
    ),

    // Code Example
    SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildCodeExample(),
      ),
    ),
  ];

  Widget _buildCapabilitiesPanel() {
    return Card(
      elevation: 8,
      color: Colors.grey[900],
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'One Code, All Platforms',
              style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Category Tabs
            Row(
              children: capabilities.asMap().entries.map((entry) {
                final index = entry.key;
                final capability = entry.value;
                final isSelected = activeCategory == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      activeCategory = index;
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                                colors: [Colors.cyan[500]!, Colors.blue[500]!],
                              )
                            : null,
                        color: isSelected ? null : Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            capability['icon'] as IconData,
                            color: isSelected ? Colors.white : Colors.grey,
                            size: 18,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            capability['category'] as String,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey,
                              fontSize: 10,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Category Content
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Column(
                key: ValueKey(activeCategory),
                children: capabilities[activeCategory]['items'].map<Widget>((
                  item,
                ) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors:
                                  capabilities[activeCategory]['color']
                                      as List<Color>,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['label'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                item['desc'],
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature, int index) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey[50]!, Colors.white],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: feature['color'] as List<Color>,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    feature['icon'] as IconData,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const Spacer(),
                Text(
                  feature['stat'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: (feature['color'] as List<Color>).first,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              feature['title'],
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 2),
            Text(
              feature['desc'],
              style: TextStyle(color: Colors.grey[600], fontSize: 11),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildCodeExample() {
    return Card(
      elevation: 4,
      color: Colors.grey[900],
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.yellow[400],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.green[400],
                    shape: BoxShape.circle,
                  ),
                ),
                const Spacer(),
                Text(
                  'main.dart',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '''import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext Get.context!) {
    return MaterialApp(
      title: 'Flutter 2026',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}''',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }
}
