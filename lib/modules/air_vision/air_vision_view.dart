import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirVisionView extends StatefulWidget {
  const AirVisionView({super.key});

  @override
  State<AirVisionView> createState() => _AirVisionViewState();
}

class _AirVisionViewState extends State<AirVisionView> {
  final TransformationController _transformationController =
      TransformationController();
  double _currentScale = 1.0;
  static const double _minScale = 0.6;
  static const double _maxScale = 4.0;
  static const double _scaleStep = 0.3;

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _zoomIn() {
    final newScale = (_currentScale + _scaleStep).clamp(_minScale, _maxScale);
    _setScale(newScale);
  }

  void _zoomOut() {
    final newScale = (_currentScale - _scaleStep).clamp(_minScale, _maxScale);
    _setScale(newScale);
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
    setState(() => _currentScale = 1.0);
  }

  void _setScale(double scale) {
    final Matrix4 m = _transformationController.value.clone();
    final double currentS = m.getMaxScaleOnAxis();
    final double factor = scale / currentS;
    m.scale(factor);
    _transformationController.value = m;
    setState(() => _currentScale = scale);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF08060F) : const Color(0xFFE8E8EC);
    final pageColor = isDark ? const Color(0xFFFAF9FF) : Colors.white;
    final inkColor = const Color(0xFF1A1A2E);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("AIR's Vision"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        actions: [
          // Zoom Out
          IconButton(
            icon: const Icon(Icons.remove_circle_outline_rounded),
            tooltip: 'Zoom Out',
            onPressed: _currentScale > _minScale ? _zoomOut : null,
          ),
          // Zoom percentage display
          GestureDetector(
            onTap: _resetZoom,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${(_currentScale * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          // Zoom In
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded),
            tooltip: 'Zoom In',
            onPressed: _currentScale < _maxScale ? _zoomIn : null,
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: GestureDetector(
        onDoubleTap: _resetZoom,
        child: InteractiveViewer(
          transformationController: _transformationController,
          minScale: _minScale,
          maxScale: _maxScale,
          onInteractionUpdate: (details) {
            setState(() {
              _currentScale = _transformationController.value.getMaxScaleOnAxis();
            });
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              children: [
                _buildCoverPage(pageColor, inkColor, context),
                const SizedBox(height: 20),
                _buildPage(
                  pageColor: pageColor,
                  inkColor: inkColor,
                  context: context,
                  pageNumber: '01',
                  title: 'What is AIR?',
                  icon: Icons.air,
                  accentColor: Colors.purpleAccent,
                  content: [
                    _para(
                      'AIR — All-Space Intelligence & Reasoning — is a living, ever-expanding knowledge ecosystem designed to categorise, map, and track every entity and union that exists in all of existence.',
                      inkColor,
                    ),
                    const SizedBox(height: 12),
                    _para(
                      'Founded under the AIR Organisation (governed by the Alifiyas-Mazeasta framework), the mission is simple yet profound: to make every node of existence known, transparent, and accountable — from atoms to galaxies, from individual persons to entire civilisations.',
                      inkColor,
                    ),
                    const SizedBox(height: 12),
                    _highlightBox(
                      '"Mapping all-space. Ensuring absolute transparency."',
                      Colors.purpleAccent,
                      context,
                    ),
                    const SizedBox(height: 12),
                    _para(
                      'The AIR App is the primary interface through which individuals, learners, experts, and organisations interact with this vast all-space atlas.',
                      inkColor,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildPage(
                  pageColor: pageColor,
                  inkColor: inkColor,
                  context: context,
                  pageNumber: '02',
                  title: 'All-Space Model — Entities & Unions',
                  icon: Icons.hub_outlined,
                  accentColor: Colors.tealAccent,
                  content: [
                    _sectionHeader('ENTITIES', Colors.tealAccent, inkColor),
                    const SizedBox(height: 8),
                    _para(
                      'An Entity is any discrete, identifiable node in all-space. This includes:',
                      inkColor,
                    ),
                    const SizedBox(height: 8),
                    ...['• Living beings — Humans, Animals, Plants, Microorganisms',
                        '• Non-living objects — Planets, Machines, Materials',
                        '• Abstract nodes — Emotions, Concepts, Theorems',
                        '• Phenomena — Gravity, Light, Sound, Time',
                        '• Digital entities — Software, AI, Data Structures']
                        .map((s) => _bulletLine(s, inkColor)),
                    const SizedBox(height: 16),
                    _sectionHeader('UNIONS', Colors.tealAccent, inkColor),
                    const SizedBox(height: 8),
                    _para(
                      'A Union is a relationship, grouping, or binding between two or more Entities. Types include:',
                      inkColor,
                    ),
                    const SizedBox(height: 8),
                    ...['• Pairs — Father & Child, Teacher & Student, Planet & Moon',
                        '• Groups — Families, Teams, Ecosystems, Galaxies',
                        '• Organisations — Companies, Governments, AIR itself',
                        '• Conceptual Unions — Marriage, Partnership, Alliance']
                        .map((s) => _bulletLine(s, inkColor)),
                    const SizedBox(height: 12),
                    _highlightBox(
                      'Every entity and union is assigned a unique AIR classification node, enabling precise, conflict-free mapping across all-space.',
                      Colors.tealAccent,
                      context,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildPage(
                  pageColor: pageColor,
                  inkColor: inkColor,
                  context: context,
                  pageNumber: '03',
                  title: 'Identity System — Get-As-Identified',
                  icon: Icons.fingerprint,
                  accentColor: Colors.cyanAccent,
                  content: [
                    _para(
                      'The Identity tab is where the AIR App locates you within the all-space map. Through a guided philosophical questionnaire, your cognitive and existential coordinates are determined.',
                      inkColor,
                    ),
                    const SizedBox(height: 12),
                    _sectionHeader('HOW IT WORKS', Colors.cyanAccent, inkColor),
                    const SizedBox(height: 8),
                    ...['1. You are presented with a sequence of reflective questions (Phases).',
                        '2. Each answer steers the system towards your unique identity node.',
                        '3. When complete, your identity is mapped and logged by the AIR Organisation.',
                        '4. You can "Recalibrate" at any time as your perspective evolves.']
                        .map((s) => _bulletLine(s, inkColor)),
                    const SizedBox(height: 16),
                    _sectionHeader('WHY IT MATTERS', Colors.cyanAccent, inkColor),
                    const SizedBox(height: 8),
                    _para(
                      'Your Identity node is your anchor in all-space. It determines personalised learning pathways, connects you to relevant entities and unions, and enables the Wisdom Mode to provide targeted guidance from your designated Expert.',
                      inkColor,
                    ),
                    const SizedBox(height: 12),
                    _highlightBox(
                      '"Your answers point to a highly organised systemic node. You are now mapped in all-space."',
                      Colors.cyanAccent,
                      context,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildPage(
                  pageColor: pageColor,
                  inkColor: inkColor,
                  context: context,
                  pageNumber: '04',
                  title: "Learn & Fun — Alifiyas's Mode",
                  icon: Icons.school_outlined,
                  accentColor: Colors.amberAccent,
                  content: [
                    _para(
                      'The Learn & Fun module is designed for younger learners, students, and curious minds at every stage. It presents knowledge categories in a visually rich, approachable grid format.',
                      inkColor,
                    ),
                    const SizedBox(height: 12),
                    _sectionHeader('SUBJECT CATEGORIES', Colors.amberAccent, inkColor),
                    const SizedBox(height: 8),
                    ...['🔬 Science — Physics, Chemistry, Biology, Astronomy',
                        '🎨 Art & Creativity — Visual arts, Music, Storytelling',
                        '👁  Vision & Perception — How we see and process reality',
                        '🔢 Mathematics — Numbers, Patterns, Logic, Geometry']
                        .map((s) => _bulletLine(s, inkColor)),
                    const SizedBox(height: 16),
                    _sectionHeader('EXPERIENCE DESIGN', Colors.amberAccent, inkColor),
                    const SizedBox(height: 8),
                    _para(
                      'Each category is presented as a vibrant card with a colour-coded border and icon. Tapping a card opens a rich document view (Category Docs) with structured, expert-written educational content sourced from AIR\'s JSON-driven content engine.',
                      inkColor,
                    ),
                    const SizedBox(height: 12),
                    _highlightBox(
                      'Knowledge is not just information — it is a living, breathing map of all-space that grows with every learner who explores it.',
                      Colors.amberAccent,
                      context,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildPage(
                  pageColor: pageColor,
                  inkColor: inkColor,
                  context: context,
                  pageNumber: '05',
                  title: 'Wisdom Mode — Mazeasta\'s Domain',
                  icon: Icons.book_outlined,
                  accentColor: Colors.pinkAccent,
                  content: [
                    _highlightBox(
                      '⚠  EXPERT SUPERVISION REQUIRED — Wisdom Mode is an advanced philosophical framework. It should only be explored under guidance from a designated Expert who recommended AIR.',
                      Colors.redAccent,
                      context,
                    ),
                    const SizedBox(height: 16),
                    _para(
                      'Wisdom Mode transcends ordinary learning. It operates in the Mazeasta domain — a space of advanced philosophical reflection, governed under the Rule framework of the AIR Organisation.',
                      inkColor,
                    ),
                    const SizedBox(height: 12),
                    _sectionHeader('THE FOUR PILLARS', Colors.pinkAccent, inkColor),
                    const SizedBox(height: 8),
                    ...['🌸 Illusions — Imaginations suggested by an Expert that you do not yet believe to be real.',
                        '✨ Imagination — Scenarios or entities constructed in the cognitive network without physical stimuli.',
                        '✅ Real — All validated, mathematically verified entities and unions in the AIR atlas.',
                        '🔷 Virtual — Properties that simulate reality but are fundamentally code configurations — not physically present.']
                        .map((s) => _bulletLine(s, inkColor)),
                    const SizedBox(height: 16),
                    _sectionHeader('ADDITIONAL FEATURES', Colors.pinkAccent, inkColor),
                    const SizedBox(height: 8),
                    ...['• Task & Feed — Expert-assigned tasks for the offspring to verify.',
                        '• Achievements — Milestones reached in the philosophical journey.',
                        '• Things Considered — A curated list of reflections and pending explorations.']
                        .map((s) => _bulletLine(s, inkColor)),
                  ],
                ),
                const SizedBox(height: 20),
                _buildPage(
                  pageColor: pageColor,
                  inkColor: inkColor,
                  context: context,
                  pageNumber: '06',
                  title: 'Ask Any Thing — The Wisdom Engine',
                  icon: Icons.question_answer_outlined,
                  accentColor: Colors.lightBlueAccent,
                  content: [
                    _para(
                      'Ask Any Thing is the query and discussion engine of AIR. It allows users to submit questions, receive expert-aligned answers, and track the entire conversation lifecycle.',
                      inkColor,
                    ),
                    const SizedBox(height: 12),
                    _sectionHeader('FEATURES', Colors.lightBlueAccent, inkColor),
                    const SizedBox(height: 8),
                    ...['📝 Submit Query — Fill in Subject + Description and raise a question to the Wisdom Engine.',
                        '📁 Attach Files — Link supporting screenshots or documents to your query.',
                        '🔍 Search & Filter — Find past queries by keyword or date range (All Time / Past 7 Days / Past 30 Days).',
                        '📊 Status Tracking — Each query shows Pending or Answered status.',
                        '🕒 Date-sorted Feed — Queries are always shown newest first.']
                        .map((s) => _bulletLine(s, inkColor)),
                    const SizedBox(height: 16),
                    _highlightBox(
                      'Every question you raise becomes a permanent node in the AIR knowledge network — contributing to the collective wisdom of all-space.',
                      Colors.lightBlueAccent,
                      context,
                    ),
                    const SizedBox(height: 12),
                    _para(
                      'Ask Any Thing is available from both the EXPLORE-Alifiyas section (learning queries) and the RULE-Mazeasta section (philosophical/expert queries) of the drawer.',
                      inkColor,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildPage(
                  pageColor: pageColor,
                  inkColor: inkColor,
                  context: context,
                  pageNumber: '07',
                  title: 'Drawer Menu — Full Navigation Map',
                  icon: Icons.menu_book_outlined,
                  accentColor: Colors.greenAccent,
                  content: [
                    _para(
                      'The AIR App drawer is the central navigation hub, organised into seven thematic sections:',
                      inkColor,
                    ),
                    const SizedBox(height: 12),
                    ...[
                      ('EXPLORE - ALIFIYAS', ['Learn And Fun', 'Ask Any Thing'], Colors.amberAccent),
                      ('RULE - MAZEASTA', ['Wisdom', 'Ask Any Thing'], Colors.pinkAccent),
                      ('BE-YOU & EARN LIVING', ['Share Experience', 'Record Your Post', 'Identities Cum Earnings'], Colors.lightGreenAccent),
                      ("USE AIR'S SPACE & RESOURCES", ['Knowledge Center', 'Products & Services', 'Query & Discussion', 'Sign In / Sign Up', 'Utilities as Guest'], Colors.cyanAccent),
                      ('YOUR PROFILE SPECIFICS', ['Events', 'Managements', 'Maintenance', 'Connect & Collaborate', 'Notices', 'Tracks & Traces', 'Your Business'], Colors.orangeAccent),
                      ("AIR'S ASPECTS", ["Let's resume your tour", 'Be the part of AIR', 'Contribute to AIR', 'Timeline of AIR', 'New in AIR', "AIR's Vision", "AIR's Mission", "AIR's Show Case", "Let's Windup"], Colors.purpleAccent),
                      ('SYSTEM CORE', ['App Setting', 'About AIR-APP', 'About AIR Organization'], Colors.redAccent),
                    ].map((group) => _drawerSection(group.$1, group.$2, group.$3, inkColor)),
                  ],
                ),
                const SizedBox(height: 20),
                _buildPage(
                  pageColor: pageColor,
                  inkColor: inkColor,
                  context: context,
                  pageNumber: '08',
                  title: "AIR's Vision, Mission & Values",
                  icon: Icons.visibility_outlined,
                  accentColor: Colors.purpleAccent,
                  content: [
                    _sectionHeader("VISION", Colors.purpleAccent, inkColor),
                    const SizedBox(height: 8),
                    _highlightBox(
                      'A world in which every entity and union in all-space is known, mapped, and held completely transparent — leaving no node uncharted, no relationship untracked, no accountability gap unclosed.',
                      Colors.purpleAccent,
                      context,
                    ),
                    const SizedBox(height: 16),
                    _sectionHeader("MISSION", Colors.tealAccent, inkColor),
                    const SizedBox(height: 8),
                    _para(
                      'To build and maintain the definitive, real-time atlas of all existence — empowering individuals to locate themselves within the cosmic order, learn from it, contribute to it, and be rewarded for their transparency and service.',
                      inkColor,
                    ),
                    const SizedBox(height: 16),
                    _sectionHeader("CORE VALUES", Colors.amberAccent, inkColor),
                    const SizedBox(height: 8),
                    ...['⚖  Absolute Transparency — No hidden nodes, no concealed unions.',
                        '🔬 Verified Knowledge — Every claim is rated, validated, and attributed.',
                        '🤝 Identity Respect — Each being\'s node is treated with dignity and precision.',
                        '♻  Continuous Evolution — The atlas grows as all-space grows.',
                        '🌐 Universal Inclusion — From atoms to galaxies, no entity is excluded.']
                        .map((s) => _bulletLine(s, inkColor)),
                  ],
                ),
                const SizedBox(height: 20),
                _buildPage(
                  pageColor: pageColor,
                  inkColor: inkColor,
                  context: context,
                  pageNumber: '09',
                  title: 'AIR Organisation & Roadmap',
                  icon: Icons.timeline_outlined,
                  accentColor: Colors.orangeAccent,
                  content: [
                    _sectionHeader("THE AIR ORGANISATION", Colors.orangeAccent, inkColor),
                    const SizedBox(height: 8),
                    _para(
                      'The AIR Organisation (governed under the Alifiyas-Mazeasta dual framework) is the official steward of the all-space atlas. It operates two governing councils:',
                      inkColor,
                    ),
                    const SizedBox(height: 8),
                    ...['• Alifiyas Council — Oversees the EXPLORE domain: learning, fun, identity, and public interactions.',
                        '• Mazeasta Council — Governs the RULE domain: wisdom, expert supervision, philosophical frameworks, and earned privileges.']
                        .map((s) => _bulletLine(s, inkColor)),
                    const SizedBox(height: 16),
                    _sectionHeader("4-PHASE ROADMAP", Colors.orangeAccent, inkColor),
                    const SizedBox(height: 8),
                    _roadmapItem('Phase 1 — MAP', 'Build the complete entity and union database. Categorise all nodes in all-space.', Colors.tealAccent, inkColor),
                    _roadmapItem('Phase 2 — IDENTIFY', 'Deploy the Identity system globally. Every individual locates their node.', Colors.purpleAccent, inkColor),
                    _roadmapItem('Phase 3 — EARN', 'Activate the Be-You & Earn Living economy. Users are rewarded for sharing, posting, and contributing.', Colors.amberAccent, inkColor),
                    _roadmapItem('Phase 4 — GOVERN', 'Full AIR Organisation governance. Products, services, and knowledge economy operating at full scale.', Colors.pinkAccent, inkColor),
                  ],
                ),
                const SizedBox(height: 20),
                _buildBackCover(pageColor, inkColor, context),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Cover Page ───────────────────────────────────────────────────────────

  Widget _buildCoverPage(Color pageColor, Color inkColor, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: pageColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Purple gradient header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2C0B5E), Color(0xFF4A1E8F), Color(0xFF1A3A5C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.purpleAccent, width: 2),
                    color: Colors.white.withValues(alpha: 0.05),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent.withValues(alpha: 0.4),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.air, color: Colors.white, size: 64),
                ),
                const SizedBox(height: 24),
                const Text(
                  'A I R',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 18,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'All-Space Intelligence & Reasoning',
                  style: TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Container(
                  width: 80,
                  height: 2,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.purpleAccent, Colors.transparent],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  "AIR's Vision",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A Complete Guide to the All-Space Knowledge Ecosystem',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Cover footer
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _coverBadge('Entities', Icons.hub),
                    const SizedBox(width: 16),
                    _coverBadge('Unions', Icons.account_tree),
                    const SizedBox(width: 16),
                    _coverBadge('Identity', Icons.fingerprint),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _coverBadge('Learn & Fun', Icons.school),
                    const SizedBox(width: 16),
                    _coverBadge('Wisdom', Icons.book),
                    const SizedBox(width: 16),
                    _coverBadge('Ask AIR', Icons.question_answer),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Alifiyas-Mazeasta Organisation',
                  style: TextStyle(
                    color: inkColor.withValues(alpha: 0.4),
                    fontSize: 11,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '"Mapping all-space. Ensuring absolute transparency."',
                  style: TextStyle(
                    color: inkColor.withValues(alpha: 0.5),
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _coverBadge(String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.purpleAccent, size: 20),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(fontSize: 10, color: Colors.grey, letterSpacing: 0.5)),
      ],
    );
  }

  // ─── Generic Document Page ────────────────────────────────────────────────

  Widget _buildPage({
    required Color pageColor,
    required Color inkColor,
    required BuildContext context,
    required String pageNumber,
    required String title,
    required IconData icon,
    required Color accentColor,
    required List<Widget> content,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: pageColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page header band
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: accentColor.withValues(alpha: 0.3), width: 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: accentColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: inkColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Text(
                  pageNumber,
                  style: TextStyle(
                    color: inkColor.withValues(alpha: 0.18),
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
          ),
          // Page body
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content,
            ),
          ),
          // Page footer rule
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Divider(color: inkColor.withValues(alpha: 0.08), height: 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'AIR — All-Space Intelligence & Reasoning',
                  style: TextStyle(
                    color: inkColor.withValues(alpha: 0.3),
                    fontSize: 9,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  pageNumber,
                  style: TextStyle(
                    color: inkColor.withValues(alpha: 0.3),
                    fontSize: 9,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Back Cover ───────────────────────────────────────────────────────────

  Widget _buildBackCover(Color pageColor, Color inkColor, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: pageColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 32),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D0B1A), Color(0xFF1A0A30), Color(0xFF0B1E2E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            const Icon(Icons.visibility_outlined, color: Colors.purpleAccent, size: 48),
            const SizedBox(height: 24),
            const Text(
              'Know your place in all-space.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              '"Mapping all-space.\nEnsuring absolute transparency."',
              style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 14,
                fontStyle: FontStyle.italic,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Container(
              width: 60,
              height: 1,
              color: Colors.purpleAccent.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 24),
            const Text(
              'A I R  O R G A N I S A T I O N',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Alifiyas-Mazeasta Framework',
              style: TextStyle(
                color: Colors.white24,
                fontSize: 10,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Content Helpers ──────────────────────────────────────────────────────

  Widget _para(String text, Color inkColor) {
    return Text(
      text,
      style: TextStyle(
        color: inkColor.withValues(alpha: 0.8),
        fontSize: 13.5,
        height: 1.7,
      ),
    );
  }

  Widget _bulletLine(String text, Color inkColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          color: inkColor.withValues(alpha: 0.75),
          fontSize: 13,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _sectionHeader(String text, Color accent, Color inkColor) {
    return Row(
      children: [
        Container(width: 3, height: 16, color: accent,
            margin: const EdgeInsets.only(right: 10)),
        Text(
          text,
          style: TextStyle(
            color: inkColor,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.5,
          ),
        ),
      ],
    );
  }

  Widget _highlightBox(String text, Color accent, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF1A1A2E).withValues(alpha: 0.85),
          fontSize: 13,
          fontStyle: FontStyle.italic,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _drawerSection(String header, List<String> items, Color accent, Color inkColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(header, accent, inkColor),
          const SizedBox(height: 6),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(left: 13, bottom: 3),
              child: Text(
                '→  $item',
                style: TextStyle(
                  color: inkColor.withValues(alpha: 0.7),
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roadmapItem(String phase, String description, Color accent, Color inkColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 4, right: 14),
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: accent.withValues(alpha: 0.5), blurRadius: 6)]),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(phase,
                    style: TextStyle(
                        color: inkColor, fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 3),
                Text(description,
                    style: TextStyle(
                        color: inkColor.withValues(alpha: 0.65), fontSize: 12.5, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

