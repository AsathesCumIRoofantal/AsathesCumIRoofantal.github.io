import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_ask_anything_controller.dart';

class WebAskAnythingView extends GetView<WebAskAnythingController> {
  static const routeName = '/web-wisdom/ask-anything';
  const WebAskAnythingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFEEF2FF),
        body: _Body(isDark: isDark, ctrl: controller),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final bool isDark;
  final WebAskAnythingController ctrl;
  const _Body({required this.isDark, required this.ctrl});
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;
  final _inputCtrl = TextEditingController();

  static const _faqs = [
    ('How does AIR handle personal data?', 'All data is encrypted end-to-end, stored on sovereign servers, and never sold to third parties.', Color(0xFF4F46E5), 42),
    ('What is the best way to start as a new member?', 'Begin with the guided tour in Aspects, then set up your profile and explore one section at a time.', Color(0xFF059669), 38),
    ('Can I use AIR features offline?', 'Most modules cache locally via Hive. You can read, draft, and review without internet.', Color(0xFF0284C7), 29),
    ('How do I contribute content to AIR?', 'Go to Aspects → Contribute to AIR and submit through the contribution form.', Color(0xFFEA580C), 21),
    ('What are credits and how do I earn them?', 'Credits are earned by contributing, completing courses, and engaging consistently in community spaces.', Color(0xFF7C3AED), 18),
  ];

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _pulseAnim = CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() { _pulseCtrl.dispose(); _inputCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          backgroundColor: const Color(0xFF4F46E5),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Ask Anything', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
            background: AnimatedBuilder(
              animation: _pulseAnim,
              builder: (_, __) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4338CA), Color(0xFF4F46E5), Color(0xFF312E81)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(children: [
                  Positioned(
                    right: 20, top: 20,
                    child: Container(
                      width: 160 + 10 * _pulseAnim.value,
                      height: 160 + 10 * _pulseAnim.value,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.04 + 0.02 * _pulseAnim.value),
                        shape: BoxShape.circle,
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
                          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                          child: const Text('Surface Questions · Follow Threads', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 12),
                        const Text('Ask Anything.\nGet Wisdom.', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, height: 1.2)),
                        const SizedBox(height: 8),
                        Text('Surface questions, follow threads, and invite answers from the community.',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13)),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),

        // Search + ask input
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.isDark ? WColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: const Color(0xFF4F46E5).withValues(alpha: 0.12), blurRadius: 20, offset: const Offset(0, 4))],
                ),
                child: Row(children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.search_rounded, color: Color(0xFF4F46E5)),
                  Expanded(child: TextField(
                    controller: _inputCtrl,
                    onChanged: (v) => widget.ctrl.searchText.value = v,
                    decoration: const InputDecoration(
                      hintText: 'Search or ask a question...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    ),
                  )),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(color: const Color(0xFF4F46E5), borderRadius: BorderRadius.circular(10)),
                    child: const Text('Ask', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
                  ),
                ]),
              ),
            ]),
          ),
        ),

        // Category filter
        SliverToBoxAdapter(
          child: Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: widget.ctrl.categories.map((cat) {
                final sel = widget.ctrl.activeCategory.value == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => widget.ctrl.activeCategory.value = cat,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                      decoration: BoxDecoration(
                        color: sel ? const Color(0xFF4F46E5) : Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: sel ? const Color(0xFF4F46E5) : Colors.grey.withValues(alpha: 0.3)),
                        boxShadow: sel ? [BoxShadow(color: const Color(0xFF4F46E5).withValues(alpha: 0.35), blurRadius: 10)] : [],
                      ),
                      child: Text(cat, style: TextStyle(
                        color: sel ? Colors.white : (widget.isDark ? Colors.white70 : Colors.black54),
                        fontWeight: sel ? FontWeight.w800 : FontWeight.w500, fontSize: 13,
                      )),
                    ),
                  ),
                );
              }).toList(),
            ),
          )),
        ),

        // Flutter 2026
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF1E1B4B), Color(0xFF312E81)]),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(children: [
                const Icon(Icons.psychology_rounded, color: Color(0xFFA5B4FC), size: 20),
                const SizedBox(width: 10),
                Expanded(child: Text(
                  'Flutter 2026: AI-powered answer ranking · Semantic search · Sliver thread trees · Real-time typing indicators',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11.5, height: 1.4),
                )),
              ]),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Text('Frequently Asked', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: widget.isDark ? Colors.white : const Color(0xFF0F172A))),
          ),
        ),

        // FAQ list
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                if (i >= _faqs.length) return null;
                final faq = _faqs[i];
                return _FAQTile(question: faq.$1, answer: faq.$2, color: faq.$3, votes: faq.$4, isDark: widget.isDark);
              },
              childCount: _faqs.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
      ],
    );
  }
}

class _FAQTile extends StatefulWidget {
  final String question, answer;
  final Color color;
  final int votes;
  final bool isDark;
  const _FAQTile({required this.question, required this.answer, required this.color, required this.votes, required this.isDark});

  @override
  State<_FAQTile> createState() => _FAQTileState();
}

class _FAQTileState extends State<_FAQTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: widget.isDark ? WColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _expanded ? widget.color.withValues(alpha: 0.4) : widget.color.withValues(alpha: 0.15)),
          boxShadow: _expanded ? [BoxShadow(color: widget.color.withValues(alpha: 0.1), blurRadius: 16)] : [],
        ),
        child: Column(children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Container(width: 36, height: 36, decoration: BoxDecoration(color: widget.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.question_mark_rounded, color: widget.color, size: 18)),
                const SizedBox(width: 12),
                Expanded(child: Text(widget.question, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: widget.isDark ? Colors.white : const Color(0xFF0F172A), height: 1.3))),
                const SizedBox(width: 8),
                Icon(_expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, color: widget.color, size: 22),
              ]),
            ),
          ),
          if (_expanded) ...[
            Divider(height: 1, color: widget.color.withValues(alpha: 0.1)),
            Padding(
              padding: const EdgeInsets.fromLTRB(64, 12, 16, 12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.answer, style: TextStyle(fontSize: 13, height: 1.6, color: widget.isDark ? Colors.white70 : Colors.black54)),
                const SizedBox(height: 10),
                Row(children: [
                  Icon(Icons.thumb_up_outlined, size: 14, color: widget.color),
                  const SizedBox(width: 4),
                  Text('${widget.votes} helpful', style: TextStyle(fontSize: 11.5, color: widget.color, fontWeight: FontWeight.w600)),
                ]),
              ]),
            ),
          ],
        ]),
      ),
    );
  }
}
