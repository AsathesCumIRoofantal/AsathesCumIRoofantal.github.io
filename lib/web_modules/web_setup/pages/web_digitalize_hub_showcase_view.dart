import 'package:air_app/web_modules/_shared/web_shell.dart';
import 'package:air_app/web_modules/sample_flutter_design_check/flutter_capabilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class WebDigitalizeHubShowcaseView extends StatelessWidget {
  const WebDigitalizeHubShowcaseView({super.key});

  static const routeName = '/web-setup/digitalize-hub-showcase';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF08111F)
            : const Color(0xFFF5F7FB),
        body: CustomScrollView(
          slivers: [
            // SliverAppBar(
            //   expandedHeight: 530,
            //   pinned: true,
            //   backgroundColor: Colors.transparent,
            //   flexibleSpace: FlexibleSpaceBar(
            //     title: Text(
            //       'Digitalize Hub',
            //       style: const TextStyle(
            //         fontWeight: FontWeight.w700,
            //         letterSpacing: 0.4,
            //       ),
            //     ),
            //     background: Stack(
            //       fit: StackFit.expand,
            //       children: [
            //         Container(
            //           decoration: const BoxDecoration(
            //             gradient: LinearGradient(
            //               colors: [
            //                 Color(0xFF5B8CFF),
            //                 Color(0xFF6E44FF),
            //                 Color(0xFF00C2A8),
            //               ],
            //               begin: Alignment.topLeft,
            //               end: Alignment.bottomRight,
            //             ),
            //           ),
            //         ),
            //         Positioned(
            //           top: 60,
            //           right: -40,
            //           child: Container(
            //             width: 220,
            //             height: 220,
            //             decoration: BoxDecoration(
            //               color: Colors.white.withOpacity(0.08),
            //               borderRadius: BorderRadius.circular(200),
            //             ),
            //           ),
            //         ),
            //         Positioned(
            //           left: 24,
            //           bottom: 60,
            //           child: SizedBox(
            //             width: 520,
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               mainAxisAlignment: MainAxisAlignment.end,
            //               children: [
            //                 Container(
            //                   padding: const EdgeInsets.symmetric(
            //                     horizontal: 14,
            //                     vertical: 8,
            //                   ),
            //                   decoration: BoxDecoration(
            //                     color: Colors.white.withOpacity(0.15),
            //                     borderRadius: BorderRadius.circular(30),
            //                   ),
            //                   child: const Text(
            //                     'Flutter 2026 Experience Layer',
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontWeight: FontWeight.w600,
            //                     ),
            //                   ),
            //                 ),
            //                 const SizedBox(height: 18),
            //                 const Text(
            //                   'Automation pipelines, cloud orchestration, modern digital operations.',
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 18,
            //                     height: 1.5,
            //                   ),
            //                 ),
            //                 const SizedBox(height: 24),
            //                 Wrap(
            //                   spacing: 14,
            //                   runSpacing: 14,
            //                   children: List.generate(
            //                     4,
            //                     (index) => AnimatedContainer(
            //                       duration: const Duration(milliseconds: 500),
            //                       curve: Curves.easeOutCubic,
            //                       padding: const EdgeInsets.all(18),
            //                       width: 140,
            //                       decoration: BoxDecoration(
            //                         color: Colors.white.withOpacity(0.12),
            //                         borderRadius: BorderRadius.circular(24),
            //                         border: Border.all(
            //                           color: Colors.white.withOpacity(0.1),
            //                         ),
            //                       ),
            //                       child: Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           Icon(
            //                             Icons.auto_awesome,
            //                             color: Colors.white,
            //                           ),
            //                           const SizedBox(height: 12),
            //                           Text(
            //                             'Module $index',
            //                             style: const TextStyle(
            //                               color: Colors.white,
            //                               fontWeight: FontWeight.w700,
            //                             ),
            //                           ),
            //                           const SizedBox(height: 6),
            //                           const Text(
            //                             'Motion driven micro interactions',
            //                             style: TextStyle(
            //                               color: Colors.white70,
            //                               fontSize: 12,
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SliverPadding(
            //   padding: const EdgeInsets.all(24),
            //   sliver: SliverList(
            //     delegate: SliverChildListDelegate([
            //       Wrap(
            //         spacing: 24,
            //         runSpacing: 24,
            //         children: List.generate(8, (index) {
            //           final width = MediaQuery.of(context).size.width;

            //           double cardWidth = width;

            //           if (width > 1600) {
            //             cardWidth = (width - 120) / 4;
            //           } else if (width > 1200) {
            //             cardWidth = (width - 100) / 3;
            //           } else if (width > 700) {
            //             cardWidth = (width - 80) / 2;
            //           } else {
            //             cardWidth = width - 48;
            //           }

            //           return TweenAnimationBuilder<double>(
            //             tween: Tween(begin: 0, end: 1),
            //             duration: Duration(milliseconds: 500 + (index * 80)),
            //             curve: Curves.easeOutCubic,
            //             builder: (context, value, child) {
            //               return Transform.translate(
            //                 offset: Offset(0, 40 * (1 - value)),
            //                 child: Opacity(opacity: value, child: child),
            //               );
            //             },
            //             child: SizedBox(
            //               width: cardWidth,
            //               child: Container(
            //                 padding: const EdgeInsets.all(22),
            //                 decoration: BoxDecoration(
            //                   color: isDark
            //                       ? const Color(0xFF111C2D)
            //                       : Colors.white,
            //                   borderRadius: BorderRadius.circular(30),
            //                   boxShadow: [
            //                     BoxShadow(
            //                       blurRadius: 30,
            //                       offset: const Offset(0, 12),
            //                       color: Colors.black.withOpacity(0.06),
            //                     ),
            //                   ],
            //                 ),

            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Row(
            //                       children: [
            //                         CircleAvatar(
            //                           radius: 26,
            //                           backgroundColor: const Color(
            //                             0xFF5B8CFF,
            //                           ).withOpacity(0.15),
            //                           child: const Icon(
            //                             Icons.bolt,
            //                             color: Color(0xFF5B8CFF),
            //                           ),
            //                         ),

            //                         const Spacer(),

            //                         Container(
            //                           padding: const EdgeInsets.symmetric(
            //                             horizontal: 12,
            //                             vertical: 6,
            //                           ),
            //                           decoration: BoxDecoration(
            //                             borderRadius: BorderRadius.circular(20),
            //                             color: Colors.green.withOpacity(0.12),
            //                           ),
            //                           child: const Text(
            //                             'Realtime',
            //                             style: TextStyle(
            //                               color: Colors.green,
            //                               fontWeight: FontWeight.w700,
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),

            //                     const SizedBox(height: 24),

            //                     Text(
            //                       'Feature Experience #$index',
            //                       style: TextStyle(
            //                         color: isDark
            //                             ? Colors.white
            //                             : Colors.black87,
            //                         fontSize: 22,
            //                         fontWeight: FontWeight.w700,
            //                       ),
            //                     ),

            //                     const SizedBox(height: 10),

            //                     Text(
            //                       'Flutter enables high-performance sliver layouts, adaptive rendering, futuristic UI systems, GPU accelerated animations and premium desktop-grade experiences.',
            //                       style: TextStyle(
            //                         color: isDark
            //                             ? Colors.white70
            //                             : Colors.black54,
            //                         height: 1.6,
            //                       ),
            //                     ),

            //                     const SizedBox(height: 24),

            //                     LinearProgressIndicator(
            //                       value: (index + 1) / 10,
            //                       borderRadius: BorderRadius.circular(20),
            //                       minHeight: 10,
            //                     ),

            //                     const SizedBox(height: 18),

            //                     Wrap(
            //                       spacing: 10,
            //                       runSpacing: 10,
            //                       children: const [
            //                         Chip(label: Text('Slivers')),
            //                         Chip(label: Text('Motion')),
            //                         Chip(label: Text('AI UI')),
            //                         Chip(label: Text('Responsive')),
            //                         Chip(label: Text('GetX')),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           );
            //         }),
            //       ),
            //     ]),
            //   ),
            // ),
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
                        ...List.generate(20, (index) {
                          return Positioned(
                            left: (index * 17) % 400,
                            top: (index * 23) % 280,
                            child:
                                Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: Colors.cyan.withOpacity(0.3),
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(),
                                    )
                                    .fadeIn(duration: 2000.ms)
                                    .scale(
                                      begin: const Offset(0.5, 0.5),
                                      end: const Offset(1.5, 1.5),
                                      duration: 2000.ms,
                                    )
                                    .fadeOut(duration: 2000.ms, delay: 1000.ms),
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
                                    color: Colors.white.withOpacity(0.1),
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
                                        'Next-Gen Digital Platform',
                                        style: TextStyle(
                                          color: Colors.cyan[300],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ).animate().fadeIn().slideY(
                                  begin: -0.2,
                                  end: 0,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Digitalize Your',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                ShaderMask(
                                      shaderCallback: (bounds) =>
                                          LinearGradient(
                                            colors: [
                                              Colors.cyan[400]!,
                                              Colors.blue[400]!,
                                              Colors.blue[300]!,
                                            ],
                                          ).createShader(bounds),
                                      child: Text(
                                        'Business Future',
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
                                    .fadeIn(delay: 200.ms)
                                    .slideY(begin: 0.2, end: 0),
                                const SizedBox(height: 12),
                                Text(
                                  'Transform workflows into intelligent cloud-powered experiences',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                  ),
                                ).animate().fadeIn(delay: 400.ms),
                                const SizedBox(height: 20),
                                ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.arrow_forward),
                                      label: const Text('Get Started Free'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.cyan[600],
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 14,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(delay: 600.ms)
                                    .slideY(begin: 0.3, end: 0),
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

            // Metrics
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: const Offset(0, -20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildMetrics(),
                ),
              ),
            ),

            // Services
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Our Services',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[900],
                          ),
                    ),
                    const SizedBox(height: 16),
                    ..._buildServices(context),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 60),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0F172A), Color(0xFF172554)],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Why Flutter 2026?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Single codebase delivery across mobile, web, desktop and embedded surfaces. GPU accelerated rendering, AI workflow integration, advanced animation orchestration and premium UI pipelines make Flutter ideal for futuristic AIR experiences.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: List.generate(
                          3,
                          (index) => Container(
                            width: 260,
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.animation,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Adaptive Motion System',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Dynamic transitions and responsive interaction layers for modern web storytelling.',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ...FlutterCapabilities().slivers,
          ],
        ),
      ),
    );
  }

  Widget _buildMetrics() {
    final metrics = [
      {'label': 'Apps Digitized', 'value': '10K+', 'icon': Icons.phone_android},
      {'label': 'Data Processed', 'value': '50PB', 'icon': Icons.storage},
      {'label': 'Active Users', 'value': '5M+', 'icon': Icons.public},
      {'label': 'API Calls/Day', 'value': '100M', 'icon': Icons.bolt},
    ];

    return Card(
      elevation: 8,
      color: Colors.grey[900],
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: metrics.asMap().entries.map((entry) {
            final metric = entry.value;
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.cyan.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    metric['icon'] as IconData,
                    color: Colors.cyan[400],
                    size: 22,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  metric['value'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Text(
                  metric['label'] as String,
                  style: TextStyle(fontSize: 10, color: Colors.grey[400]),
                ),
              ],
            ).animate().fadeIn(delay: (entry.key * 100).ms);
          }).toList(),
        ),
      ),
    );
  }

  List<Widget> _buildServices(BuildContext context) {
    final services = [
      {
        'title': 'Cloud Infrastructure',
        'desc': 'Scalable cloud solutions with 99.99% uptime',
        'icon': Icons.cloud,
        'color': [Colors.blue[400]!, Colors.cyan[500]!],
        'features': ['Auto-scaling', 'Load balancing', 'CDN integration'],
      },
      {
        'title': 'Database Management',
        'desc': 'Real-time database with offline-first architecture',
        'icon': Icons.storage,
        'color': [Colors.green[400]!, Colors.teal[500]!],
        'features': ['Auto-sync', 'Conflict resolution', 'Encryption at rest'],
      },
      {
        'title': 'Mobile Solutions',
        'desc': 'Cross-platform apps from a single codebase',
        'icon': Icons.phone_android,
        'color': [Colors.blue[500]!, Colors.indigo[500]!],
        'features': ['iOS & Android', 'Hot reload', 'Native performance'],
      },
      {
        'title': 'Workflow Automation',
        'desc': 'Streamline operations with intelligent automation',
        'icon': Icons.account_tree,
        'color': [Colors.orange[400]!, Colors.red[400]!],
        'features': ['Visual builder', 'AI-powered', 'API integrations'],
      },
    ];

    return services.asMap().entries.map((entry) {
      final index = entry.key;
      final service = entry.value;

      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Card(
          elevation: 4,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.grey[50]!, Colors.white],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: service['color'] as List<Color>,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: (service['color'] as List<Color>).first
                            .withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    service['icon'] as IconData,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service['desc'] as String,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: (service['features'] as List<String>).map((
                          feature,
                        ) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green[500],
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  feature,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ).animate().fadeIn(delay: (index * 150).ms).slideX(begin: 0.1, end: 0);
    }).toList();
  }
}
