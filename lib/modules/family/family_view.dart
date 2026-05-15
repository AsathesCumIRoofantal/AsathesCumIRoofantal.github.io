import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'family_controller.dart';

class FamilyView extends GetView<FamilyController> {
  const FamilyView({Key? key}) : super(key: key);

  static const _warm = Color(0xFFEA580C);
  static const _amber = Color(0xFFF59E0B);
  static const _gold = Color(0xFFD97706);
  static const _green = Color(0xFF10B981);
  static const _teal = Color(0xFF0D9488);
  static const _rose = Color(0xFFE11D48);
  static const _blue = Color(0xFF3B82F6);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF0A0402) : const Color(0xFFFFF8F0);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text('FAMILY', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 14)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.family_restroom_outlined, color: _warm, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel('FAMILY STRUCTURE', Icons.people_outline, _warm, onSurface),
          const SizedBox(height: 12),
          _buildRoleCards(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('FAMILY TOOLS', Icons.build_rounded, _gold, onSurface),
          const SizedBox(height: 12),
          _buildFamCard(context, isDark, Icons.calendar_month_outlined, _blue, 'Shared Calendar',
              'A family without a shared calendar is a family that surprises each other with conflicts. Sync key dates — school events, appointments, travel — so no one is caught off guard. '
              'The shared calendar includes a colour-coding system by family member so glancing at the week reveals whose schedule is heaviest and who may need support that week. '
              'Recurring events are flagged for quarterly review so the calendar evolves with the family\'s actual schedule rather than accumulating obsolete commitments that no longer reflect real life.'),
          const SizedBox(height: 10),
          _buildFamCard(context, isDark, Icons.celebration_outlined, _amber, 'Family Rituals',
              'Rituals are the glue of family identity — Sunday dinners, bedtime routines, annual trips. Log your rituals, protect them from schedule creep, and add new ones as the family evolves. '
              'Rituals create the shared memory bank that family members draw on for identity and comfort, especially during periods of external stress or change. '
              'The ritual protection system alerts you when a protected ritual is at risk of being displaced by a conflicting commitment, prompting a conscious decision rather than a default drift away from what matters.'),
          const SizedBox(height: 10),
          _buildFamCard(context, isDark, Icons.chat_bubble_outline, _teal, 'Communication Norms',
              'How your family communicates under stress determines how well it holds together. Define your norms — no phones at dinner, weekly check-ins, a signal word for when someone needs space. '
              'Communication norms reduce the emotional cost of conflict by providing agreed frameworks before the heat of disagreement — neither party is inventing the rules while already upset. '
              'Norms are reviewed annually with all participating family members to ensure they continue to reflect the family\'s actual needs rather than becoming outdated rules enforced out of habit.'),
          const SizedBox(height: 10),
          _buildFamCard(context, isDark, Icons.home_outlined, _green, 'Household Responsibilities',
              'Chores and responsibilities assigned clearly prevent the invisible labour problem. Use AIR to map who owns what at home and rotate tasks fairly as circumstances change. '
              'The invisible labour audit surfaces tasks that are being done by one person invisibly — without recognition or rotation — and flags them for explicit assignment and acknowledgement. '
              'Responsibility maps are age-appropriate for younger family members — the system suggests developmental-stage-appropriate contributions that build capability and belonging without creating unfair burden.'),
          const SizedBox(height: 10),
          _buildFamCard(context, isDark, Icons.flag_outlined, _warm, 'Family Goals',
              'Families that set goals together — a vacation, a savings target, a home project — build shared purpose. Log your family goals and track progress so everyone feels invested. '
              'Shared goals create a "we" narrative that is distinct from the sum of individual "I" narratives — families with shared goals report higher cohesion and resilience during individual setbacks. '
              'Goal tracking includes a contribution board so each family member can see how their specific actions are advancing the shared goal, making contribution visible and motivating.'),
          const SizedBox(height: 10),
          _buildFamCard(context, isDark, Icons.favorite_border_outlined, _rose, 'One-on-One Time',
              'Individual attention within a family is as important as group time. Schedule dedicated one-on-one time with each family member and log what you talked about to deepen the connection. '
              'One-on-one time communicates individual value — that the person matters to you specifically, not just as a member of the group. Children especially register this distinction. '
              'The one-on-one log includes a prompt before each session to consider what that specific person has been navigating recently, enabling you to arrive with genuine interest rather than generic availability.'),
          const SizedBox(height: 10),
          _buildFamCard(context, isDark, Icons.people_outline, _gold, 'Family Roles',
              'Every family member plays a role — provider, nurturer, planner, peacemaker. Making these roles explicit reduces resentment and helps everyone know where they contribute most. '
              'Explicit roles prevent the assumption that someone else is handling a critical function — and they enable appreciation for contributions that might otherwise go unnoticed or unacknowledged. '
              'Role reviews happen twice a year — as life circumstances change, roles should evolve deliberately rather than drifting into patterns that no longer serve the family\'s current reality or values.'),
          const SizedBox(height: 20),
          _buildFamilyQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color(0xFF3A1500), const Color(0xFF1C0A00)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _warm.withOpacity(0.35)),
        boxShadow: [BoxShadow(color: _amber.withOpacity(0.10), blurRadius: 16)],
      ),
      child: Column(children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(
            color: _warm.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.family_restroom_outlined, color: _amber, size: 28)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('INTENTIONAL FAMILY DESIGN', style: TextStyle(fontSize: 9, color: _amber, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 4),
            const Text('Family in AIR is about being intentional with the people who matter most — defining roles, protecting rituals, and keeping shared life organised. Strong families run on clarity, not just love.',
                style: TextStyle(fontSize: 12, height: 1.4, color: Colors.white60)),
          ])),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          _stat('4', 'Members', _amber),
          const SizedBox(width: 16),
          _stat('7', 'Rituals', _gold),
          const SizedBox(width: 16),
          _stat('3', 'Goals', _green),
          const SizedBox(width: 16),
          _stat('2', 'Review Due', _rose),
        ]),
      ]),
    );
  }

  Widget _stat(String v, String l, Color c) => Expanded(child: Column(children: [
    Text(v, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: c)),
    Text(l, textAlign: TextAlign.center, style: TextStyle(fontSize: 8, color: c.withOpacity(0.8), height: 1.2)),
  ]));

  Widget _buildSectionLabel(String title, IconData icon, Color color, Color onSurface) => Row(children: [
    Icon(icon, color: color, size: 16), const SizedBox(width: 8),
    Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: color)),
  ]);

  Widget _buildRoleCards(BuildContext context, bool isDark, Color onSurface) {
    final roles = [
      (Icons.account_balance_wallet_rounded, 'Provider', _warm),
      (Icons.favorite_rounded, 'Nurturer', _rose),
      (Icons.event_note_rounded, 'Planner', _blue),
      (Icons.balance_rounded, 'Peacemaker', _teal),
    ];
    return GridView.count(
      crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.5,
      children: roles.map((r) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: r.$3.withOpacity(0.07), borderRadius: BorderRadius.circular(12),
          border: Border.all(color: r.$3.withOpacity(0.20)),
        ),
        child: Row(children: [
          Icon(r.$1, color: r.$3, size: 18),
          const SizedBox(width: 8),
          Text(r.$2, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: onSurface)),
        ]),
      )).toList(),
    );
  }

  Widget _buildFamCard(BuildContext context, bool isDark, IconData icon, Color color, String title, String body) {
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

  Widget _buildFamilyQuote(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [_warm.withOpacity(0.10), _gold.withOpacity(0.07)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _warm.withOpacity(0.20)),
      ),
      child: Row(children: [
        const Icon(Icons.format_quote_rounded, color: _amber, size: 28),
        const SizedBox(width: 12),
        Expanded(child: Text(
          '"Family is not an important thing. It\'s everything." — Michael J. Fox',
          style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, height: 1.4, color: onSurface),
        )),
      ]),
    );
  }
}
