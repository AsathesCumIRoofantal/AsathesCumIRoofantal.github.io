import 'package:air_app/modules/counting_reports/counting_reports_best_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'counting_reports_controller.dart';

// ─────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────
class _CountEntry {
  final int number;
  final String hindi;
  final String hindiWord;
  final String englishWord;
  final String transliteration;
  final String usage;
  const _CountEntry({
    required this.number,
    required this.hindi,
    required this.hindiWord,
    required this.englishWord,
    required this.transliteration,
    required this.usage,
  });
}

class _ReportSection {
  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final List<String> points;
  const _ReportSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.points,
  });
}

// ─────────────────────────────────────────────
//  STATIC DATA
// ─────────────────────────────────────────────
const List<_CountEntry> _basicCounts = [
  _CountEntry(
    number: 1,
    hindi: '१',
    hindiWord: 'एक',
    englishWord: 'One',
    transliteration: 'Ek',
    usage: 'एक व्यक्ति / One person',
  ),
  _CountEntry(
    number: 2,
    hindi: '२',
    hindiWord: 'दो',
    englishWord: 'Two',
    transliteration: 'Do',
    usage: 'दो किताबें / Two books',
  ),
  _CountEntry(
    number: 3,
    hindi: '३',
    hindiWord: 'तीन',
    englishWord: 'Three',
    transliteration: 'Teen',
    usage: 'तीन दिन / Three days',
  ),
  _CountEntry(
    number: 4,
    hindi: '४',
    hindiWord: 'चार',
    englishWord: 'Four',
    transliteration: 'Chaar',
    usage: 'चार बजे / Four o\'clock',
  ),
  _CountEntry(
    number: 5,
    hindi: '५',
    hindiWord: 'पाँच',
    englishWord: 'Five',
    transliteration: 'Paanch',
    usage: 'पाँच रुपये / Five rupees',
  ),
  _CountEntry(
    number: 6,
    hindi: '६',
    hindiWord: 'छह',
    englishWord: 'Six',
    transliteration: 'Chhah',
    usage: 'छह महीने / Six months',
  ),
  _CountEntry(
    number: 7,
    hindi: '७',
    hindiWord: 'सात',
    englishWord: 'Seven',
    transliteration: 'Saat',
    usage: 'सात दिन / Seven days',
  ),
  _CountEntry(
    number: 8,
    hindi: '८',
    hindiWord: 'आठ',
    englishWord: 'Eight',
    transliteration: 'Aath',
    usage: 'आठ घंटे / Eight hours',
  ),
  _CountEntry(
    number: 9,
    hindi: '९',
    hindiWord: 'नौ',
    englishWord: 'Nine',
    transliteration: 'Nau',
    usage: 'नौ बजे / Nine o\'clock',
  ),
  _CountEntry(
    number: 10,
    hindi: '१०',
    hindiWord: 'दस',
    englishWord: 'Ten',
    transliteration: 'Das',
    usage: 'दस साल / Ten years',
  ),
  _CountEntry(
    number: 11,
    hindi: '११',
    hindiWord: 'ग्यारह',
    englishWord: 'Eleven',
    transliteration: 'Gyaarah',
    usage: 'ग्यारह बजे / Eleven o\'clock',
  ),
  _CountEntry(
    number: 12,
    hindi: '१२',
    hindiWord: 'बारह',
    englishWord: 'Twelve',
    transliteration: 'Baarah',
    usage: 'बारह महीने / Twelve months',
  ),
  _CountEntry(
    number: 15,
    hindi: '१५',
    hindiWord: 'पंद्रह',
    englishWord: 'Fifteen',
    transliteration: 'Pandrah',
    usage: 'पंद्रह दिन / Fifteen days',
  ),
  _CountEntry(
    number: 20,
    hindi: '२०',
    hindiWord: 'बीस',
    englishWord: 'Twenty',
    transliteration: 'Bees',
    usage: 'बीस रुपये / Twenty rupees',
  ),
  _CountEntry(
    number: 25,
    hindi: '२५',
    hindiWord: 'पच्चीस',
    englishWord: 'Twenty-five',
    transliteration: 'Pacchees',
    usage: 'पच्चीस प्रतिशत / Twenty-five percent',
  ),
  _CountEntry(
    number: 30,
    hindi: '३०',
    hindiWord: 'तीस',
    englishWord: 'Thirty',
    transliteration: 'Tees',
    usage: 'तीस दिन / Thirty days',
  ),
  _CountEntry(
    number: 40,
    hindi: '४०',
    hindiWord: 'चालीस',
    englishWord: 'Forty',
    transliteration: 'Chaalees',
    usage: 'चालीस साल / Forty years',
  ),
  _CountEntry(
    number: 50,
    hindi: '५०',
    hindiWord: 'पचास',
    englishWord: 'Fifty',
    transliteration: 'Pachaas',
    usage: 'पचास प्रतिशत / Fifty percent',
  ),
  _CountEntry(
    number: 60,
    hindi: '६०',
    hindiWord: 'साठ',
    englishWord: 'Sixty',
    transliteration: 'Saath',
    usage: 'साठ मिनट / Sixty minutes',
  ),
  _CountEntry(
    number: 70,
    hindi: '७०',
    hindiWord: 'सत्तर',
    englishWord: 'Seventy',
    transliteration: 'Sattar',
    usage: 'सत्तर किलो / Seventy kilos',
  ),
  _CountEntry(
    number: 80,
    hindi: '८०',
    hindiWord: 'अस्सी',
    englishWord: 'Eighty',
    transliteration: 'Assi',
    usage: 'अस्सी रुपये / Eighty rupees',
  ),
  _CountEntry(
    number: 90,
    hindi: '९०',
    hindiWord: 'नब्बे',
    englishWord: 'Ninety',
    transliteration: 'Nabbe',
    usage: 'नब्बे दिन / Ninety days',
  ),
  _CountEntry(
    number: 100,
    hindi: '१००',
    hindiWord: 'सौ',
    englishWord: 'Hundred',
    transliteration: 'Sau',
    usage: 'एक सौ / One hundred',
  ),
];

