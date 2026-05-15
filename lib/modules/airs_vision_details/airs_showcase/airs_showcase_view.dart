import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'airs_showcase_controller.dart';

class AirsShowcaseView extends GetView<AirsShowcaseController> {
  const AirsShowcaseView({Key? key}) : super(key: key);

  static const _violet = Color(0xFF7C3AED);
  static const _indigo = Color(0xFF4F46E5);
  static const _pink = Color(0xFFDB2777);
  static const _cyan = Color(0xFF0891B2);
  static const _green = Color(0xFF059669);
  static const _orange = Color(0xFFEA580C);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF07030F) : const Color(0xFFF5F3FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: theme.colorScheme.onSurface,
        title: const Text("AIR'S SHOWCASE",
            style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 14)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _violet.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _violet.withOpacity(0.35)),
              ),
              child: const Text('LIVE', style: TextStyle(fontSize: 9, color: _violet, fontWeight: FontWeight.bold, letterSpacing: 1)),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroFeature(context, isDark),
          const SizedBox(height: 20),
          _buildImpactStats(context, isDark),
          const SizedBox(height: 24),
          _buildCategoryLabel('SUCCESS STORIES', Icons.auto_stories_rounded, _violet, context),
          const SizedBox(height: 12),
          ..._stories.map((s) => _buildStoryCard(context, isDark, s)),
          const SizedBox(height: 20),
          _buildCategoryLabel('INNOVATION SPOTLIGHTS', Icons.lightbulb_rounded, _pink, context),
          const SizedBox(height: 12),
          _buildInnovationGrid(context, isDark),
          const SizedBox(height: 24),
          _buildCategoryLabel('COMMUNITY EXEMPLARS', Icons.people_rounded, _cyan, context),
          const SizedBox(height: 12),
          ..._exemplars.map((e) => _buildExemplarRow(context, isDark, e)),
          const SizedBox(height: 24),
          _buildCategoryLabel('PARTNER ACHIEVEMENTS', Icons.diversity_3_rounded, _green, context),
          const SizedBox(height: 12),
          ..._partners.map((p) => _buildPartnerCard(context, isDark, p)),
          const SizedBox(height: 24),
          _buildSubmissionBanner(context, isDark),
        ],
      ),
    );
  }

  Widget _buildHeroFeature(BuildContext context, bool isDark) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4C0070), Color(0xFF1B0060), Color(0xFF000830)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _violet.withOpacity(0.40)),
        boxShadow: [BoxShadow(color: _violet.withOpacity(0.25), blurRadius: 24, offset: const Offset(0, 8))],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20, top: -20,
            child: Container(
              width: 140, height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _pink.withOpacity(0.08),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _pink.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('✦ FEATURED', style: TextStyle(fontSize: 9, color: _pink, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                    const SizedBox(width: 8),
                    const Text('2025 HIGHLIGHT', style: TextStyle(fontSize: 9, color: Colors.white38, letterSpacing: 1)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Identity Economy Launch',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, height: 1.1)),
                    const SizedBox(height: 8),
                    const Text(
                      'Over 5,000 identity-linked earning records were minted in the '
                      'first month of the Be-You & Earn Living economy — redefining '
                      'how contribution is valued inside AIR.',
                      style: TextStyle(fontSize: 11, height: 1.4, color: Colors.white60),
                      maxLines: 3, overflow: TextOverflow.ellipsis,
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

  Widget _buildImpactStats(BuildContext context, bool isDark) {
    final stats = [
      ('12', 'Stories', _violet), ('5K+', 'Lives\nTouched', _pink),
      ('98%', 'Quality\nPass Rate', _green), ('32', 'Partners', _cyan),
    ];
    return Row(
      children: stats.map((s) => Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            color: s.$3.withOpacity(0.07),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: s.$3.withOpacity(0.20)),
          ),
          child: Column(children: [
            Text(s.$1, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: s.$3)),
            const SizedBox(height: 4),
            Text(s.$2, textAlign: TextAlign.center,
                style: TextStyle(fontSize: 9, color: s.$3.withOpacity(0.8), letterSpacing: 0.5, height: 1.3)),
          ]),
        ),
      )).toList(),
    );
  }

  Widget _buildCategoryLabel(String label, IconData icon, Color color, BuildContext context) {
    return Row(children: [
      Icon(icon, color: color, size: 16),
      const SizedBox(width: 8),
      Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: color)),
      const Spacer(),
      Text('VIEW ALL', style: TextStyle(fontSize: 9, color: color.withOpacity(0.7), letterSpacing: 1)),
      Icon(Icons.chevron_right_rounded, size: 14, color: color.withOpacity(0.7)),
    ]);
  }

  Widget _buildStoryCard(BuildContext context, bool isDark, _ShowcaseStory s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: s.color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: s.color.withOpacity(0.20)),
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: s.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(s.icon, color: s.color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(s.title,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: s.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(s.category, style: TextStyle(fontSize: 8, color: s.color, letterSpacing: 0.5)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(s.summary, style: TextStyle(fontSize: 12, height: 1.4,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.65)),
                    maxLines: 3, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Text(s.outcome, style: TextStyle(fontSize: 11, color: s.color, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInnovationGrid(BuildContext context, bool isDark) {
    final innovations = [
      (Icons.hub_rounded, 'All-Space Atlas', 'Mapping every entity & union in the AIR ecosystem to a single navigable node.', _violet),
      (Icons.psychology_rounded, 'Identity Questionnaire', 'A philosophical phased framework that places individuals within their cognitive coordinates.', _pink),
      (Icons.account_balance_wallet_rounded, 'AIR-V Economy', 'Credits tied to real contribution — not arbitrary points but a transparent value record.', _orange),
      (Icons.science_rounded, 'Knowledge Engine', 'AI-assisted query resolution combined with peer-verified answers for every domain.', _cyan),
    ];
    return GridView.count(
      crossAxisCount: 2, shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.92,
      children: innovations.map((i) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.$4.withOpacity(0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: i.$4.withOpacity(0.18)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(i.$1, color: i.$4, size: 26),
            const SizedBox(height: 10),
            Text(i.$2, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 6),
            Expanded(child: Text(i.$3, style: TextStyle(fontSize: 11, height: 1.35,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.60)),
                overflow: TextOverflow.fade)),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildExemplarRow(BuildContext context, bool isDark, _Exemplar e) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _cyan.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _cyan.withOpacity(0.15),
              border: Border.all(color: _cyan.withOpacity(0.30)),
            ),
            child: Center(child: Text(e.initials,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: _cyan))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface)),
                Text(e.contribution, style: TextStyle(fontSize: 11, height: 1.3,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.60))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _green.withOpacity(0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(e.badge, style: const TextStyle(fontSize: 9, color: _green, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerCard(BuildContext context, bool isDark, _Partner p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _green.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _green.withOpacity(0.18)),
      ),
      child: Row(
        children: [
          Icon(p.icon, color: _green, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface)),
                const SizedBox(height: 3),
                Text(p.achievement, style: TextStyle(fontSize: 11, height: 1.3,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.62))),
              ],
            ),
          ),
          Text(p.year, style: const TextStyle(fontSize: 10, color: _green, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSubmissionBanner(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_violet.withOpacity(0.12), _pink.withOpacity(0.08)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _violet.withOpacity(0.22)),
      ),
      child: Row(
        children: [
          const Icon(Icons.upload_rounded, color: _violet, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('NOMINATE FOR SHOWCASE',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: _violet)),
                const SizedBox(height: 4),
                Text('Believe a project, person, or outcome deserves recognition? '
                    'Submit a nomination — reviewed within 72 hours and published with full attribution.',
                    style: TextStyle(fontSize: 11, height: 1.4,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.68))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShowcaseStory {
  final String title, summary, outcome, category;
  final IconData icon;
  final Color color;
  const _ShowcaseStory(this.title, this.summary, this.outcome, this.category, this.icon, this.color);
}

final _stories = [
  _ShowcaseStory(
    'Learn & Fun Reaches 10,000 Sessions',
    'The interactive knowledge grid launched as a small module and grew organically — '
    'driven by community enthusiasm and peer-to-peer sharing — to surpass 10,000 active '
    'learning sessions within its first six months of availability.',
    '↑ 340% engagement growth in Q3 2023', 'EDUCATION',
    Icons.school_rounded, Color(0xFF7C3AED)),
  _ShowcaseStory(
    'Wisdom Mode Unlocked By 500 Users',
    'The expert-supervised Wisdom Mode — accessible only after completing a rigorous philosophical '
    'assessment — has now been unlocked by 500 individuals, marking a milestone in quality-gated '
    'knowledge governance.',
    '500 verified Wisdom Access holders', 'GOVERNANCE',
    Icons.psychology_rounded, Color(0xFF0891B2)),
  _ShowcaseStory(
    'AIR-V Credits Distributed: 2M+',
    'The Be-You & Earn Living economy has distributed over 2 million AIR-V credits since activation, '
    'with the top 10% of contributors receiving equity-style benefits for their ongoing participation '
    'in the AIR ecosystem.',
    '₹2M+ in equivalent community value', 'ECONOMY',
    Icons.account_balance_wallet_rounded, Color(0xFFDB2777)),
  _ShowcaseStory(
    'Research & Development Publishes First Whitepaper',
    'AIR\'s R&D division published its inaugural whitepaper: "All-Space Intelligence Architectures" — '
    'detailing the entity-union taxonomy and philosophical coordinates system. Downloaded 1,200+ times '
    'in the first week of publication.',
    '1,200+ downloads · Peer-reviewed', 'RESEARCH',
    Icons.science_rounded, Color(0xFFEA580C)),
];

class _Exemplar {
  final String name, initials, contribution, badge;
  const _Exemplar(this.name, this.initials, this.contribution, this.badge);
}

final _exemplars = [
  _Exemplar('Ananya Krishnamurthy', 'AK', 'First to complete the full Identity Map and share methodology with 200+ peers.', 'PIONEER'),
  _Exemplar('Roshan Mehta', 'RM', 'Contributed 150+ knowledge entries — highest individual count in the 2024 cycle.', 'BUILDER'),
  _Exemplar('Priya Venkatesh', 'PV', 'Organised the first AIR community study circle with 40+ active members.', 'CONNECTOR'),
];

class _Partner {
  final String name, achievement, year;
  final IconData icon;
  const _Partner(this.name, this.achievement, this.year, this.icon);
}

final _partners = [
  _Partner('Sunrise Academic Foundation', 'Co-developed the Higher Studies scholarship matching engine.', '2024', Icons.school_rounded),
  _Partner('OpenMind Research Institute', 'Joint publication of three peer-reviewed knowledge taxonomy papers.', '2024', Icons.biotech_rounded),
  _Partner('Clarity Career Network', 'Integrated career pathway data with AIR\'s identity-to-earnings model.', '2025', Icons.work_rounded),
];
