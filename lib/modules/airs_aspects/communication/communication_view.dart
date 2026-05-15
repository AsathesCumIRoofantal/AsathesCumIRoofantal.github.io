import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'communication_controller.dart';

class CommunicationView extends GetView<CommunicationController> {
  const CommunicationView({Key? key}) : super(key: key);

  static const _sky = Color(0xFF0EA5E9);
  static const _blue = Color(0xFF3B82F6);
  static const _indigo = Color(0xFF6366F1);
  static const _cyan = Color(0xFF06B6D4);
  static const _teal = Color(0xFF0D9488);
  static const _amber = Color(0xFFF59E0B);
  static const _rose = Color(0xFFE11D48);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF020812) : const Color(0xFFF0F8FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text(
          'COMMUNICATION',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.forum_rounded, color: _sky, size: 22),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel(
            'ACTIVE CHANNELS',
            Icons.hub_rounded,
            _sky,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildChannelGrid(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'COMMUNICATION HEALTH',
            Icons.health_and_safety_rounded,
            _blue,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildHealthRow(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'CAPABILITIES & SETTINGS',
            Icons.settings_rounded,
            _indigo,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildCapabilityCard(
            context,
            isDark,
            Icons.tune_rounded,
            _blue,
            'Tone & Cadence Settings',
            'Configure how often AIR sends you updates, digests, and nudges — and set the preferred tone for outbound messages you draft through the platform. '
                'Intentional cadence means people read what you send; too much noise trains them to ignore everything. '
                'Cadence settings respect your focus hours — messages are batched and delivered at times you have designated for communication.',
          ),
          const SizedBox(height: 10),
          _buildCapabilityCard(
            context,
            isDark,
            Icons.description_rounded,
            _indigo,
            'Message Templates',
            'Access a library of pre-approved message templates for common scenarios — status updates, escalation notices, meeting requests, and acknowledgements. '
                'Templates save time and ensure consistency, so your communication always reflects the standards AIR expects. '
                'Custom templates can be created, named, and shared with your team — making shared language a team asset, not just a personal shortcut.',
          ),
          const SizedBox(height: 10),
          _buildCapabilityCard(
            context,
            isDark,
            Icons.campaign_rounded,
            _cyan,
            'Broadcast & Announcements',
            'Compose and send wide-reach announcements to your network, team, or the broader AIR community — with delivery confirmation and read-receipt tracking. '
                'Broadcasts are logged and archived so recipients can always find the original message, even weeks later. '
                'Scheduled broadcasts let you time announcements to land at peak engagement windows without requiring you to be present.',
          ),
          const SizedBox(height: 10),
          _buildCapabilityCard(
            context,
            isDark,
            Icons.history_rounded,
            _teal,
            'Communication Log',
            'Review a timestamped history of all messages sent and received through AIR — searchable by sender, channel, date, or keyword. '
                'The log is your accountability trail: it shows what was communicated, when, and to whom, removing ambiguity from any dispute. '
                'Logs are retained for a minimum of 12 months and can be exported in structured formats for compliance or handover purposes.',
          ),
          const SizedBox(height: 10),
          _buildCapabilityCard(
            context,
            isDark,
            Icons.do_not_disturb_on_rounded,
            _rose,
            'Noise Filter & Mute Rules',
            'Set rules to mute low-priority channels during focus hours, filter out automated notifications, and surface only the messages that require your attention. '
                'Reducing noise is not about missing things — it is about protecting the cognitive space needed to respond well to what matters. '
                'Emergency override contacts bypass all noise filters, ensuring that genuinely urgent communications always reach you regardless of focus mode.',
          ),
          const SizedBox(height: 10),
          _buildCapabilityCard(
            context,
            isDark,
            Icons.mark_chat_unread_rounded,
            _amber,
            'Response Commitments',
            'Track messages that require a reply and set personal response-time commitments so nothing falls through the cracks. '
                'AIR reminds you of pending responses and flags overdue replies, keeping your communication reputation intact. '
                'Response commitments can be shared with senders so they know when to expect your reply and do not need to chase you for status.',
          ),
          const SizedBox(height: 20),
          _buildCommunicationPrinciples(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_sky.withOpacity(0.14), _indigo.withOpacity(0.08)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _sky.withOpacity(0.28)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _sky.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.forum_rounded, color: _sky, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'COMMUNICATION CENTRE',
                      style: TextStyle(
                        fontSize: 10,
                        color: _sky,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Keep every exchange intentional — choose the right channel, set the right tone, and maintain a cadence that informs without overwhelming.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: onSurface.withOpacity(0.72),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _buildMiniStat('7', 'Channels', _sky),
              const SizedBox(width: 16),
              _buildMiniStat('98%', 'Response Rate', _teal),
              const SizedBox(width: 16),
              _buildMiniStat('1.2h', 'Avg Response', _blue),
              const SizedBox(width: 16),
              _buildMiniStat('3', 'Pending', _amber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String value, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8,
              color: color.withOpacity(0.75),
              letterSpacing: 0.3,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(
    String title,
    IconData icon,
    Color color,
    Color onSurface,
  ) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildChannelGrid(BuildContext context, bool isDark, Color onSurface) {
    final channels = [
      (Icons.chat_rounded, 'Direct\nMessages', '12 active', _sky),
      (Icons.groups_rounded, 'Group\nThreads', '4 groups', _blue),
      (Icons.campaign_rounded, 'Broadcasts', '2 drafts', _amber),
      (Icons.announcement_rounded, 'Announcements', 'AIR official', _indigo),
      (Icons.email_rounded, 'Notifications', '8 unread', _cyan),
      (Icons.support_agent_rounded, 'AIR Support', 'Online now', _teal),
    ];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.0,
      children: channels
          .map(
            (c) => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: c.$4.withOpacity(0.07),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: c.$4.withOpacity(0.20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(c.$1, color: c.$4, size: 22),
                  const SizedBox(height: 6),
                  Text(
                    c.$2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: onSurface,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    c.$3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 8,
                      color: c.$4,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildHealthRow(BuildContext context, bool isDark, Color onSurface) {
    final metrics = [
      ('Response Rate', '98%', 0.98, _teal),
      ('Clarity Score', '87%', 0.87, _blue),
      ('Noise Level', '12%', 0.12, _rose),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.04)
            : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _blue.withOpacity(0.15)),
      ),
      child: Column(
        children: metrics
            .map(
              (m) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          m.$1,
                          style: TextStyle(fontSize: 12, color: onSurface),
                        ),
                        Text(
                          m.$2,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: m.$4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Stack(
                      children: [
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: m.$3,
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                              color: m.$4,
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: [
                                BoxShadow(
                                  color: m.$4.withOpacity(0.35),
                                  blurRadius: 4,
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
            )
            .toList(),
      ),
    );
  }

  Widget _buildCapabilityCard(
    BuildContext context,
    bool isDark,
    IconData icon,
    Color color,
    String title,
    String body,
  ) {
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.72),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunicationPrinciples(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    final principles = [
      (
        'Right Channel',
        'Match the message type to the channel — urgent matters belong in direct messages, not broadcast feeds.',
        Icons.swap_horiz_rounded,
        _sky,
      ),
      (
        'Right Time',
        'Send messages when the recipient can act on them, not when it is convenient for you to write them.',
        Icons.schedule_rounded,
        _blue,
      ),
      (
        'Right Tone',
        'Calibrate formality, directness, and warmth to the relationship and context, not personal habit.',
        Icons.record_voice_over_rounded,
        _indigo,
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_sky.withOpacity(0.08), _indigo.withOpacity(0.06)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _sky.withOpacity(0.20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_rounded, color: _amber, size: 14),
              const SizedBox(width: 6),
              const Text(
                '3 PRINCIPLES OF EFFECTIVE COMMUNICATION',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: _amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...principles.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(p.$3, color: p.$4, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.$1,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: onSurface,
                          ),
                        ),
                        Text(
                          p.$2,
                          style: TextStyle(
                            fontSize: 11,
                            color: onSurface.withOpacity(0.65),
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
