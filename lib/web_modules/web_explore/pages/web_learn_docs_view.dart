import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_learn_docs_controller.dart';

class WebLearnDocsView extends GetView<WebLearnDocsController> {
  static const routeName = '/web-explore/learn-docs';
  const WebLearnDocsView({super.key});

  static final _sec = WebNavData.bySlug('explore');
  static const _color = Color(0xFFF59E0B);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFFFFBEB),
        body: _LearnDocsBody(controller: controller, isDark: isDark),
      ),
    );
  }
}

class _LearnDocsBody extends StatefulWidget {
  final WebLearnDocsController controller;
  final bool isDark;
  const _LearnDocsBody({required this.controller, required this.isDark});
  @override
  State<_LearnDocsBody> createState() => _LearnDocsBodyState();
}

class _LearnDocsBodyState extends State<_LearnDocsBody> with TickerProviderStateMixin {
  late AnimationController _slideCtrl;
  late Animation<Offset> _slideAnim;
  late AnimationController _glowCtrl;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _slideCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700))..forward();
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));
    _glowCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _glowAnim = CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() { _slideCtrl.dispose(); _glowCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final c = widget.controller;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 320,
          pinned: true,
          elevation: 0,
          backgroundColor: const Color(0xFFF59E0B),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Learn Docs', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
            background: AnimatedBuilder(
              animation: _glowAnim,
              builder: (_, __) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(const Color(0xFFF59E0B), const Color(0xFFEA580C), _glowAnim.value)!,
                      const Color(0xFF92400E),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(children: [
                  Positioned(right: -60, bottom: -30,
                    child: Container(width: 260, height: 260,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        shape: BoxShape.circle,
                      ))),
                  Positioned(left: -40, top: 20,
                    child: Container(width: 160, height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.04),
                        shape: BoxShape.circle,
                      ))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('Category-Indexed Docs', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 12),
                        const Text('Learn Docs\nby Category', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900, height: 1.2)),
                        const SizedBox(height: 8),
                        Text('Structured reading rooms. Pair with Learn & Fun for deep study rhythm.',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13, height: 1.4)),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),

        // Search bar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: SlideTransition(
              position: _slideAnim,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.isDark ? WColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: const Color(0xFFF59E0B).withValues(alpha: 0.15), blurRadius: 20, offset: const Offset(0, 6))],
                ),
                child: TextField(
                  onChanged: (v) => c.searchQuery.value = v.toLowerCase(),
                  decoration: InputDecoration(
                    hintText: 'Search documents and categories...',
                    prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFFF59E0B)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Category chips
        SliverToBoxAdapter(
          child: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: List.generate(c.categories.length, (i) {
                final sel = c.selectedCategory.value == i;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () => c.selectedCategory.value = i,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: sel ? const Color(0xFFF59E0B) : (widget.isDark ? WColors.cardDark : Colors.white),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: sel ? [BoxShadow(color: const Color(0xFFF59E0B).withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4))] : [],
                      ),
                      child: Text(c.categories[i],
                        style: TextStyle(
                          color: sel ? Colors.white : (widget.isDark ? Colors.white70 : Colors.black54),
                          fontWeight: sel ? FontWeight.w800 : FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          )),
        ),

        // Flutter 2026 banner
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E1B4B), Color(0xFF312E81)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Icon(Icons.auto_awesome, color: Color(0xFFA78BFA), size: 18),
                    const SizedBox(width: 8),
                    const Text('Flutter 2026 Powers This', style: TextStyle(color: Color(0xFFA78BFA), fontWeight: FontWeight.w700, fontSize: 13)),
                  ]),
                  const SizedBox(height: 12),
                  ...[
                    ('Sliver lazy loading', 'Thousands of docs load instantly with SliverList.builder'),
                    ('Adaptive search', 'Debounced search with GetX reactivity — zero rebuilds'),
                    ('AI doc summaries', 'ML-powered reading time estimates and key highlights'),
                    ('Offline-first cache', 'IndexedDB + Hive sync for reading without internet'),
                  ].map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text('▸ ', style: TextStyle(color: Color(0xFFF59E0B), fontSize: 12)),
                      Expanded(child: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: '${e.$1}: ', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                          TextSpan(text: e.$2, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12, height: 1.4)),
                        ],
                      ))),
                    ]),
                  )),
                ],
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        // Section label
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Text('All Contents', style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w900,
              color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
            )),
          ),
        ),

        // Items grid
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 360,
              childAspectRatio: 2.4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                final items = WebNavData.bySlug('explore').items;
                if (i >= items.length) return null;
                final item = items[i];
                return _DocCard(item: item, index: i, isDark: widget.isDark);
              },
              childCount: WebNavData.bySlug('explore').items.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 48)),
      ],
    );
  }
}

class _DocCard extends StatelessWidget {
  final WebNavItem item;
  final int index;
  final bool isDark;
  const _DocCard({required this.item, required this.index, required this.isDark});

  static const _colors = [Color(0xFFF59E0B), Color(0xFFEA580C), Color(0xFF10B981), Color(0xFF3B82F6), Color(0xFF8B5CF6), Color(0xFFEC4899)];

  @override
  Widget build(BuildContext context) {
    final c = _colors[index % _colors.length];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.withValues(alpha: 0.25)),
        boxShadow: [BoxShadow(color: c.withValues(alpha: 0.08), blurRadius: 12)],
      ),
      child: Row(children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(color: c.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
          child: Icon(item.icon, color: c, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item.title, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: isDark ? Colors.white : const Color(0xFF0F172A)), maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 3),
            Text(item.description, style: TextStyle(fontSize: 10.5, color: isDark ? Colors.white54 : Colors.black45), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        )),
        Icon(Icons.chevron_right_rounded, color: c, size: 18),
      ]),
    );
  }
}
