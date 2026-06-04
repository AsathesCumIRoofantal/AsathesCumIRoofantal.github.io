import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_products_services_controller.dart';

class WebProductsServicesView extends GetView<WebProductsServicesController> {
  static const routeName = '/web-air_space/products-services';
  const WebProductsServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFE0F2FE),
        body: _Body(isDark: isDark, ctrl: controller),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final bool isDark;
  final WebProductsServicesController ctrl;
  const _Body({required this.isDark, required this.ctrl});
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late AnimationController _waveCtrl;

  @override
  void initState() {
    super.initState();
    _waveCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() { _waveCtrl.dispose(); super.dispose(); }

  static const _products = [
    ('AIR Dashboard Pro', 'Premium analytics workspace', Icons.dashboard_rounded, Color(0xFF0284C7), 'Digital'),
    ('Knowledge Vault', 'Curated document library', Icons.library_books_rounded, Color(0xFF7C3AED), 'Resources'),
    ('Event Planner', 'Schedule & collaborate tool', Icons.event_rounded, Color(0xFF059669), 'Services'),
    ('AIR Mobile Suite', 'Cross-platform companion app', Icons.phone_android_rounded, Color(0xFFEA580C), 'Digital'),
    ('Mentor Connect', 'Expert matching service', Icons.people_alt_rounded, Color(0xFFEC4899), 'Services'),
    ('AIR Physical Kit', 'Printed resources & tools', Icons.inventory_2_rounded, Color(0xFF64748B), 'Physical'),
  ];

  @override
  Widget build(BuildContext context) {
    final sec = WebNavData.bySlug('air_space');
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 320,
          pinned: true,
          backgroundColor: const Color(0xFF0284C7),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Products & Services', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
            background: AnimatedBuilder(
              animation: _waveCtrl,
              builder: (_, __) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0284C7), Color(0xFF0369A1), Color(0xFF075985)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(children: [
                  ...List.generate(3, (i) => Positioned(
                    left: -40.0 + i * 120 + 40 * _waveCtrl.value,
                    bottom: -20.0 + i * 30.0,
                    child: Container(
                      width: 200, height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05 - i * 0.01),
                        shape: BoxShape.circle,
                      ),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 56),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                          child: const Text('Catalogue · Browse · Request', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 12),
                        const Text('AIR Products\n& Services', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, height: 1.2)),
                        const SizedBox(height: 8),
                        Text('Everything AIR offers — explore, request, or integrate.',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13)),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
          actions: [
            Obx(() => IconButton(
              icon: Icon(widget.ctrl.viewMode.value == 'grid' ? Icons.view_list_rounded : Icons.grid_view_rounded, color: Colors.white),
              onPressed: () => widget.ctrl.viewMode.value = widget.ctrl.viewMode.value == 'grid' ? 'list' : 'grid',
            )),
          ],
        ),

        // Filter bar
        SliverToBoxAdapter(
          child: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: List.generate(widget.ctrl.filters.length, (i) {
                final sel = widget.ctrl.filterIndex.value == i;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => widget.ctrl.filterIndex.value = i,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                      decoration: BoxDecoration(
                        color: sel ? const Color(0xFF0284C7) : (widget.isDark ? WColors.cardDark : Colors.white),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: sel ? [BoxShadow(color: const Color(0xFF0284C7).withValues(alpha: 0.35), blurRadius: 10)] : [],
                      ),
                      child: Text(widget.ctrl.filters[i], style: TextStyle(
                        color: sel ? Colors.white : (widget.isDark ? Colors.white70 : Colors.black54),
                        fontWeight: sel ? FontWeight.w800 : FontWeight.w500,
                        fontSize: 13,
                      )),
                    ),
                  ),
                );
              }),
            ),
          )),
        ),

        // Flutter 2026 note
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF0F172A), Color(0xFF1E293B)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(children: [
                const Icon(Icons.rocket_launch_rounded, color: Color(0xFF38BDF8), size: 22),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Flutter 2026 Powers', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13)),
                  Text('3D flip cards · Real-time stock · AI pricing · AR product preview', style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11, height: 1.4)),
                ])),
              ]),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        // Products grid/list
        Obx(() => widget.ctrl.viewMode.value == 'grid'
          ? SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 340, childAspectRatio: 1.3, crossAxisSpacing: 12, mainAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) {
                    if (i >= _products.length) return null;
                    final p = _products[i];
                    return _ProductCard(name: p.$1, desc: p.$2, icon: p.$3, color: p.$4, tag: p.$5, isDark: widget.isDark);
                  },
                  childCount: _products.length,
                ),
              ),
            )
          : SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) {
                    final items = WebNavData.bySlug('air_space').items;
                    if (i >= items.length) return null;
                    final item = items[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: widget.isDark ? WColors.cardDark : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF0284C7).withValues(alpha: 0.15)),
                        ),
                        child: Row(children: [
                          Container(width: 44, height: 44, decoration: BoxDecoration(color: const Color(0xFF0284C7).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                            child: Icon(item.icon, color: const Color(0xFF0284C7), size: 22)),
                          const SizedBox(width: 14),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(item.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: widget.isDark ? Colors.white : const Color(0xFF0F172A))),
                            Text(item.description, style: TextStyle(fontSize: 11.5, color: widget.isDark ? Colors.white54 : Colors.black45, height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
                          ])),
                          const Icon(Icons.chevron_right_rounded, color: Color(0xFF0284C7)),
                        ]),
                      ),
                    );
                  },
                  childCount: WebNavData.bySlug('air_space').items.length,
                ),
              ),
            ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String name, desc, tag;
  final IconData icon;
  final Color color;
  final bool isDark;
  const _ProductCard({required this.name, required this.desc, required this.icon, required this.color, required this.tag, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.1), blurRadius: 16)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: color, size: 22)),
            const Spacer(),
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
              child: Text(tag, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700))),
          ]),
          const Spacer(),
          Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: isDark ? Colors.white : const Color(0xFF0F172A))),
          const SizedBox(height: 4),
          Text(desc, style: TextStyle(fontSize: 11.5, color: isDark ? Colors.white54 : Colors.black45), maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
