import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({Key? key}) : super(key: key);

  static const _launch = Color(0xFF7C3AED);
  static const _violet = Color(0xFF8B5CF6);
  static const _blue = Color(0xFF3B82F6);
  static const _sky = Color(0xFF0EA5E9);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _cyan = Color(0xFF06B6D4);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF060310) : const Color(0xFFF5F3FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text('ONBOARDING', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 14)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.rocket_launch_rounded, color: _launch, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel('ONBOARDING PROGRESS', Icons.track_changes_rounded, _launch, onSurface),
          const SizedBox(height: 12),
          _buildProgressSteps(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('ONBOARDING RESOURCES', Icons.auto_stories_rounded, _blue, onSurface),
          const SizedBox(height: 12),
          _buildOnboardCard(context, isDark, Icons.checklist_rounded, _launch, 'Welcome Checklist',
              'Complete a short sequence of first-day tasks — profile setup, community introduction, and a quick orientation quiz — to establish your presence in AIR. '
              'The checklist is designed to take under 30 minutes and leaves you with everything you need to participate immediately. '
              'Each checklist item is accompanied by a 2-minute explainer video so you understand why the step matters, not just how to complete it — producing informed members, not just technically set-up ones.'),
          const SizedBox(height: 10),
          _buildOnboardCard(context, isDark, Icons.map_rounded, _blue, 'Orientation Map',
              'Explore a visual map of AIR\'s modules, communities, and key resources so you know where to go for what you need. '
              'The map is interactive — tap any area to get a plain-language description of its purpose and a suggested first action. '
              'The map is updated each time a significant new feature launches, so returning members can use it as a "what\'s new" guide in addition to its primary orientation function.'),
          const SizedBox(height: 10),
          _buildOnboardCard(context, isDark, Icons.person_add_rounded, _cyan, 'Buddy Assignment',
              'Get matched with an experienced AIR member who will answer your first questions, make introductions, and check in during your first two weeks. '
              'Buddy relationships reduce the anxiety of being new and dramatically accelerate the time to feeling genuinely at home. '
              'Buddy matching uses your profile interests, working style, and goals to find someone whose experience is genuinely relevant to your situation rather than assigning randomly by availability.'),
          const SizedBox(height: 10),
          _buildOnboardCard(context, isDark, Icons.lightbulb_rounded, _amber, 'First Contribution Prompt',
              'Receive a personalised prompt for your first meaningful contribution — matched to your skills and interests — so you can add value before you feel fully settled. '
              'Early contribution is the fastest path to belonging; the prompt removes the paralysis of not knowing where to start. '
              'The prompt is intentionally modest — a contribution within your comfortable skill range — so the first experience of giving to the community is positive and self-reinforcing rather than intimidating.'),
          const SizedBox(height: 10),
          _buildOnboardCard(context, isDark, Icons.menu_book_rounded, _sky, 'Culture & Norms Primer',
              'Read a concise guide to how AIR communicates, makes decisions, handles disagreement, and celebrates wins. '
              'Understanding the culture early prevents the accidental missteps that make new members feel like outsiders long after they have joined. '
              'The primer uses real examples from AIR\'s history — including examples of things that went wrong and how the community responded — so the culture description is grounded in actual behaviour, not aspirational statements.'),
          const SizedBox(height: 10),
          _buildOnboardCard(context, isDark, Icons.track_changes_rounded, _green, 'Onboarding Progress Tracker',
              'See your onboarding completion percentage and the specific steps remaining so you always know how close you are to being fully oriented. '
              'The tracker also unlocks access to advanced features as you complete each stage, rewarding progress with expanded capability. '
              'Completion milestones are shared with your buddy automatically so they can celebrate your progress and proactively offer help for upcoming stages rather than waiting for you to ask.'),
          const SizedBox(height: 20),
          _buildOnboardQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color(0xFF0E0440), const Color(0xFF07021F)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _launch.withOpacity(0.38)),
        boxShadow: [BoxShadow(color: _launch.withOpacity(0.14), blurRadius: 18)],
      ),
      child: Column(children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(
            color: _launch.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.rocket_launch_rounded, color: _violet, size: 28)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('YOUR WELCOME PATH', style: TextStyle(fontSize: 10, color: _violet, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 4),
            const Text('A great onboarding experience is the fastest way to convert a newcomer into a confident, contributing member of AIR. Let\'s get you fully oriented.',
                style: TextStyle(fontSize: 12, height: 1.4, color: Colors.white60)),
          ])),
        ]),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('3 of 6 stages complete', style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.55))),
          const Text('50%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _violet)),
        ]),
        const SizedBox(height: 8),
        Stack(children: [
          Container(height: 8, decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(4))),
          FractionallySizedBox(widthFactor: 0.5, child: Container(height: 8, decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF8B5CF6)]),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [BoxShadow(color: _launch.withOpacity(0.4), blurRadius: 6)],
          ))),
        ]),
      ]),
    );
  }

  Widget _buildSectionLabel(String title, IconData icon, Color color, Color onSurface) => Row(children: [
    Icon(icon, color: color, size: 16), const SizedBox(width: 8),
    Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: color)),
  ]);

  Widget _buildProgressSteps(BuildContext context, bool isDark, Color onSurface) {
    final steps = [
      ('Profile Setup', true, false),
      ('Community Introduction', true, false),
      ('Orientation Quiz', true, false),
      ('First Contribution', false, true),
      ('Culture Primer', false, false),
      ('Progress Completion', false, false),
    ];
    return Column(children: steps.asMap().entries.map((e) {
      final s = e.value;
      final color = s.$2 ? _green : s.$3 ? _amber : Colors.white24;
      return Container(
        margin: const EdgeInsets.only(bottom: 7),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(11),
          border: Border.all(color: color.withOpacity(0.18)),
        ),
        child: Row(children: [
          Icon(s.$2 ? Icons.check_circle_rounded : s.$3 ? Icons.play_circle_rounded : Icons.radio_button_unchecked_rounded,
              color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(s.$1, style: TextStyle(fontSize: 12, color: onSurface))),
          Text(s.$2 ? 'DONE' : s.$3 ? 'NEXT' : 'LOCKED',
              style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: color, letterSpacing: 1)),
        ]),
      );
    }).toList());
  }

  Widget _buildOnboardCard(BuildContext context, bool isDark, IconData icon, Color color, String title, String body) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.20)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(
          color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color, size: 18)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
          const SizedBox(height: 6),
          Text(body, style: TextStyle(fontSize: 12, height: 1.5, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.72))),
        ])),
      ]),
    );
  }

  Widget _buildOnboardQuote(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [_launch.withOpacity(0.10), _blue.withOpacity(0.07)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _launch.withOpacity(0.20)),
      ),
      child: Row(children: [
        const Icon(Icons.format_quote_rounded, color: _amber, size: 28),
        const SizedBox(width: 12),
        Expanded(child: Text(
          '"The beginning is the most important part of the work." — Plato',
          style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, height: 1.4, color: onSurface),
        )),
      ]),
    );
  }
}
