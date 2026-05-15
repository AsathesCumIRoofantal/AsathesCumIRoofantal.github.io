import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'skills_talents_controller.dart';

class SkillsTalentsView extends GetView<SkillsTalentsController> {
  const SkillsTalentsView({Key? key}) : super(key: key);

  static const _cyan = Color(0xFF06B6D4);
  static const _teal = Color(0xFF0D9488);
  static const _blue = Color(0xFF3B82F6);
  static const _violet = Color(0xFF7C3AED);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _rose = Color(0xFFE11D48);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF020D14) : const Color(0xFFF0FDFE);
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text('SKILLS & TALENTS',
            style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 14)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.workspace_premium_rounded, color: _amber, size: 22),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSkillMatrixHeader(onSurface),
          const SizedBox(height: 12),
          _buildSkillBars(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('SKILLS INVENTORY', Icons.checklist_rounded, _cyan, onSurface),
          const SizedBox(height: 12),
          _buildInfoCard(context, isDark, Icons.checklist_rounded, _cyan, 'Skills Inventory',
              'Catalogue your skills across categories — technical, interpersonal, creative, analytical, and leadership — with self-assessed proficiency levels and supporting evidence. '
              'The inventory is a living document; update it as you grow and AIR will automatically recalibrate the opportunities it surfaces for you. '
              'Each skill entry should include the context in which you\'ve demonstrated it and the most recent example of its application.'),
          const SizedBox(height: 10),
          _buildInfoCard(context, isDark, Icons.auto_awesome_rounded, _amber, 'Talent Spotlight',
              'Identify and articulate your natural talents — the things you do effortlessly that others find difficult — and understand how they translate into professional value. '
              'Talents are distinct from skills: skills are learned, talents are innate, and knowing the difference helps you position yourself more accurately. '
              'The Talent Spotlight prompts you with reflective questions drawn from strengths psychology to help you surface capabilities you may have taken for granted.'),
          const SizedBox(height: 24),
          _buildSectionLabel('SKILL CATEGORIES', Icons.category_rounded, _teal, onSurface),
          const SizedBox(height: 12),
          _buildCategoryGrid(context, isDark),
          const SizedBox(height: 24),
          _buildSectionLabel('GROWTH & MATCHING', Icons.trending_up_rounded, _violet, onSurface),
          const SizedBox(height: 12),
          _buildInfoCard(context, isDark, Icons.analytics_rounded, _rose, 'Skill Gap Analysis',
              'Compare your current skills against the requirements of roles, projects, or opportunities you are targeting to identify the specific gaps worth closing. '
              'Gap analysis turns vague ambition into a concrete development plan with clear priorities and measurable milestones. '
              'AIR visualises gaps as a radar chart so you can see at a glance which dimensions of your profile need the most attention.'),
          const SizedBox(height: 10),
          _buildInfoCard(context, isDark, Icons.connect_without_contact_rounded, _blue, 'Opportunity Matching',
              'See AIR-curated opportunities — projects, roles, collaborations, and challenges — specifically matched to your skills and talents profile. '
              'Matching is not just about what you can do; it accounts for what energises you, so the opportunities surfaced are ones you will actually want to pursue. '
              'Match scores are transparent — you can see exactly which skills triggered each recommendation and adjust your profile to fine-tune future matches.'),
          const SizedBox(height: 10),
          _buildInfoCard(context, isDark, Icons.verified_rounded, _green, 'Endorsements & Validation',
              'Collect endorsements from collaborators, managers, and peers that validate your self-assessed skills with real-world evidence and named sources. '
              'Endorsed skills carry more weight in AIR\'s matching algorithm and signal credibility to anyone reviewing your profile. '
              'Endorsement requests can be sent directly through AIR with a short brief about the context of the collaboration to help endorsers write specific, credible recommendations.'),
          const SizedBox(height: 10),
          _buildInfoCard(context, isDark, Icons.trending_up_rounded, _violet, 'Growth Trajectory',
              'Track how your skills have evolved over time — which areas have grown, which have plateaued, and which are emerging — with a visual timeline of your development. '
              'Seeing your trajectory builds confidence and helps you make informed decisions about where to invest your learning energy next. '
              'Quarter-on-quarter skill growth is reflected in your AIR contribution score and opens new pathways for recognition and advancement within the ecosystem.'),
          const SizedBox(height: 10),
          _buildInfoCard(context, isDark, Icons.school_rounded, _cyan, 'Skill-Building Resources',
              'Access AIR-recommended resources — courses, mentors, practice projects, and reading lists — tailored to the specific skills you are working to develop. '
              'Resources are ranked by effectiveness and time investment so you can choose the right learning path for your current situation. '
              'Community members who have recently developed the same skill are surfaced as potential peer-learning partners, making growth a shared endeavour rather than a solo effort.'),
          const SizedBox(height: 20),
          _buildActionBanner(context, isDark),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_cyan.withOpacity(0.15), _violet.withOpacity(0.10)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _cyan.withOpacity(0.30)),
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: _cyan.withOpacity(0.15), borderRadius: BorderRadius.circular(16)),
          child: const Icon(Icons.workspace_premium_rounded, color: _cyan, size: 30),
        ),
        const SizedBox(width: 16),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('SKILLS & TALENTS PROFILE', style: TextStyle(fontSize: 10, color: _cyan, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 6),
            Text('Build a clear inventory of your strengths — technical skills, soft skills, and natural talents — so AIR can pair them with the opportunities most likely to let them shine.',
                style: TextStyle(fontSize: 12, height: 1.4, color: onSurface.withOpacity(0.75))),
          ],
        )),
      ]),
    );
  }

  Widget _buildSkillMatrixHeader(Color onSurface) {
    return Row(children: [
      const Icon(Icons.bar_chart_rounded, color: _teal, size: 16),
      const SizedBox(width: 8),
      Text('PROFICIENCY MATRIX', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: _teal)),
    ]);
  }

  Widget _buildSkillBars(BuildContext context, bool isDark, Color onSurface) {
    final skills = [
      ('Technical Skills', 0.78, _cyan),
      ('Leadership', 0.65, _violet),
      ('Creative Thinking', 0.82, _amber),
      ('Communication', 0.71, _blue),
      ('Analytical Reasoning', 0.88, _green),
      ('Interpersonal', 0.74, _rose),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cyan.withOpacity(0.15)),
      ),
      child: Column(
        children: skills.map((s) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(s.$1, style: TextStyle(fontSize: 12, color: onSurface, fontWeight: FontWeight.w500)),
                  Text('${(s.$2 * 100).round()}%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: s.$3)),
                ],
              ),
              const SizedBox(height: 5),
              Stack(children: [
                Container(height: 6, decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.07), borderRadius: BorderRadius.circular(3))),
                FractionallySizedBox(
                  widthFactor: s.$2,
                  child: Container(height: 6, decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [s.$3.withOpacity(0.7), s.$3]),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [BoxShadow(color: s.$3.withOpacity(0.35), blurRadius: 4)],
                  )),
                ),
              ]),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildSectionLabel(String title, IconData icon, Color color, Color onSurface) {
    return Row(children: [
      Icon(icon, color: color, size: 16),
      const SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: color)),
    ]);
  }

  Widget _buildInfoCard(BuildContext context, bool isDark, IconData icon, Color color, String title, String body) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(
            color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 18)),
          const SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface)),
              const SizedBox(height: 6),
              Text(body, style: TextStyle(fontSize: 12, height: 1.5,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.72))),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context, bool isDark) {
    final cats = [
      (Icons.code_rounded, 'Technical', 'Programming, systems, tools, data', _cyan),
      (Icons.people_rounded, 'Interpersonal', 'Empathy, collaboration, listening', _rose),
      (Icons.brush_rounded, 'Creative', 'Design, ideation, storytelling', _amber),
      (Icons.insights_rounded, 'Analytical', 'Logic, research, pattern recognition', _green),
      (Icons.record_voice_over_rounded, 'Communication', 'Writing, speaking, presenting', _blue),
      (Icons.military_tech_rounded, 'Leadership', 'Vision, delegation, motivation', _violet),
    ];
    return GridView.count(
      crossAxisCount: 2, shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.7,
      children: cats.map((c) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: c.$4.withOpacity(0.07), borderRadius: BorderRadius.circular(14),
          border: Border.all(color: c.$4.withOpacity(0.20)),
        ),
        child: Row(children: [
          Icon(c.$1, color: c.$4, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(c.$2, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface)),
              Text(c.$3, style: TextStyle(fontSize: 9, height: 1.2,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.55)), overflow: TextOverflow.ellipsis),
            ],
          )),
        ]),
      )).toList(),
    );
  }

  Widget _buildActionBanner(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [_teal.withOpacity(0.12), _cyan.withOpacity(0.08)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _teal.withOpacity(0.22)),
      ),
      child: Row(children: [
        const Icon(Icons.add_circle_rounded, color: _teal, size: 24),
        const SizedBox(width: 12),
        Expanded(child: Text(
          'An honest skills profile is the foundation of every meaningful match, recommendation, and growth plan AIR generates for you. '
          'Keep it updated as you develop — your profile evolves with you.',
          style: TextStyle(fontSize: 11, height: 1.4,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.72)),
        )),
      ]),
    );
  }
}