const List<_CountEntry> _largeCounts = [
  _CountEntry(
    number: 1000,
    hindi: '१,०००',
    hindiWord: 'एक हज़ार',
    englishWord: 'One Thousand',
    transliteration: 'Ek Hazaar',
    usage: 'एक हज़ार रुपये / ₹1,000',
  ),
  _CountEntry(
    number: 10000,
    hindi: '१०,०००',
    hindiWord: 'दस हज़ार',
    englishWord: 'Ten Thousand',
    transliteration: 'Das Hazaar',
    usage: 'दस हज़ार लोग / 10,000 people',
  ),
  _CountEntry(
    number: 100000,
    hindi: '१,००,०००',
    hindiWord: 'एक लाख',
    englishWord: 'One Lakh',
    transliteration: 'Ek Lakh',
    usage: 'एक लाख रुपये / ₹1,00,000',
  ),
  _CountEntry(
    number: 1000000,
    hindi: '१०,००,०००',
    hindiWord: 'दस लाख',
    englishWord: 'Ten Lakh / 1 Million',
    transliteration: 'Das Lakh',
    usage: 'दस लाख की आबादी / 10 lakh population',
  ),
  _CountEntry(
    number: 10000000,
    hindi: '१,००,००,०००',
    hindiWord: 'एक करोड़',
    englishWord: 'One Crore / 10 Million',
    transliteration: 'Ek Crore',
    usage: 'एक करोड़ रुपये / ₹1 Crore',
  ),
  _CountEntry(
    number: 1000000000,
    hindi: '१,००,००,००,०००',
    hindiWord: 'एक अरब',
    englishWord: 'One Billion',
    transliteration: 'Ek Arab',
    usage: 'एक अरब लोग / 1 Billion people',
  ),
];

