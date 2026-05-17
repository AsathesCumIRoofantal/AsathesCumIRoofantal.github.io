import 'package:flutter/material.dart';

/// DESIGN: Full-bleed Alternating Sections — cinematic alternating dark/light bands
class DiscoveryBestView extends StatelessWidget {
  const DiscoveryBestView({super.key});

  static const _teal = Color(0xFF0D9488);
  static const _cyan = Color(0xFF06B6D4);
  static const _lime = Color(0xFF84CC16);
  static const _violet = Color(0xFF7C3AED);
  static const _amber = Color(0xFFF59E0B);
  static const _rose = Color(0xFFF43F5E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: const Color(0xFF001A1A),
            foregroundColor: Colors.white,
            title: const Text('DISCOVERY', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 14, color: Colors.white)),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF001A1A), Color(0xFF003333), Color(0xFF001A1A)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: Stack(children: [
                  Positioned(right: -30, bottom: -30, child: Icon(Icons.explore_rounded, size: 220, color: Colors.white.withOpacity(0.04))),
                  Padding(padding: const EdgeInsets.fromLTRB(24, 80, 24, 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text('EXPLORE • DISCOVER • GROW', style: TextStyle(color: _teal, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 3)),
                    const SizedBox(height: 10),
                    const Text('Discovery is the engine of growth — the practice of intentionally seeking what you do not yet know.', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900, height: 1.3)),
                  ])),
                ]),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // BAND 1 — DARK
              _Band(isDark: true, color: _teal, icon: Icons.explore_rounded, title: 'Curiosity Cultivation', position: '01',
                  body: 'Discovery begins before the search — it begins with the quality of your curiosity. Cultivated curiosity is systematic: it follows threads, asks second-level questions, and records what it finds even when the find seems irrelevant. The undirected browser stumbles on things; the cultivated explorer finds them.\n\nAIR\'s curiosity log prompts you to record not just what you found but what question led you there — building a map of your intellectual trajectory over time.'),
              // BAND 2 — LIGHT
              _Band(isDark: false, color: _cyan, icon: Icons.search_rounded, title: 'Systematic Search', position: '02',
                  body: 'Random discovery is inefficient. Systematic discovery uses structured search protocols — domain scanning, expert interviews, and boundary pushing — to maximise the probability of finding high-value unknown information in a minimum of time.\n\nThe discovery protocol in AIR assigns search domains by priority, tracks what has been searched, and flags areas where your knowledge is suspiciously thin — because the absence of found knowledge is itself important data.'),
              // BAND 3 — DARK
              _Band(isDark: true, color: _lime, icon: Icons.hub_rounded, title: 'Connection Finding', position: '03',
                  body: 'The highest-value discoveries are connections — insights that reveal a relationship between two domains that seemed unrelated. Connection finding is a learnable skill: it requires broad reading, an active note-taking system that creates bridges across topics, and regular synthesis sessions that force cross-domain comparison.\n\nAIR\'s connection engine automatically surfaces potential links between your notes across different knowledge domains.'),
              // BAND 4 — LIGHT
              _Band(isDark: false, color: _violet, icon: Icons.school_rounded, title: 'Discovery Journaling', position: '04',
                  body: 'What is discovered but not recorded is effectively not discovered — it returns to the pool of the unknown. The discovery journal is the container that converts ephemeral insight into durable knowledge, and durable knowledge into competitive advantage.\n\nEntries are structured with: the discovery itself, the context that enabled it, the question it answers, and the new questions it opens — ensuring the journal compounds rather than merely accumulates.'),
              // BAND 5 — DARK
              _Band(isDark: true, color: _amber, icon: Icons.people_rounded, title: 'Social Discovery', position: '05',
                  body: 'Other people are discovery accelerators. Every expert interview, peer conversation, and community exchange surfaces knowledge that would take years to find independently. AIR\'s network intelligence module helps you identify which people in your network are the most productive discovery gateways for your current priority domains.\n\nDocumenting what each conversation revealed — not just what was discussed — converts social time into compounding intellectual capital.'),
              // BAND 6 — LIGHT  
              _Band(isDark: false, color: _rose, icon: Icons.flag_rounded, title: 'Discovery Targets', position: '06',
                  body: 'Undirected discovery is a pleasant hobby; directed discovery is a strategic weapon. Set explicit discovery targets — domains, questions, or knowledge gaps you intend to close within a specific period — and track your progress against them.\n\nDiscovery targets are reviewed quarterly and updated as priorities shift. The log reveals how much of your knowledge acquisition is strategic versus serendipitous — and whether the balance serves your actual goals.'),
              // QUOTE
              Container(
                padding: const EdgeInsets.all(28),
                color: const Color(0xFF001A1A),
                child: Column(children: [
                  Icon(Icons.explore_rounded, color: _teal, size: 32),
                  const SizedBox(height: 14),
                  const Text('"The universe is under no obligation to make sense to you." — Neil deGrasse Tyson', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text('— AIR Discovery Module', style: TextStyle(color: _teal, fontSize: 11, fontWeight: FontWeight.w600)),
                ]),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Band extends StatelessWidget {
  final bool isDark; final Color color; final IconData icon; final String title, body, position;
  const _Band({required this.isDark, required this.color, required this.icon, required this.title, required this.body, required this.position});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(28),
    color: isDark ? const Color(0xFF080808) : const Color(0xFFF8F8F8),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(position, style: TextStyle(color: color.withOpacity(0.4), fontSize: 40, fontWeight: FontWeight.w900, height: 1.0)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: isDark ? Colors.white : const Color(0xFF1A1A1A), fontSize: 18, fontWeight: FontWeight.w900)),
        ])),
      ]),
      const SizedBox(height: 14),
      Text(body, style: TextStyle(color: isDark ? Colors.white60 : Colors.black54, fontSize: 13, height: 1.65)),
    ]),
  );
}
