import 'package:flutter/material.dart';

class AboutAppView extends StatelessWidget {
  final bool isEmbedded;
  const AboutAppView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        'Core Vision',
        'Building adaptive experiences with meaningful interaction layers.',
      ),
      (
        'Interactive Systems',
        'Unique UI sections, live information blocks and expandable cards.',
      ),
      (
        'Experience Design',
        'Focused on readability, modern gradients and futuristic aesthetics.',
      ),
      (
        'AIR Expansion',
        'Structured content architecture for long-term scalability.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF07111F),
      body: ListView(
        shrinkWrap: isEmbedded,
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
        children: [
          Stack(
            children: [
              Positioned(
                right: -20,
                top: 40,
                child: Icon(Icons.hub, size: 180, color: Colors.white10),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 90, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'ABOUT App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Digital command center',
                      style: TextStyle(
                        color: Color(0xFFB8D8FF),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF143D59), Color(0xFF1D4E89)],
                  ),
                ),
                child: Row(
                  children: const [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.bolt, color: Colors.white),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'AIR dynamic modules are designed to feel immersive, futuristic and information-rich.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ...items.map(
                (item) => Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F1C2E),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.stars, color: Colors.white),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.$1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.$2,
                              style: const TextStyle(
                                color: Color(0xFFC9D6E3),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color(0xFF112240),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'SYSTEM MESSAGE',
                      style: TextStyle(
                        color: Color(0xFF64FFDA),
                        letterSpacing: 3,
                        fontWeight: FontWeight.w900,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'This page now includes enhanced storytelling sections, futuristic UI blocks, detailed informational content and modular layouts tailored uniquely for this screen.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.7,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}