const List<_ReportSection> _reportSections = [
  _ReportSection(
    title: 'Bilingual Report Builder',
    icon: Icons.description_outlined,
    color: Color(0xFF7C4DFF),
    description:
        'Compose reports that display figures side-by-side in Hindi and English with a single input.',
    points: [
      'Enter any number once — the builder auto-generates both the Hindi word form (Devanagari) and the English word form simultaneously.',
      'Indian number system formatting: figures display in lakh/crore notation for Hindi and million/billion for international English.',
      'Sentence-level templates: "कुल राशि पाँच लाख रुपये है / Total amount is Five Lakh Rupees" — ready to paste into any report.',
      'Batch mode: paste a column of numbers and get the full bilingual word list exported in seconds.',
      'Custom prefix/suffix support: add currency symbols, units (kg, km, %) and they carry through both language outputs.',
    ],
  ),
  _ReportSection(
    title: 'Reporting Rhythm Scheduler',
    icon: Icons.schedule_outlined,
    color: Color(0xFF00BCD4),
    description:
        'Set a recurring cadence for automatic report generation and delivery.',
    points: [
      'Daily, weekly, fortnightly, or monthly schedules — set once and the report generates automatically at your chosen time.',
      'Stakeholder distribution list: add names and channels (WhatsApp, email, AIR inbox) so reports reach the right people without manual forwarding.',
      'Missed-report alerts: if a scheduled report fails to generate, you get a notification before the stakeholder notices.',
      'Pause and resume: temporarily suspend a schedule during holidays or off-cycles without deleting the configuration.',
      'Audit trail: every auto-generated report is timestamped and archived so you can prove what was sent and when.',
    ],
  ),
  _ReportSection(
    title: 'Topic-Based Report Search',
    icon: Icons.search_outlined,
    color: Color(0xFF4CAF50),
    description:
        'Search across all counting reports by topic, date range, or language.',
    points: [
      'Full-text search across report titles, summaries, and number fields in both Hindi and English simultaneously.',
      'Date-range filter: pull all reports from a specific week, month, or custom window with one tap.',
      'Topic tags: label reports by category (finance, attendance, inventory, population) for instant filtered views.',
      'Language filter: show only Hindi-primary, English-primary, or bilingual reports depending on your audience.',
      'Saved searches: bookmark your most-used filter combinations so recurring lookups take one tap, not five.',
    ],
  ),
  _ReportSection(
    title: 'Localised Side-by-Side View',
    icon: Icons.compare_outlined,
    color: Color(0xFFFF9800),
    description:
        'View any report in a split-screen layout with Hindi on one side and English on the other.',
    points: [
      'Split-screen layout with Hindi (Devanagari) on the left and English on the right — scroll both panes in sync.',
      'Font size controls per pane: increase Hindi script size independently for audiences less familiar with Devanagari.',
      'Highlight mode: tap any number in one pane and the equivalent in the other pane highlights automatically.',
      'Presentation mode: full-screen split view optimised for projectors and large displays in mixed-language meetings.',
      'Print layout: the side-by-side view exports as a formatted PDF with both scripts on the same page, properly aligned.',
    ],
  ),
  _ReportSection(
    title: 'Export & Share',
    icon: Icons.share_outlined,
    color: Color(0xFFE91E63),
    description:
        'Export bilingual reports as PDF, CSV, or shareable links with formatting preserved.',
    points: [
      'PDF export with Devanagari font embedding so Hindi text renders correctly on any device without font installation.',
      'CSV export with separate columns for numeral, Hindi word, English word, and transliteration — ready for spreadsheets.',
      'Shareable link: generate a read-only link to any report that opens in a browser without requiring an AIR account.',
      'Direct share to WhatsApp, email, and AIR channels with the report attached and a pre-filled message.',
      'QR code generation: create a QR code for any report so physical documents can link to the live digital version.',
    ],
  ),
];

