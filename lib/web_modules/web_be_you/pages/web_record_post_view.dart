import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_record_post_controller.dart';

class WebRecordPostView extends GetView<WebRecordPostController> {
  static const routeName = '/web-be_you/record-post';
  const WebRecordPostView({super.key});

  static final _sec = WebNavData.bySlug('be_you');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFF0FDF4),
        body: _Body(isDark: isDark, controller: controller),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final bool isDark;
  final WebRecordPostController controller;
  const _Body({required this.isDark, required this.controller});
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with TickerProviderStateMixin {
  late AnimationController _shimmerCtrl;
  late AnimationController _entryCtrl;
  late Animation<double> _entryAnim;

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    _entryCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600))..forward();
    _entryAnim = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutBack);
  }

  @override
  void dispose() { _shimmerCtrl.dispose(); _entryCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final sec = WebNavData.bySlug('be_you');
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          backgroundColor: const Color(0xFF059669),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Record Your Post', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
            background: AnimatedBuilder(
              animation: _shimmerCtrl,
              builder: (_, __) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF059669), Color(0xFF047857), Color(0xFF065F46)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(children: [
                  Positioned(right: -30, top: 20,
                    child: Container(width: 200, height: 200,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [Colors.white.withValues(alpha: 0.08), Colors.transparent],
                        ),
                        shape: BoxShape.circle,
                      ))),
                  // Shimmer line effect
                  Positioned(
                    left: -200 + _shimmerCtrl.value * 600,
                    top: 0, bottom: 0,
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.white.withValues(alpha: 0.06), Colors.transparent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 56),
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
                          child: const Text('Capture · Log · Share', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 12),
                        const Text('Record\nYour Story', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900, height: 1.2)),
                        const SizedBox(height: 8),
                        Text('Milestones, notes, or experiences — preserved forever in your profile.',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13, height: 1.4)),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),

        // Post type selector
        SliverToBoxAdapter(
          child: ScaleTransition(
            scale: _entryAnim,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Post Format', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800,
                    color: widget.isDark ? Colors.white : const Color(0xFF0F172A))),
                  const SizedBox(height: 12),
                  Obx(() => Row(
                    children: widget.controller.types.map((t) {
                      final sel = widget.controller.postType.value == t;
                      return Expanded(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: GestureDetector(
                          onTap: () => widget.controller.postType.value = t,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: sel ? const Color(0xFF059669) : (widget.isDark ? WColors.cardDark : Colors.white),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: sel ? [BoxShadow(color: const Color(0xFF059669).withValues(alpha: 0.35), blurRadius: 10)] : [],
                            ),
                            child: Column(children: [
                              Icon(
                                t == 'Text' ? Icons.text_fields : t == 'Image' ? Icons.image_outlined : t == 'Audio' ? Icons.mic_outlined : t == 'Video' ? Icons.videocam_outlined : Icons.layers_outlined,
                                color: sel ? Colors.white : const Color(0xFF059669), size: 18,
                              ),
                              const SizedBox(height: 4),
                              Text(t, style: TextStyle(color: sel ? Colors.white : (widget.isDark ? Colors.white70 : Colors.black54), fontSize: 10, fontWeight: FontWeight.w700)),
                            ]),
                          ),
                        ),
                      ));
                    }).toList(),
                  )),
                ],
              ),
            ),
          ),
        ),

        // Mock editor glassmorphism card
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.isDark ? WColors.cardDark : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF059669).withValues(alpha: 0.2)),
                boxShadow: [BoxShadow(color: const Color(0xFF059669).withValues(alpha: 0.08), blurRadius: 20)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFFF5F56), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFFFBD2E), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF27C93F), shape: BoxShape.circle)),
                    const Spacer(),
                    Text('Rich Editor v2.6', style: TextStyle(fontSize: 11, color: widget.isDark ? Colors.white38 : Colors.black38, fontFamily: 'monospace')),
                  ]),
                  const SizedBox(height: 16),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: widget.isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
                    ),
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Start writing your post...', style: TextStyle(color: widget.isDark ? Colors.white24 : Colors.black26, fontSize: 14)),
                        const Spacer(),
                        Row(children: [
                          const Spacer(),
                          Text('0 / 2000 words', style: TextStyle(fontSize: 10, color: widget.isDark ? Colors.white38 : Colors.black38)),
                        ]),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(spacing: 8, children: [Icons.format_bold, Icons.format_italic, Icons.format_list_bulleted, Icons.link, Icons.image_outlined].map((icon) =>
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF059669).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, size: 16, color: const Color(0xFF059669)),
                    )).toList()),
                ],
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        // Flutter 2026 features
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF065F46), Color(0xFF059669)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [
                    Icon(Icons.flutter_dash, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text('Flutter 2026 Capabilities', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14)),
                  ]),
                  const SizedBox(height: 14),
                  ...[
                    ('Real-time collaborative editing', 'CRDTs + Flutter Impeller for zero-latency co-authoring'),
                    ('AI writing assist', 'On-device LLM suggests continuations as you type'),
                    ('Voice-to-rich-text', 'Speech recognition with punctuation and formatting'),
                    ('Auto-media processing', 'Images compressed, videos transcribed on upload'),
                  ].map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(width: 6, height: 6, margin: const EdgeInsets.only(top: 5, right: 10),
                        decoration: const BoxDecoration(color: Color(0xFF6EE7B7), shape: BoxShape.circle)),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(e.$1, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                        Text(e.$2, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11, height: 1.4)),
                      ])),
                    ]),
                  )),
                ],
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Text('All Be-You Topics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: widget.isDark ? Colors.white : const Color(0xFF0F172A))),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                final items = WebNavData.bySlug('be_you').items;
                if (i >= items.length) return null;
                final item = items[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: widget.isDark ? WColors.cardDark : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF059669).withValues(alpha: 0.15)),
                    ),
                    child: Row(children: [
                      Container(width: 42, height: 42, decoration: BoxDecoration(color: const Color(0xFF059669).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                        child: Icon(item.icon, color: const Color(0xFF059669), size: 21)),
                      const SizedBox(width: 14),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(item.title, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: widget.isDark ? Colors.white : const Color(0xFF0F172A))),
                        const SizedBox(height: 3),
                        Text(item.description, style: TextStyle(fontSize: 11.5, color: widget.isDark ? Colors.white54 : Colors.black45, height: 1.3)),
                      ])),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF059669)),
                    ]),
                  ),
                );
              },
              childCount: WebNavData.bySlug('be_you').items.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
      ],
    );
  }
}
