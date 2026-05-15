import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'forgivness_controller.dart';

class ForgivnessView extends GetView<ForgivnessController> {
  const ForgivnessView({super.key});

  static const _lavender = Color(0xFF8B5CF6);
  static const _purple = Color(0xFF9333EA);
  static const _sky = Color(0xFF38BDF8);
  static const _teal = Color(0xFF14B8A6);
  static const _rose = Color(0xFFF43F5E);
  static const _amber = Color(0xFFF59E0B);
  static const _green = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF060210) : const Color(0xFFFAF5FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text('FORGIVENESS', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 14)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.healing_outlined, color: _lavender, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel('WHAT FORGIVENESS IS', Icons.info_outline, _lavender, onSurface),
          const SizedBox(height: 12),
          _buildClarityPanel(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('THE FORGIVENESS PATH', Icons.timeline_outlined, _purple, onSurface),
          const SizedBox(height: 12),
          _buildCard(context, isDark, Icons.info_outline, _sky, 'What Forgiveness Is Not',
              'Forgiveness is not condoning, excusing, or forgetting. It is not reconciliation — you can forgive someone and still choose not to have them in your life. Clarify your definition so you\'re not waiting for the wrong thing. '
              'Confusing forgiveness with reconciliation is the most common reason people resist forgiving — they fear that forgiving means tolerating further harm. Separating the two removes that barrier. '
              'AIR\'s forgiveness module starts with this clarification because the definition you carry determines what you think you are trying to do — and most resistance to forgiveness evaporates once the definition is corrected.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.edit_note_outlined, _rose, 'The Harm Inventory',
              'Before you can release something, you have to name it clearly. Write down what happened, how it affected you, and what you\'re still carrying. Specificity is the first step toward genuine release. '
              'Vague grievances are held indefinitely; specific, named grievances can be addressed, processed, and released. Writing forces the specificity that emotional memory resists. '
              'The inventory uses a three-part structure: the event, the impact on you, and what you are still experiencing in the present — separating past facts from current emotional reality.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.timeline_outlined, _lavender, 'Forgiveness Timeline',
              'Forgiveness is rarely a single moment — it\'s a process that unfolds over time. Log where you are in the process for each significant harm and track your movement without forcing a timeline. '
              'Progress in forgiveness is rarely linear — you may move forward, plateau, and temporarily regress, especially when reminders surface. Logging tracks the general trend without demanding perfection. '
              'Timeline milestones include: naming the harm, choosing to begin forgiving, experiencing reduced emotional charge, and reaching genuine release — each logged separately to honour the real pace of the process.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.self_improvement_outlined, _purple, 'Self-Forgiveness',
              'The hardest forgiveness is often the kind you owe yourself. Log the mistakes you\'re still punishing yourself for, acknowledge what you\'ve learned, and practise releasing the self-judgment that no longer serves you. '
              'Self-criticism beyond the point of learning is self-punishment masquerading as responsibility — it produces shame, not growth. Genuine self-forgiveness requires honestly accepting what happened without using it as a permanent identity label. '
              'The self-forgiveness journal prompts you to write to yourself with the same compassion you would offer a close friend who made the same mistake — a reframing technique that consistently accelerates the release process.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.lock_open_outlined, _teal, 'Forgiveness vs. Trust',
              'Forgiving someone does not automatically restore trust. Trust is rebuilt through consistent behaviour over time. Keep these two processes separate — you can forgive fully while rebuilding trust slowly. '
              'Conflating the two creates a false choice between forgiving and protecting yourself. The distinction enables you to be both open-hearted and appropriately boundaried at the same time. '
              'Trust-rebuilding has its own tracker: specific behaviours you are looking for, consistency windows, and honest ratings — a concrete process that prevents both premature trust and indefinite suspension of the relationship.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.free_cancellation_outlined, _amber, 'Releasing Resentment',
              'Resentment is the cost of unforgiveness — it occupies mental space that could be used for something better. Log the resentments you\'re carrying and the cost they\'re extracting from your daily energy and focus. '
              'Research consistently shows that chronic resentment elevates cortisol, disrupts sleep, and narrows creative thinking — making resentment a measurable performance liability, not just an emotional burden. '
              'The resentment cost log makes the extraction visible in concrete terms — time spent ruminating, decisions coloured by residual anger, relationships affected — so the case for releasing is not just moral but practical.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.handshake_outlined, _green, 'Repair & Reconciliation',
              'When both parties want to rebuild, forgiveness can open the door to reconciliation. Log the steps you\'ve taken toward repair — the conversations, the agreements, the new behaviours — and track whether trust is growing. '
              'Repair requires genuine behavioural change from the person who caused harm, not just apology — the reconciliation tracker holds both parties accountable to the specific agreements made. '
              'Not every forgiven relationship needs to be reconciled — the log helps you distinguish between relationships worth rebuilding and those where forgiveness serves you without requiring renewed contact.'),
          const SizedBox(height: 20),
          _buildForgivenessQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color(0xFF14043A), const Color(0xFF0A021C)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _lavender.withOpacity(0.35)),
        boxShadow: [BoxShadow(color: _purple.withOpacity(0.12), blurRadius: 16)],
      ),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(
          color: _lavender.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
          child: const Icon(Icons.healing_outlined, color: _lavender, size: 28)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('THE PRACTICE OF RELEASE', style: TextStyle(fontSize: 9, color: _lavender, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 4),
          const Text('Forgiveness is a practice of release — letting go of the grip a past harm has on your present decisions — not pretending the harm never happened.',
              style: TextStyle(fontSize: 12, height: 1.4, color: Colors.white60)),
        ])),
      ]),
    );
  }

  Widget _buildSectionLabel(String title, IconData icon, Color color, Color onSurface) => Row(children: [
    Icon(icon, color: color, size: 16), const SizedBox(width: 8),
    Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: color)),
  ]);

  Widget _buildClarityPanel(BuildContext context, bool isDark, Color onSurface) {
    final checks = [
      ('IS releasing the grip of the past', Icons.check_rounded, _green),
      ('IS choosing not to let harm define what comes next', Icons.check_rounded, _green),
      ('IS NOT condoning or excusing the harm', Icons.close_rounded, _rose),
      ('IS NOT the same as reconciliation', Icons.close_rounded, _rose),
      ('IS NOT forgetting what happened', Icons.close_rounded, _rose),
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _lavender.withOpacity(0.06), borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _lavender.withOpacity(0.18)),
      ),
      child: Column(children: checks.map((c) => Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Row(children: [
          Icon(c.$2, color: c.$3, size: 14),
          const SizedBox(width: 8),
          Text('Forgiveness ', style: TextStyle(fontSize: 11, color: onSurface.withOpacity(0.55))),
          Expanded(child: Text(c.$1, style: TextStyle(fontSize: 11, color: onSurface, fontWeight: FontWeight.w500))),
        ]),
      )).toList()),
    );
  }

  Widget _buildCard(BuildContext context, bool isDark, IconData icon, Color color, String title, String body) {
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

  Widget _buildForgivenessQuote(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [_lavender.withOpacity(0.10), _teal.withOpacity(0.07)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _lavender.withOpacity(0.20)),
      ),
      child: Row(children: [
        const Icon(Icons.format_quote_rounded, color: _lavender, size: 28),
        const SizedBox(width: 12),
        Expanded(child: Text(
          '"Forgiveness is not an occasional act; it is a constant attitude." — Martin Luther King Jr.',
          style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, height: 1.4, color: onSurface),
        )),
      ]),
    );
  }
}
