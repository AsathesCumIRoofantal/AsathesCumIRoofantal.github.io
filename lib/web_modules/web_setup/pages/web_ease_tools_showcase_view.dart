import 'package:air_app/web_modules/_shared/web_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class WebEaseToolsShowcaseView extends StatefulWidget {
  const WebEaseToolsShowcaseView({super.key});

  static const routeName = '/web-setup/ease-tools-showcase';

  @override
  State<WebEaseToolsShowcaseView> createState() =>
      _WebEaseToolsShowcaseViewState();
}

class _WebEaseToolsShowcaseViewState extends State<WebEaseToolsShowcaseView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> selectedTools = [];
  bool isPlaying = true;

  final List<Map<String, dynamic>> categories = [
    {
      'id': 'design',
      'title': 'Design Tools',
      'icon': Icons.palette,
      'color': [Colors.pink[400]!, Colors.pink[500]!],
      'tools': [
        {'name': 'Widget Studio', 'desc': 'Visual widget builder'},
        {'name': 'Theme Editor', 'desc': 'Customize colors & typography'},
        {'name': 'Animation Lab', 'desc': 'Create micro-interactions'},
      ],
    },
    {
      'id': 'develop',
      'title': 'Development',
      'icon': Icons.code,
      'color': [Colors.blue[400]!, Colors.cyan[500]!],
      'tools': [
        {'name': 'Hot Reload', 'desc': 'Instant UI updates'},
        {'name': 'DevTools', 'desc': 'Performance profiling'},
        {'name': 'Platform Channels', 'desc': 'Native code integration'},
      ],
    },
    {
      'id': 'deploy',
      'title': 'Deployment',
      'icon': Icons.rocket_launch,
      'color': [Colors.green[400]!, Colors.teal[500]!],
      'tools': [
        {'name': 'Multi-Platform', 'desc': 'iOS, Android, Web, Desktop'},
        {'name': 'CI/CD Integration', 'desc': 'Automated builds'},
        {'name': 'App Store Ready', 'desc': 'Production in minutes'},
      ],
    },
  ];

  final List<Map<String, dynamic>> quickTools = [
    {'name': 'Responsive Layout', 'icon': Icons.layers, 'active': true},
    {'name': 'Material Design', 'icon': Icons.style, 'active': false},
    {'name': 'Cupertino Style', 'icon': Icons.phone_iphone, 'active': false},
    {'name': 'Web Support', 'icon': Icons.web, 'active': true},
    {'name': 'Tablet Optimized', 'icon': Icons.tablet, 'active': false},
    {'name': 'Figma Import', 'icon': Icons.design_services, 'active': false},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    selectedTools.addAll(['Responsive Layout', 'Web Support']);
  }

  void toggleTool(String name) {
    setState(() {
      if (selectedTools.contains(name)) {
        selectedTools.remove(name);
      } else {
        selectedTools.add(name);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return WebShell(
      currentRoute: WebEaseToolsShowcaseView.routeName,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF08111F)
            : const Color(0xFFF5F7FB),
        body: CustomScrollView(
          slivers: [
            // Header
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
                        Colors.green[400]!,
                        Colors.teal[400]!,
                        Colors.cyan[400]!,
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.green[500]!, Colors.teal[500]!],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.build,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Developer Experience',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fadeIn().slideY(begin: -0.3, end: 0),
                          const SizedBox(height: 16),
                          Text(
                            'Ease Tools',
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Powerful tools that make development a joy',
                            style: TextStyle(
                              color: Colors.teal[100],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Tools Panel
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildToolsPanel(),
                    const SizedBox(height: 24),
                    Text(
                      'Quick Development Features',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildQuickTools(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolsPanel() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Tab Bar
            TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[500]!, Colors.teal[500]!],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              tabs: categories.map((cat) {
                return Tab(
                  icon: Icon(cat['icon'] as IconData, size: 18),
                  text: cat['title'] as String,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Tab Content
            SizedBox(
              height: 200,
              child: TabBarView(
                controller: _tabController,
                children: categories.map((category) {
                  final tools = category['tools'] as List<Map<String, String>>;
                  return ListView.builder(
                    itemCount: tools.length,
                    itemBuilder: (context, index) {
                      final tool = tools[index];
                      return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: category['color'] as List<Color>,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tool['name']!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        tool['desc']!,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                          .animate()
                          .fadeIn(delay: (index * 100).ms)
                          .slideX(begin: 0.1, end: 0);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickTools() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: quickTools.length,
      itemBuilder: (context, index) {
        final tool = quickTools[index];
        final isSelected = selectedTools.contains(tool['name']);

        return GestureDetector(
              onTap: () => toggleTool(tool['name'] as String),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [Colors.green[500]!, Colors.teal[500]!],
                        )
                      : null,
                  color: isSelected ? null : Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : Colors.grey[300]!,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tool['icon'] as IconData,
                      color: isSelected ? Colors.white : Colors.grey[600],
                      size: 28,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tool['name'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[700],
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .animate()
            .fadeIn(delay: (index * 50).ms)
            .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
      },
    );
  }
}