// ─────────────────────────────────────────────
//  MAIN VIEW
// ─────────────────────────────────────────────
class CountingReportsView extends GetView<CountingReportsController> {
  final bool isEmbedded;
  const CountingReportsView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            _buildSliverAppBar(context, isDark, innerBoxIsScrolled),
          ],
          body: const TabBarView(
            children: [
              _BasicCountsTab(),
              _LargeNumbersTab(),
              _ReportToolsTab(),
              CountingReportsBestView(isEmbedded: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, bool isDark, bool collapsed) {
    final theme = Theme.of(context);
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: isDark
          ? const Color(0xFF0D0B1A)
          : const Color(0xFF2C255F),
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: const EdgeInsets.only(left: 16, bottom: 56),
        title: const Text(
          'Counting Reports',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.5,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [const Color(0xFF1A0533), const Color(0xFF0D1B4A)]
                  : [const Color(0xFF2C255F), const Color(0xFF1565C0)],
            ),
          ),
          child: Stack(
            children: [
              // Decorative circles
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.04),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.04),
                  ),
                ),
              ),
              // Header content
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 60),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: const Text(
                        '१२३',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'गिनती की रिपोर्ट',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Bilingual counting reference — Hindi & English in one rhythm.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottom: TabBar(
        indicatorColor: Colors.amber,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white54,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          letterSpacing: 0.5,
        ),
        tabs: const [
          Tab(icon: Icon(Icons.looks_one_outlined, size: 18), text: '1–100'),
          Tab(
            icon: Icon(Icons.account_balance_outlined, size: 18),
            text: 'Lakh–Arab',
          ),
          Tab(
            icon: Icon(Icons.description_outlined, size: 18),
            text: 'Report Tools',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 1 — BASIC COUNTS (1–100)
// ─────────────────────────────────────────────
class _BasicCountsTab extends StatelessWidget {
  const _BasicCountsTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        // Info banner
        _InfoBanner(
          icon: Icons.info_outline_rounded,
          color: const Color(0xFF7C4DFF),
          text:
              'Tap any card to copy the Hindi word. '
              'Each entry shows the Devanagari numeral, word form, transliteration, and a usage example.',
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        // Grid of count cards
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.05,
          ),
          itemCount: _basicCounts.length,
          itemBuilder: (context, index) {
            return _CountCard(
              entry: _basicCounts[index],
              isDark: isDark,
              onSurface: onSurface,
            );
          },
        ),
        const SizedBox(height: 24),
        // Ordinals section
        _SectionHeader(
          title: 'Ordinal Numbers — क्रमसूचक संख्याएँ',
          icon: Icons.format_list_numbered,
          color: const Color(0xFF00BCD4),
        ),
        const SizedBox(height: 12),
        ..._ordinals.map(
          (o) => _OrdinalRow(data: o, isDark: isDark, onSurface: onSurface),
        ),
        const SizedBox(height: 24),
        // Fractions section
        _SectionHeader(
          title: 'Fractions — भिन्न',
          icon: Icons.pie_chart_outline,
          color: const Color(0xFF4CAF50),
        ),
        const SizedBox(height: 12),
        ..._fractions.map(
          (f) => _FractionRow(data: f, isDark: isDark, onSurface: onSurface),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 2 — LARGE NUMBERS (Hazar–Arab)
// ─────────────────────────────────────────────
class _LargeNumbersTab extends StatelessWidget {
  const _LargeNumbersTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        _InfoBanner(
          icon: Icons.account_balance_outlined,
          color: const Color(0xFFFF9800),
          text:
              'Indian number system uses Lakh (1,00,000) and Crore (1,00,00,000). '
              'International system uses Million and Billion. Both are shown side by side.',
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        // Large number cards — full width stacked
        ..._largeCounts.map(
          (entry) => _LargeNumberCard(
            entry: entry,
            isDark: isDark,
            onSurface: onSurface,
          ),
        ),
        const SizedBox(height: 24),
        // Comparison table
        _SectionHeader(
          title: 'Indian vs International Scale',
          icon: Icons.compare_arrows_rounded,
          color: const Color(0xFFE91E63),
        ),
        const SizedBox(height: 12),
        _ScaleComparisonTable(isDark: isDark, onSurface: onSurface),
        const SizedBox(height: 24),
        // Number formatting rules
        _SectionHeader(
          title: 'Formatting Rules — संख्या लेखन नियम',
          icon: Icons.rule_outlined,
          color: const Color(0xFF7C4DFF),
        ),
        const SizedBox(height: 12),
        ..._formattingRules.map(
          (rule) => _RuleCard(rule: rule, isDark: isDark, onSurface: onSurface),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 3 — REPORT TOOLS
// ─────────────────────────────────────────────
class _ReportToolsTab extends StatelessWidget {
  const _ReportToolsTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        _InfoBanner(
          icon: Icons.description_outlined,
          color: const Color(0xFF4CAF50),
          text:
              'Generate and review bilingual counting reports. '
              'Maintain a consistent reporting rhythm so numbers, totals, and summaries are always clear across languages.',
          isDark: isDark,
        ),
        const SizedBox(height: 20),
        // Quick converter card
        _QuickConverterCard(isDark: isDark, onSurface: onSurface),
        const SizedBox(height: 24),
        // Report tool sections
        ..._reportSections.map(
          (s) => _ReportSectionCard(
            section: s,
            isDark: isDark,
            onSurface: onSurface,
          ),
        ),
        const SizedBox(height: 24),
        // Tips card
        _SectionHeader(
          title: 'Pro Tips — रिपोर्ट लेखन सुझाव',
          icon: Icons.tips_and_updates_outlined,
          color: const Color(0xFFFF9800),
        ),
        const SizedBox(height: 12),
        ..._proTips.map(
          (tip) => _TipRow(tip: tip, isDark: isDark, onSurface: onSurface),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  REUSABLE WIDGETS
// ─────────────────────────────────────────────

class _InfoBanner extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final bool isDark;
  const _InfoBanner({
    required this.icon,
    required this.color,
    required this.text,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.5,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  const _SectionHeader({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.5,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}

class _CountCard extends StatelessWidget {
  final _CountEntry entry;
  final bool isDark;
  final Color onSurface;
  const _CountCard({
    required this.entry,
    required this.isDark,
    required this.onSurface,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark
        ? const Color(0xFF1E193B).withValues(alpha: 0.7)
        : Colors.white;

    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: entry.hindiWord));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Copied: ${entry.hindiWord}'),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(
              0xFF7C4DFF,
            ).withValues(alpha: isDark ? 0.25 : 0.15),
          ),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.hindi,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF7C4DFF),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C4DFF).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${entry.number}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C4DFF),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              entry.hindiWord,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: onSurface,
              ),
            ),
            Text(
              entry.transliteration,
              style: TextStyle(
                fontSize: 11,
                color: onSurface.withValues(alpha: 0.5),
                fontStyle: FontStyle.italic,
              ),
            ),
            const Spacer(),
            Text(
              entry.usage,
              style: TextStyle(
                fontSize: 10,
                color: onSurface.withValues(alpha: 0.55),
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _LargeNumberCard extends StatelessWidget {
  final _CountEntry entry;
  final bool isDark;
  final Color onSurface;
  const _LargeNumberCard({
    required this.entry,
    required this.isDark,
    required this.onSurface,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E193B).withValues(alpha: 0.7)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFF9800).withValues(alpha: isDark ? 0.3 : 0.2),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Hindi numeral badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  entry.hindi,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.hindiWord,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    Text(
                      entry.transliteration,
                      style: TextStyle(
                        fontSize: 12,
                        color: onSurface.withValues(alpha: 0.5),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: '${entry.hindiWord} / ${entry.englishWord}',
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Copied: ${entry.hindiWord}'),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                child: Icon(
                  Icons.copy_outlined,
                  size: 18,
                  color: onSurface.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFF9800).withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ENGLISH',
                        style: TextStyle(
                          fontSize: 9,
                          letterSpacing: 1.5,
                          color: onSurface.withValues(alpha: 0.45),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        entry.englishWord,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 32,
                  color: onSurface.withValues(alpha: 0.1),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'USAGE',
                        style: TextStyle(
                          fontSize: 9,
                          letterSpacing: 1.5,
                          color: onSurface.withValues(alpha: 0.45),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        entry.usage,
                        style: TextStyle(
                          fontSize: 11,
                          color: onSurface.withValues(alpha: 0.7),
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScaleComparisonTable extends StatelessWidget {
  final bool isDark;
  final Color onSurface;
  const _ScaleComparisonTable({required this.isDark, required this.onSurface});

  @override
  Widget build(BuildContext context) {
    const rows = [
      ['एक हज़ार', '1,000', '1 Thousand', '10³'],
      ['दस हज़ार', '10,000', '10 Thousand', '10⁴'],
      ['एक लाख', '1,00,000', '100 Thousand', '10⁵'],
      ['दस लाख', '10,00,000', '1 Million', '10⁶'],
      ['एक करोड़', '1,00,00,000', '10 Million', '10⁷'],
      ['दस करोड़', '10,00,00,000', '100 Million', '10⁸'],
      ['एक अरब', '1,00,00,00,000', '1 Billion', '10⁹'],
    ];
    final headerBg = const Color(
      0xFFE91E63,
    ).withValues(alpha: isDark ? 0.2 : 0.1);
    final rowBg = isDark
        ? const Color(0xFF1E193B).withValues(alpha: 0.5)
        : Colors.white;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE91E63).withValues(alpha: 0.25),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2.5),
          3: FlexColumnWidth(1),
        },
        children: [
          TableRow(
            decoration: BoxDecoration(color: headerBg),
            children: ['हिंदी', 'Indian', 'International', 'Power']
                .map(
                  (h) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    child: Text(
                      h,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE91E63),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          ...rows.asMap().entries.map(
            (e) => TableRow(
              decoration: BoxDecoration(
                color: e.key.isEven ? rowBg : rowBg.withValues(alpha: 0.6),
              ),
              children: e.value
                  .map(
                    (cell) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 9,
                      ),
                      child: Text(
                        cell,
                        style: TextStyle(
                          fontSize: 11,
                          color: onSurface.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickConverterCard extends StatefulWidget {
  final bool isDark;
  final Color onSurface;
  const _QuickConverterCard({required this.isDark, required this.onSurface});

  @override
  State<_QuickConverterCard> createState() => _QuickConverterCardState();
}

class _QuickConverterCardState extends State<_QuickConverterCard> {
  final _ctrl = TextEditingController();
  String _hindiResult = '—';
  String _englishResult = '—';

  static const _ones = [
    '',
    'एक',
    'दो',
    'तीन',
    'चार',
    'पाँच',
    'छह',
    'सात',
    'आठ',
    'नौ',
    'दस',
    'ग्यारह',
    'बारह',
    'तेरह',
    'चौदह',
    'पंद्रह',
    'सोलह',
    'सत्रह',
    'अठारह',
    'उन्नीस',
    'बीस',
    'इक्कीस',
    'बाईस',
    'तेईस',
    'चौबीस',
    'पच्चीस',
    'छब्बीस',
    'सत्ताईस',
    'अट्ठाईस',
    'उनतीस',
    'तीस',
    'इकतीस',
    'बत्तीस',
    'तैंतीस',
    'चौंतीस',
    'पैंतीस',
    'छत्तीस',
    'सैंतीस',
    'अड़तीस',
    'उनतालीस',
    'चालीस',
    'इकतालीस',
    'बयालीस',
    'तैंतालीस',
    'चौवालीस',
    'पैंतालीस',
    'छियालीस',
    'सैंतालीस',
    'अड़तालीस',
    'उनचास',
    'पचास',
    'इक्यावन',
    'बावन',
    'तिरपन',
    'चौवन',
    'पचपन',
    'छप्पन',
    'सत्तावन',
    'अट्ठावन',
    'उनसठ',
    'साठ',
    'इकसठ',
    'बासठ',
    'तिरसठ',
    'चौंसठ',
    'पैंसठ',
    'छियासठ',
    'सड़सठ',
    'अड़सठ',
    'उनहत्तर',
    'सत्तर',
    'इकहत्तर',
    'बहत्तर',
    'तिहत्तर',
    'चौहत्तर',
    'पचहत्तर',
    'छिहत्तर',
    'सतहत्तर',
    'अठहत्तर',
    'उनासी',
    'अस्सी',
    'इक्यासी',
    'बयासी',
    'तिरासी',
    'चौरासी',
    'पचासी',
    'छियासी',
    'सत्तासी',
    'अट्ठासी',
    'नवासी',
    'नब्बे',
    'इक्यानवे',
    'बानवे',
    'तिरानवे',
    'चौरानवे',
    'पचानवे',
    'छियानवे',
    'सत्तानवे',
    'अट्ठानवे',
    'निन्यानवे',
  ];

  String _toHindi(int n) {
    if (n == 0) return 'शून्य';
    if (n < 0) return 'ऋण ${_toHindi(-n)}';
    if (n <= 99) return _ones[n];
    if (n < 200) return 'एक सौ ${n > 100 ? _ones[n - 100] : ''}'.trim();
    if (n < 1000) {
      return '${_ones[n ~/ 100]} सौ ${n % 100 > 0 ? _ones[n % 100] : ''}'
          .trim();
    }
    if (n < 100000) {
      return '${_toHindi(n ~/ 1000)} हज़ार ${n % 1000 > 0 ? _toHindi(n % 1000) : ''}'
          .trim();
    }
    if (n < 10000000) {
      return '${_toHindi(n ~/ 100000)} लाख ${n % 100000 > 0 ? _toHindi(n % 100000) : ''}'
          .trim();
    }
    if (n < 1000000000) {
      return '${_toHindi(n ~/ 10000000)} करोड़ ${n % 10000000 > 0 ? _toHindi(n % 10000000) : ''}'
          .trim();
    }
    return '${_toHindi(n ~/ 1000000000)} अरब ${n % 1000000000 > 0 ? _toHindi(n % 1000000000) : ''}'
        .trim();
  }

  static const _engOnes = [
    '',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten',
    'Eleven',
    'Twelve',
    'Thirteen',
    'Fourteen',
    'Fifteen',
    'Sixteen',
    'Seventeen',
    'Eighteen',
    'Nineteen',
  ];
  static const _engTens = [
    '',
    '',
    'Twenty',
    'Thirty',
    'Forty',
    'Fifty',
    'Sixty',
    'Seventy',
    'Eighty',
    'Ninety',
  ];

  String _toEnglish(int n) {
    if (n == 0) return 'Zero';
    if (n < 0) return 'Minus ${_toEnglish(-n)}';
    if (n < 20) return _engOnes[n];
    if (n < 100) {
      return '${_engTens[n ~/ 10]}${n % 10 > 0 ? ' ${_engOnes[n % 10]}' : ''}';
    }
    if (n < 1000) {
      return '${_engOnes[n ~/ 100]} Hundred${n % 100 > 0 ? ' ${_toEnglish(n % 100)}' : ''}';
    }
    if (n < 100000) {
      return '${_toEnglish(n ~/ 1000)} Thousand${n % 1000 > 0 ? ' ${_toEnglish(n % 1000)}' : ''}';
    }
    if (n < 10000000) {
      return '${_toEnglish(n ~/ 100000)} Lakh${n % 100000 > 0 ? ' ${_toEnglish(n % 100000)}' : ''}';
    }
    if (n < 1000000000) {
      return '${_toEnglish(n ~/ 10000000)} Crore${n % 10000000 > 0 ? ' ${_toEnglish(n % 10000000)}' : ''}';
    }
    return '${_toEnglish(n ~/ 1000000000)} Arab${n % 1000000000 > 0 ? ' ${_toEnglish(n % 1000000000)}' : ''}';
  }

  void _convert() {
    final raw = _ctrl.text.trim().replaceAll(',', '');
    final n = int.tryParse(raw);
    if (n == null) {
      setState(() {
        _hindiResult = 'अमान्य संख्या';
        _englishResult = 'Invalid number';
      });
      return;
    }
    setState(() {
      _hindiResult = _toHindi(n);
      _englishResult = _toEnglish(n);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.isDark
              ? [const Color(0xFF1A0533), const Color(0xFF0D1B4A)]
              : [const Color(0xFF2C255F), const Color(0xFF1565C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calculate_outlined,
                color: Colors.amber,
                size: 22,
              ),
              const SizedBox(width: 10),
              const Text(
                'Quick Number Converter',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Type any number — get Hindi & English words instantly',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: 'e.g. 125000',
                    hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  onChanged: (_) => _convert(),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(text: '$_hindiResult / $_englishResult'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Copied both!'),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.copy_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'हिंदी  ',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _hindiResult,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'ENG   ',
                      style: TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _englishResult,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 14,
                        ),
                      ),
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
}

class _ReportSectionCard extends StatelessWidget {
  final _ReportSection section;
  final bool isDark;
  final Color onSurface;
  const _ReportSectionCard({
    required this.section,
    required this.isDark,
    required this.onSurface,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E193B).withValues(alpha: 0.7)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: section.color.withValues(alpha: isDark ? 0.3 : 0.18),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
          leading: Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: section.color.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(section.icon, color: section.color, size: 20),
          ),
          title: Text(
            section.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: onSurface,
            ),
          ),
          subtitle: Text(
            section.description,
            style: TextStyle(
              fontSize: 11,
              color: onSurface.withValues(alpha: 0.55),
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          iconColor: onSurface.withValues(alpha: 0.4),
          collapsedIconColor: onSurface.withValues(alpha: 0.35),
          children: section.points
              .map(
                (p) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: section.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          p,
                          style: TextStyle(
                            fontSize: 13,
                            color: onSurface.withValues(alpha: 0.75),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _OrdinalRow extends StatelessWidget {
  final Map<String, String> data;
  final bool isDark;
  final Color onSurface;
  const _OrdinalRow({
    required this.data,
    required this.isDark,
    required this.onSurface,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E193B).withValues(alpha: 0.5)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF00BCD4).withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 36,
            child: Text(
              data['num']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF00BCD4),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              data['hindi']!,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: onSurface,
              ),
            ),
          ),
          Expanded(
            child: Text(
              data['english']!,
              style: TextStyle(
                fontSize: 13,
                color: onSurface.withValues(alpha: 0.65),
              ),
            ),
          ),
          Text(
            data['trans']!,
            style: TextStyle(
              fontSize: 11,
              color: onSurface.withValues(alpha: 0.45),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _FractionRow extends StatelessWidget {
  final Map<String, String> data;
  final bool isDark;
  final Color onSurface;
  const _FractionRow({
    required this.data,
    required this.isDark,
    required this.onSurface,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E193B).withValues(alpha: 0.5)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              data['symbol']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50),
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              data['hindi']!,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: onSurface,
              ),
            ),
          ),
          Expanded(
            child: Text(
              data['english']!,
              style: TextStyle(
                fontSize: 13,
                color: onSurface.withValues(alpha: 0.65),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleCard extends StatelessWidget {
  final Map<String, String> rule;
  final bool isDark;
  final Color onSurface;
  const _RuleCard({
    required this.rule,
    required this.isDark,
    required this.onSurface,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E193B).withValues(alpha: 0.5)
            : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF7C4DFF).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rule['title']!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: const Color(0xFF7C4DFF),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            rule['desc']!,
            style: TextStyle(
              fontSize: 12.5,
              color: onSurface.withValues(alpha: 0.72),
              height: 1.45,
            ),
          ),
          if (rule['example'] != null) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF7C4DFF).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                rule['example']!,
                style: TextStyle(
                  fontSize: 12,
                  color: onSurface.withValues(alpha: 0.8),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  final Map<String, String> tip;
  final bool isDark;
  final Color onSurface;
  const _TipRow({
    required this.tip,
    required this.isDark,
    required this.onSurface,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E193B).withValues(alpha: 0.5)
            : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFFF9800).withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: const Color(0xFFFF9800).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.tips_and_updates_outlined,
              color: Color(0xFFFF9800),
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip['title']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: onSurface,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  tip['desc']!,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: onSurface.withValues(alpha: 0.7),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  STATIC DATA LISTS
// ─────────────────────────────────────────────

const List<Map<String, String>> _ordinals = [
  {
    'num': '1st',
    'hindi': 'पहला / पहली',
    'english': 'First',
    'trans': 'Pehla / Pehli',
  },
  {
    'num': '2nd',
    'hindi': 'दूसरा / दूसरी',
    'english': 'Second',
    'trans': 'Doosra / Doosri',
  },
  {
    'num': '3rd',
    'hindi': 'तीसरा / तीसरी',
    'english': 'Third',
    'trans': 'Teesra / Teesri',
  },
  {
    'num': '4th',
    'hindi': 'चौथा / चौथी',
    'english': 'Fourth',
    'trans': 'Chautha / Chauthi',
  },
  {
    'num': '5th',
    'hindi': 'पाँचवाँ / पाँचवीं',
    'english': 'Fifth',
    'trans': 'Paanchvaan',
  },
  {
    'num': '6th',
    'hindi': 'छठा / छठी',
    'english': 'Sixth',
    'trans': 'Chhatha / Chhathi',
  },
  {
    'num': '7th',
    'hindi': 'सातवाँ / सातवीं',
    'english': 'Seventh',
    'trans': 'Saatvaan',
  },
  {
    'num': '8th',
    'hindi': 'आठवाँ / आठवीं',
    'english': 'Eighth',
    'trans': 'Aathvaan',
  },
  {
    'num': '9th',
    'hindi': 'नौवाँ / नौवीं',
    'english': 'Ninth',
    'trans': 'Nauvaan',
  },
  {
    'num': '10th',
    'hindi': 'दसवाँ / दसवीं',
    'english': 'Tenth',
    'trans': 'Dasvaan',
  },
];

const List<Map<String, String>> _fractions = [
  {'symbol': '½', 'hindi': 'आधा', 'english': 'Half'},
  {'symbol': '¼', 'hindi': 'चौथाई', 'english': 'Quarter'},
  {'symbol': '¾', 'hindi': 'तीन चौथाई', 'english': 'Three-quarters'},
  {'symbol': '⅓', 'hindi': 'एक तिहाई', 'english': 'One-third'},
  {'symbol': '⅔', 'hindi': 'दो तिहाई', 'english': 'Two-thirds'},
  {'symbol': '1½', 'hindi': 'डेढ़', 'english': 'One and a half'},
  {'symbol': '2½', 'hindi': 'ढाई', 'english': 'Two and a half'},
  {'symbol': '0', 'hindi': 'शून्य', 'english': 'Zero'},
];

const List<Map<String, String>> _formattingRules = [
  {
    'title': 'Indian Comma Placement',
    'desc':
        'In Indian English, commas are placed after the first 3 digits from the right, then every 2 digits. This differs from the international standard of every 3 digits.',
    'example': 'Indian: 1,00,00,000  |  International: 10,000,000',
  },
  {
    'title': 'Lakh vs Million',
    'desc':
        '1 Lakh = 1,00,000 = 100,000. Use "Lakh" in Indian-context reports and "Hundred Thousand" or "0.1 Million" for international audiences.',
    'example': '₹5,00,000 = Five Lakh Rupees = 0.5 Million Rupees',
  },
  {
    'title': 'Crore vs Ten Million',
    'desc':
        '1 Crore = 1,00,00,000 = 10,000,000. Always clarify which system you are using when the audience is mixed.',
    'example': '₹1,00,00,000 = One Crore Rupees = Ten Million Rupees',
  },
  {
    'title': 'Currency Word Forms',
    'desc':
        'When writing amounts in words, the currency name follows the number. In Hindi, रुपये comes after the number word.',
    'example': 'पाँच हज़ार रुपये / Five Thousand Rupees',
  },
  {
    'title': 'Devanagari Numerals',
    'desc':
        'Devanagari has its own numeral set (०–९). Use them in Hindi-primary documents; use Arabic numerals (0–9) in bilingual or English-primary documents.',
    'example': '१,२३,४५६ (Devanagari)  |  1,23,456 (Arabic)',
  },
];

const List<Map<String, String>> _proTips = [
  {
    'title': 'Always state the number system',
    'desc':
        'At the top of any bilingual report, note whether figures use the Indian system (lakh/crore) or the international system (million/billion) to avoid confusion.',
  },
  {
    'title': 'Use the converter before finalising',
    'desc':
        'Run every key figure through the Quick Converter above before submitting a report — a single wrong word form can change the meaning of a financial document.',
  },
  {
    'title': 'Consistency within a document',
    'desc':
        'Pick one number system and stick to it throughout a single report. Mixing lakh and million in the same document is a common source of errors.',
  },
  {
    'title': 'Round numbers read better',
    'desc':
        'In narrative reports, round to the nearest lakh or crore and note the exact figure in a footnote. "Approximately five crore" is easier to absorb than "four crore eighty-seven lakh."',
  },
  {
    'title': 'Spell out numbers below ten',
    'desc':
        'In running text, spell out numbers from one to nine in both Hindi and English. Use numerals for 10 and above unless starting a sentence.',
  },
  {
    'title': 'Verify large numbers twice',
    'desc':
        'Crore and Arab are easy to confuse when typing quickly. Always verify large figures by reading the numeral aloud in both languages before sending.',
  },
];
