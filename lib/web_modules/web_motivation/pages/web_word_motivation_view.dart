import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_word_motivation_controller.dart';

class WebWordMotivationView extends GetView<WebWordMotivationController> {
  static const routeName = '/web-motivation/word-of-motivation';
  const WebWordMotivationView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFFFF0F6),
        body: _Body(isDark: isDark, ctrl: controller),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final bool isDark;
  final WebWordMotivationController ctrl;
  const _Body({required this.isDark, required this.ctrl});
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with TickerProviderStateMixin {
  late AnimationController _bgCtrl;
  late AnimationController _quoteCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  static const _quotes = [
    (
      'The secret of getting ahead is getting started.',
      'Mark Twain',
      'Productivity',
    ),
    (
      'What you get by achieving your goals is not as important as what you become.',
      'Henry David Thoreau',
      'Growth',
    ),
    (
      'It always seems impossible until it is done.',
      'Nelson Mandela',
      'Persistence',
    ),
    (
      'Believe you can and you\'re halfway there.',
      'Theodore Roosevelt',
      'Mindset',
    ),
    (
      'Success is not final, failure is not fatal: It is the courage to continue that counts.',
      'Winston Churchill',
      'Resilience',
    ),
    (
      'The only way to do great work is to love what you do.',
      'Steve Jobs',
      'Purpose',
    ),
    (
      'In the middle of every difficulty lies opportunity.',
      'Albert Einstein',
      'Perspective',
    ),
  ];

  static const _gradients = [
    [Color(0xFFEC4899), Color(0xFFBE185D)],
    [Color(0xFF7C3AED), Color(0xFF5B21B6)],
    [Color(0xFF0284C7), Color(0xFF0369A1)],
    [Color(0xFF059669), Color(0xFF047857)],
    [Color(0xFFEA580C), Color(0xFFC2410C)],
    [Color(0xFFD4AF37), Color(0xFF92400E)],
    [Color(0xFFE11D48), Color(0xFF9F1239)],
  ];

  @override
  void initState() {
    super.initState();
    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    _quoteCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _quoteCtrl.forward();
    _fadeAnim = CurvedAnimation(parent: _quoteCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0.1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _quoteCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _quoteCtrl.dispose();
    super.dispose();
  }

  void _nextQuote() {
    _quoteCtrl.reverse().then((_) {
      widget.ctrl.nextQuote(_quotes.length);
      _quoteCtrl.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 320,
          pinned: true,
          backgroundColor: const Color(0xFFBE185D),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              'Word of Motivation',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
            ),
            background: AnimatedBuilder(
              animation: _bgCtrl,
              builder: (_, __) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(
                        const Color(0xFFEC4899),
                        const Color(0xFF7C3AED),
                        _bgCtrl.value,
                      )!,
                      const Color(0xFF9D174D),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    ...List.generate(5, (i) {
                      final a = i / 5 * math.pi * 2 + _bgCtrl.value * math.pi;
                      return Positioned(
                        left: 160 + 100 * math.cos(a),
                        top: 130 + 60 * math.sin(a),
                        child: Container(
                          width: 20.0 + i * 8,
                          height: 20.0 + i * 8,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(
                              alpha: 0.05 + 0.02 * i,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 56),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Daily Quotes · Curated Wisdom',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Words That\nMove You',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Curated motivational passages to reset morale on hard days.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Featured quote card
        SliverToBoxAdapter(
          child: Obx(() {
            final qi = widget.ctrl.activeQuote.value;
            final q = _quotes[qi];
            final g = _gradients[qi % _gradients.length];
            return GestureDetector(
              onHorizontalDragEnd: (d) {
                if (d.primaryVelocity != null && d.primaryVelocity! < -200)
                  _nextQuote();
              },
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: g,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: g[0].withValues(alpha: 0.4),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  q.$3,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => widget.ctrl.toggleLike(qi),
                                child: Icon(
                                  widget.ctrl.liked.contains(qi)
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Icon(
                            Icons.format_quote_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            q.$1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '— ${q.$2}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: _nextQuote,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Next',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),

        // Progress dots
        SliverToBoxAdapter(
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _quotes.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: widget.ctrl.activeQuote.value == i ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: widget.ctrl.activeQuote.value == i
                        ? const Color(0xFFEC4899)
                        : Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        // All quotes list
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Text(
              'All Quotes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((ctx, i) {
              if (i >= _quotes.length) return null;
              final q = _quotes[i];
              final g = _gradients[i % _gradients.length];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: widget.isDark ? WColors.cardDark : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: g[0].withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: g),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.format_quote_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              q.$1,
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: widget.isDark
                                    ? Colors.white
                                    : const Color(0xFF0F172A),
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '— ${q.$2}',
                              style: TextStyle(
                                fontSize: 11,
                                color: g[0],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: _quotes.length),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
      ],
    );
  }
}
