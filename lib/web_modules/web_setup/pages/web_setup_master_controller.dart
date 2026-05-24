import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebSetupMasterController extends GetxController {
  // Data Map for all 60+ Setup Pages
  final Map<String, Map<String, dynamic>> setupData = {
    'research-dev': {
      'title': 'Research & Development',
      'icon': Icons.biotech,
      'color': const Color(0xFF6366F1),
      'features': [
        'Quantum-Sliver Simulation',
        'AI-Driven Hypothesis Mapping',
        'Symmetric Data-Lapping',
      ],
      'items': [
        {'h': 'Phase 1', 'd': 'Neural-Interface Prototype'},
        {'h': 'Phase 2', 'd': 'Sliver-Mesh Integration'},
      ],
    },
    'travel': {
      'title': 'Travel & Transport',
      'icon': Icons.flight_takeoff,
      'color': const Color(0xFF818CF8),
      'features': [
        'Holographic Route-Mapping',
        'Sliver-Transit Sync',
        'Temporal Latency Prediction',
      ],
      'items': [
        {'h': 'Inter-Node', 'd': 'Quantum-Gate Transit'},
        {'h': 'Intra-Node', 'd': 'Neural-Sleeve Commute'},
      ],
    },
    'loop-hole': {
      'title': 'Loop Hole',
      'icon': Icons.loop,
      'color': const Color(0xFFC084FC),
      'features': [
        'Logic-Gap Detection',
        'Recursive Loop Analysis',
        'Symmetry-Bypass Protocols',
      ],
      'items': [
        {'h': 'Critical Gap', 'd': 'Identity-Sleeve Overlap'},
        {'h': 'Optimized', 'd': 'Redundant State Removal'},
      ],
    },
    'advantage': {
      'title': 'Advantage',
      'icon': Icons.trending_up,
      'color': const Color(0xFF4F46E5),
      'features': [
        'Competitive Edge-Sensing',
        'Strategic Resource Lapping',
        'Value-Symmetry Projection',
      ],
      'items': [
        {'h': 'Sliver-Speed', 'd': '30% faster rendering than base'},
        {'h': 'Cognitive Reach', 'd': 'Extended Neural-Cache'},
      ],
    },
    'challenge': {
      'title': 'Challenge',
      'icon': Icons.warning_amber,
      'color': const Color(0xFFF59E0B),
      'features': [
        'Friction-Point Mapping',
        'Sliver-Constraint Analysis',
        'Resilience-Stress Testing',
      ],
      'items': [
        {'h': 'Complexity', 'd': 'Neural-Sync Latency'},
        {'h': 'Scale', 'd': 'Million-Sliver Rendering'},
      ],
    },
    'solution': {
      'title': 'Solution',
      'icon': Icons.lightbulb,
      'color': const Color(0xFF10B981),
      'features': [
        'Symmetry-Resolution',
        'Auto-Sliver Optimization',
        'Zero-Lag Execution',
      ],
      'items': [
        {'h': 'Refinement', 'd': 'Sliver-Proxy Cache Implementation'},
        {'h': 'Cure', 'd': 'Identity-Sleeve Patch v2'},
      ],
    },
    'innovation': {
      'title': 'Innovation',
      'icon': Icons.auto_awesome,
      'color': const Color(0xFF6366F1),
      'features': [
        'Concept-to-Sliver Pipeline',
        'Recursive Idea-Sensing',
        'Symmetric Evolution',
      ],
      'items': [
        {'h': 'Alpha', 'd': 'Neural-Sleeve Projection'},
        {'h': 'Beta', 'd': 'Sliver-Mesh Intelligence'},
      ],
    },
    'discovery': {
      'title': 'Discovery',
      'icon': Icons.explore,
      'color': const Color(0xFF8B5CF6),
      'features': [
        'Unmapped Data-Mining',
        'Neural-Pattern Recognition',
        'Sliver-Horizon Scanning',
      ],
      'items': [
        {'h': 'Finding', 'd': 'Hidden Asset in Profile Node'},
        {'h': 'Breakthrough', 'd': 'Symmetry-Sleeve Link'},
      ],
    },
    'enhancement': {
      'title': 'Enhancement',
      'icon': Icons.upgrade,
      'color': const Color(0xFFC084FC),
      'features': [
        'State-Morphing Polishing',
        'Sliver-Symmetry Tuning',
        'High-Fidelity Upscaling',
      ],
      'items': [
        {'h': 'Visual', 'd': 'Impeller-Symmetry v3'},
        {'h': 'Logic', 'd': 'Sliver-Cache Optimization'},
      ],
    },
    'hope': {
      'title': 'Hope',
      'icon': Icons.wb_sunny,
      'color': const Color(0xFFFACC15),
      'features': [
        'Positive-Symmetry Projection',
        'Luminous-Aura UI',
        'Sliver-Ascension Mapping',
      ],
      'items': [
        {'h': 'Vision', 'd': 'A world of zero-lag connection'},
        {'h': 'Goal', 'd': 'Unified Cognitive Sovereignty'},
      ],
    },
    'success-failure': {
      'title': 'Success & Failure',
      'icon': Icons.analytics,
      'color': const Color(0xFFEF4444),
      'features': [
        'Sliver-Symmetry Audit',
        'Binary Outcome Analysis',
        'Resilience-Gain Metrics',
      ],
      'items': [
        {'h': 'Win', 'd': 'Identity-Sleeve Optimization'},
        {'h': 'Loss', 'd': 'Cache-Fragment Leak'},
      ],
    },
    'religion-prayer': {
      'title': 'Religion & Prayer',
      'icon': Icons.auto_awesome_mosaic,
      'color': const Color(0xFFD4AF37),
      'features': [
        'Zen-Sliver Layouts',
        'Temporal-Symmetry Rhythms',
        'Luminous-Prayer Shaders',
      ],
      'items': [
        {'h': 'Core', 'd': 'The Universal Peace Rule'},
        {'h': 'Practice', 'd': 'Symmetry-Meditation'},
      ],
    },
    'feedback': {
      'title': 'Feedback',
      'icon': Icons.feedback,
      'color': const Color(0xFF6366F1),
      'features': [
        'Real-time Sentiment-Lapping',
        'Sliver-Feedback Loops',
        'Symmetry-Correction AI',
      ],
      'items': [
        {'h': 'User-A', 'd': 'Love the Sliver-Speed!'},
        {'h': 'User-B', 'd': 'Needs more Neural-Sync lapping.'},
      ],
    },
    'marketing': {
      'title': 'Marketing & Promotion',
      'icon': Icons.campaign,
      'color': const Color(0xFFEC4899),
      'features': [
        'Holographic-Reach Metrics',
        'Sliver-Ad Placement',
        'Persona-Targeting AI',
      ],
      'items': [
        {'h': 'Campaign A', 'd': 'The 2026 Vision Launch'},
        {'h': 'Metric', 'd': '1.2M Node Impressions'},
      ],
    },
    'serve': {
      'title': 'Serve',
      'icon': Icons.volunteer_activism,
      'color': const Color(0xFF10B981),
      'features': [
        'Altruism-Symmetry Mapping',
        'Sliver-Service Mesh',
        'Sovereign-Care Logic',
      ],
      'items': [
        {'h': 'Duty', 'd': 'Identity-Node Support'},
        {'h': 'Impact', 'd': '10k Peers Assisted'},
      ],
    },
    'relationships': {
      'title': 'Relationships',
      'icon': Icons.favorite,
      'color': const Color(0xFFF43F5E),
      'features': [
        'Neural-Bond Sensing',
        'Symmetry-Linkage Visualization',
        'Sliver-Empathy Mesh',
      ],
      'items': [
        {'h': 'Core', 'd': 'Family-Bond Symmetry'},
        {'h': 'Social', 'd': 'Collaborative-Peer Mesh'},
      ],
    },
    'obligations': {
      'title': 'Obligations',
      'icon': Icons.lock_clock,
      'color': const Color(0xFF6366F1),
      'features': [
        'Sliver-Duty Tracking',
        'Symmetry-Accountability',
        'Lapped-Time Constraints',
      ],
      'items': [
        {'h': 'Critical', 'd': 'Sovereign-Law Compliance'},
        {'h': 'Daily', 'd': 'Sliver-Cache Maintenance'},
      ],
    },
    'punctuality': {
      'title': 'Punctuality',
      'icon': Icons.timer,
      'color': const Color(0xFFD4AF37),
      'features': [
        'Sliver-Precision Sync',
        'Temporal-Symmetry Locks',
        'Zero-Lag Scheduling',
      ],
      'items': [
        {'h': 'Metric', 'd': '99.9% On-Time Delivery'},
        {'h': 'Goal', 'd': 'Nano-second Latency'},
      ],
    },
    'loyalty': {
      'title': 'Loyalty',
      'icon': Icons.verified_user,
      'color': const Color(0xFFC084FC),
      'features': [
        'Symmetry-Bond Analysis',
        'Long-term Node Fidelity',
        'Lapped-Trust Metrics',
      ],
      'items': [
        {'h': 'Rank', 'd': 'Loyalty Diamond Tier'},
        {'h': 'Bonus', 'd': 'Priority-Sliver Access'},
      ],
    },
    'appreciations': {
      'title': 'Appreciations & Thanks',
      'icon': Icons.celebration,
      'color': const Color(0xFFEC4899),
      'features': [
        'Luminous Gratitude-Slivers',
        'Symmetry-Praise Mesh',
        'Real-time Merit-Sensing',
      ],
      'items': [
        {'h': 'From', 'd': 'Sovereign-Alpha'},
        {'h': 'Note', 'd': 'For incredible lapping skills!'},
      ],
    },
    'empathy': {
      'title': 'Empathy & Sympathy',
      'icon': Icons.volunteer_activism,
      'color': const Color(0xFF10B981),
      'features': [
        'Neural-Symmetry Sensing',
        'Emotional-Load Lapping',
        'Sliver-Care Projection',
      ],
      'items': [
        {'h': 'Sensing', 'd': 'High-Empathy Sync'},
        {'h': 'Support', 'd': 'Collective Resilience'},
      ],
    },
    'forgiveness': {
      'title': 'Forgiveness',
      'icon': Icons.handshake,
      'color': const Color(0xFFC084FC),
      'features': [
        'State-Reset Logic',
        'Symmetry-Healing Protocols',
        'Lapped-Error Forgetting',
      ],
      'items': [
        {'h': 'Process', 'd': 'Conflict-Sliver Resolution'},
        {'h': 'Result', 'd': 'Symmetry Restored'},
      ],
    },

    'kindness': {
      'title': 'Kindness & Politeness',
      'icon': Icons.face_retouching_natural,
      'color': const Color(0xFFFACC15),
      'features': [
        'Sliver-Softening UI',
        'Politeness-Lapped Logic',
        'Symmetry Compassion Layer',
      ],
      'items': [
        {'h': 'Core', 'd': 'Respectful Interaction'},
        {'h': 'Aura', 'd': 'Positive Emotional Projection'},
      ],
    },

    'respect': {
      'title': 'Respect',
      'icon': Icons.workspace_premium,
      'color': const Color(0xFF6366F1),
      'features': [
        'Honor-Based Symmetry',
        'Mutual Sovereignty',
        'Ethical Neural Mapping',
      ],
      'items': [
        {'h': 'Core', 'd': 'Universal Human Respect'},
        {'h': 'Result', 'd': 'Stable Social Mesh'},
      ],
    },

    'discipline': {
      'title': 'Discipline',
      'icon': Icons.gavel,
      'color': const Color(0xFF4F46E5),
      'features': [
        'Structured Sliver Logic',
        'Habit-Sync Systems',
        'Consistency Optimization',
      ],
      'items': [
        {'h': 'Rule', 'd': 'Consistency Builds Power'},
        {'h': 'Impact', 'd': 'Long-Term Symmetry'},
      ],
    },

    'affection': {
      'title': 'Affection & Love',
      'icon': Icons.favorite_border,
      'color': const Color(0xFFF43F5E),
      'features': [
        'Emotional Harmony Mesh',
        'Compassion Rendering',
        'Bond Synchronization',
      ],
      'items': [
        {'h': 'Emotion', 'd': 'Unified Heart-State'},
        {'h': 'Result', 'd': 'Collective Strength'},
      ],
    },

    'family': {
      'title': 'Family',
      'icon': Icons.family_restroom,
      'color': const Color(0xFF10B981),
      'features': [
        'Family Support Systems',
        'Generational Stability',
        'Shared Symmetry',
      ],
      'items': [
        {'h': 'Bond', 'd': 'Trust & Care'},
        {'h': 'Future', 'd': 'Unified Growth'},
      ],
    },

    'friendship': {
      'title': 'Friendship',
      'icon': Icons.people_alt,
      'color': const Color(0xFF8B5CF6),
      'features': [
        'Peer Connection Mesh',
        'Collaborative Networks',
        'Social Symmetry',
      ],
      'items': [
        {'h': 'Value', 'd': 'Reliable Bonding'},
        {'h': 'Network', 'd': 'Trusted Alliance'},
      ],
    },

    'rivalry': {
      'title': 'Rivalry And War',
      'icon': Icons.security,
      'color': const Color(0xFFEF4444),
      'features': [
        'Conflict-State Detection',
        'Strategic Symmetry Mapping',
        'Risk Evaluation',
      ],
      'items': [
        {'h': 'Threat', 'd': 'System Fragmentation'},
        {'h': 'Goal', 'd': 'Peace Restoration'},
      ],
    },

    'competition': {
      'title': 'Competition',
      'icon': Icons.emoji_events,
      'color': const Color(0xFFF59E0B),
      'features': [
        'Performance Benchmarking',
        'Leader Tracking',
        'Adaptive Challenges',
      ],
      'items': [
        {'h': 'Top Rank', 'd': 'Sovereign Alpha'},
        {'h': 'Metric', 'd': '98% Symmetry Score'},
      ],
    },

    'technology': {
      'title': 'Technology',
      'icon': Icons.memory,
      'color': const Color(0xFF6366F1),
      'features': [
        'Quantum Processing',
        'Neural Hardware Sync',
        'AI-Augmented Slivers',
      ],
      'items': [
        {'h': 'Core', 'd': 'Symmetry Engine'},
        {'h': 'Upgrade', 'd': 'Impeller Fusion'},
      ],
    },

    'language': {
      'title': 'Language & Translation',
      'icon': Icons.translate,
      'color': const Color(0xFF10B981),
      'features': [
        'Realtime Translation',
        'Universal Communication',
        'Neural Parsing',
      ],
      'items': [
        {'h': 'Mode', 'd': 'Multi-Language Mesh'},
        {'h': 'Reach', 'd': 'Global Connectivity'},
      ],
    },

    'monitorship': {
      'title': 'Monitorship',
      'icon': Icons.monitor,
      'color': const Color(0xFF06B6D4),
      'features': [
        'Realtime State Tracking',
        'Observer Layer Mesh',
        'Neural Activity Monitoring',
      ],
      'items': [
        {'h': 'Layer', 'd': 'Continuous Oversight'},
        {'h': 'Result', 'd': 'Stability Assurance'},
      ],
    },

    'surveillance': {
      'title': 'Surveillance & Investigation',
      'icon': Icons.visibility,
      'color': const Color(0xFF8B5CF6),
      'features': [
        'Pattern Recognition',
        'Threat Intelligence',
        'Evidence Synchronization',
      ],
      'items': [
        {'h': 'Scan', 'd': 'Behavior Mapping'},
        {'h': 'Goal', 'd': 'Risk Prevention'},
      ],
    },

    'leadership': {
      'title': 'Leadership',
      'icon': Icons.psychology,
      'color': const Color(0xFFF59E0B),
      'features': [
        'Decision Symmetry',
        'Visionary Planning',
        'Collective Coordination',
      ],
      'items': [
        {'h': 'Leader', 'd': 'Sovereign Guide'},
        {'h': 'Mission', 'd': 'Unified Progress'},
      ],
    },

    'control': {
      'title': 'Control & Coordination',
      'icon': Icons.hub,
      'color': const Color(0xFF4F46E5),
      'features': [
        'State Coordination',
        'Distributed Control',
        'Sliver Synchronization',
      ],
      'items': [
        {'h': 'Engine', 'd': 'Central Logic Mesh'},
        {'h': 'Result', 'd': 'Balanced Execution'},
      ],
    },

    'the-present': {
      'title': 'The Present — The Only Way',
      'icon': Icons.access_time_filled,
      'color': const Color(0xFF10B981),
      'features': [
        'Present-Moment Awareness',
        'Temporal Stability',
        'Mind Synchronization',
      ],
      'items': [
        {'h': 'Focus', 'd': 'Current Reality'},
        {'h': 'Truth', 'd': 'Now Is Power'},
      ],
    },

    'trade': {
      'title': 'Trade Import-Export',
      'icon': Icons.currency_exchange,
      'color': const Color(0xFF06B6D4),
      'features': [
        'Global Exchange Networks',
        'Supply Synchronization',
        'Economic Mapping',
      ],
      'items': [
        {'h': 'Import', 'd': 'Resource Acquisition'},
        {'h': 'Export', 'd': 'Value Distribution'},
      ],
    },

    'ranking': {
      'title': 'Ranking Orders',
      'icon': Icons.leaderboard,
      'color': const Color(0xFFF59E0B),
      'features': [
        'Priority Sorting',
        'Hierarchy Mapping',
        'Merit Classification',
      ],
      'items': [
        {'h': 'Rank 1', 'd': 'Supreme Node'},
        {'h': 'Rank 2', 'd': 'Alpha Network'},
      ],
    },

    'statistics': {
      'title': 'Statistics',
      'icon': Icons.query_stats,
      'color': const Color(0xFF6366F1),
      'features': [
        'Data Visualization',
        'Predictive Metrics',
        'Realtime Analysis',
      ],
      'items': [
        {'h': 'Growth', 'd': '+340% Expansion'},
        {'h': 'Accuracy', 'd': '99.1% Precision'},
      ],
    },

    'peace': {
      'title': 'Peace and Prosperity',
      'icon': Icons.public,
      'color': const Color(0xFF10B981),
      'features': [
        'Harmony Mapping',
        'Prosperity Synchronization',
        'Global Stability',
      ],
      'items': [
        {'h': 'Peace', 'd': 'Conflict-Free System'},
        {'h': 'Growth', 'd': 'Shared Prosperity'},
      ],
    },

    'world': {
      'title': 'World',
      'icon': Icons.language,
      'color': const Color(0xFF3B82F6),
      'features': [
        'Global Perspective',
        'Planetary Connectivity',
        'Unified Systems',
      ],
      'items': [
        {'h': 'Earth', 'd': 'Shared Human Network'},
        {'h': 'Vision', 'd': 'Universal Collaboration'},
      ],
    },

    'universal-peace': {
      'title': 'Universal Peace Rule',
      'icon': Icons.balance,
      'color': const Color(0xFFD4AF37),
      'features': [
        'Harmony Protocols',
        'Conflict Resolution',
        'Universal Ethics',
      ],
      'items': [
        {'h': 'Rule', 'd': 'Peace Before Conflict'},
        {'h': 'Result', 'd': 'Stable Civilization'},
      ],
    },

    'keep-adding': {
      'title': 'Keep Adding With Patience',
      'icon': Icons.auto_graph,
      'color': const Color(0xFF8B5CF6),
      'features': [
        'Incremental Growth',
        'Patience Mapping',
        'Long-Term Scaling',
      ],
      'items': [
        {'h': 'Method', 'd': 'Daily Improvement'},
        {'h': 'Result', 'd': 'Massive Evolution'},
      ],
    },

    'media-news': {
      'title': 'Media & News',
      'icon': Icons.newspaper,
      'color': const Color(0xFFEF4444),
      'features': [
        'Realtime Broadcasting',
        'Global Information Mesh',
        'Truth Synchronization',
      ],
      'items': [
        {'h': 'Media', 'd': 'Realtime Streams'},
        {'h': 'News', 'd': 'Worldwide Reports'},
      ],
    },

    'engagements': {
      'title': 'Engagements',
      'icon': Icons.groups,
      'color': const Color(0xFF6366F1),
      'features': [
        'Interactive Collaboration',
        'Realtime Participation',
        'Group Synchronization',
      ],
      'items': [
        {'h': 'Users', 'd': '12k Active Nodes'},
        {'h': 'Result', 'd': 'Strong Connectivity'},
      ],
    },

    'demonstration': {
      'title': 'Demonstration',
      'icon': Icons.slideshow,
      'color': const Color(0xFF06B6D4),
      'features': [
        'Visual Explanation',
        'Live Showcase',
        'Realtime Simulation',
      ],
      'items': [
        {'h': 'Demo', 'd': 'Neural Sliver Engine'},
        {'h': 'Goal', 'd': 'Clear Understanding'},
      ],
    },

    'group-discussions': {
      'title': 'Group Discussions',
      'icon': Icons.forum,
      'color': const Color(0xFF8B5CF6),
      'features': [
        'Collective Intelligence',
        'Discussion Synchronization',
        'Realtime Collaboration',
      ],
      'items': [
        {'h': 'Topic', 'd': 'Global Coordination'},
        {'h': 'Result', 'd': 'Shared Decisions'},
      ],
    },

    'situation': {
      'title': 'Situation & Reaction',
      'icon': Icons.crisis_alert,
      'color': const Color(0xFFEF4444),
      'features': [
        'Adaptive Reactions',
        'Scenario Mapping',
        'Realtime Response',
      ],
      'items': [
        {'h': 'Event', 'd': 'Unexpected Failure'},
        {'h': 'Response', 'd': 'Rapid Stabilization'},
      ],
    },

    'ground-task': {
      'title': 'Ground Task',
      'icon': Icons.task_alt,
      'color': const Color(0xFF10B981),
      'features': [
        'Field Operations',
        'Execution Tracking',
        'Task Synchronization',
      ],
      'items': [
        {'h': 'Mission', 'd': 'Node Deployment'},
        {'h': 'Status', 'd': 'Operational Success'},
      ],
    },

    'interviews': {
      'title': 'Interviews',
      'icon': Icons.record_voice_over,
      'color': const Color(0xFFF59E0B),
      'features': [
        'Candidate Analysis',
        'Communication Mapping',
        'Realtime Evaluation',
      ],
      'items': [
        {'h': 'Stage', 'd': 'Technical Discussion'},
        {'h': 'Outcome', 'd': 'Qualified Selection'},
      ],
    },

    'merits': {
      'title': 'Merits and Demerits',
      'icon': Icons.fact_check,
      'color': const Color(0xFF6366F1),
      'features': [
        'Pros-Cons Evaluation',
        'Balanced Analysis',
        'Decision Intelligence',
      ],
      'items': [
        {'h': 'Merit', 'd': 'High Performance'},
        {'h': 'Demerit', 'd': 'Complex Learning Curve'},
      ],
    },

    'medical-test': {
      'title': 'Medical Test',
      'icon': Icons.medical_services,
      'color': const Color(0xFFEF4444),
      'features': [
        'Health Diagnostics',
        'Vital Synchronization',
        'Medical Intelligence',
      ],
      'items': [
        {'h': 'Checkup', 'd': 'Full Neural Scan'},
        {'h': 'Result', 'd': 'Stable Condition'},
      ],
    },

    'joining': {
      'title': 'Joining Services',
      'icon': Icons.handshake,
      'color': const Color(0xFF10B981),
      'features': [
        'Recruitment Pipelines',
        'Service Integration',
        'Identity Synchronization',
      ],
      'items': [
        {'h': 'Status', 'd': 'Successfully Joined'},
        {'h': 'Access', 'd': 'Sovereign Clearance'},
      ],
    },

    'rules': {
      'title': 'Rules & Regulations',
      'icon': Icons.rule,
      'color': const Color(0xFF4F46E5),
      'features': [
        'Governance Systems',
        'Ethical Enforcement',
        'Policy Synchronization',
      ],
      'items': [
        {'h': 'Rule', 'd': 'Maintain Harmony'},
        {'h': 'Penalty', 'd': 'Access Restriction'},
      ],
    },

    'court': {
      'title': 'Court & Cases',
      'icon': Icons.account_balance,
      'color': const Color(0xFF6366F1),
      'features': [
        'Judicial Mapping',
        'Case Synchronization',
        'Truth Evaluation',
      ],
      'items': [
        {'h': 'Case', 'd': 'Identity Conflict'},
        {'h': 'Verdict', 'd': 'Resolved Fairly'},
      ],
    },

    'elections': {
      'title': 'Elections',
      'icon': Icons.how_to_vote,
      'color': const Color(0xFF10B981),
      'features': [
        'Voting Synchronization',
        'Public Representation',
        'Realtime Counting',
      ],
      'items': [
        {'h': 'Votes', 'd': '12M Counted'},
        {'h': 'Result', 'd': 'Peaceful Transition'},
      ],
    },

    'ruling': {
      'title': 'Ruling & Heart Winning',
      'icon': Icons.favorite,
      'color': const Color(0xFFF43F5E),
      'features': [
        'Leadership Through Respect',
        'Influence Mapping',
        'Emotional Harmony',
      ],
      'items': [
        {'h': 'Leader', 'd': 'Heart-Centered Governance'},
        {'h': 'Result', 'd': 'Unified Society'},
      ],
    },

    'spirituality': {
      'title': 'Spirituality & Lord-Shiva',
      'icon': Icons.self_improvement,
      'color': const Color(0xFFD4AF37),
      'features': [
        'Meditative Symmetry',
        'Inner Consciousness',
        'Divine Synchronization',
      ],
      'items': [
        {'h': 'Focus', 'd': 'Inner Stability'},
        {'h': 'Path', 'd': 'Universal Awareness'},
      ],
    },

    'prayer-all': {
      'title': 'Prayer For All',
      'icon': Icons.volunteer_activism,
      'color': const Color(0xFF10B981),
      'features': ['Collective Hope', 'Peace Projection', 'Global Healing'],
      'items': [
        {'h': 'Prayer', 'd': 'Peace For Humanity'},
        {'h': 'Goal', 'd': 'Unified Prosperity'},
      ],
    },

    'fingers-crossed': {
      'title': 'Fingers Are Crossed',
      'icon': Icons.pan_tool,
      'color': const Color(0xFF8B5CF6),
      'features': [
        'Hope-State Projection',
        'Positive Probability',
        'Future Anticipation',
      ],
      'items': [
        {'h': 'Wish', 'd': 'Successful Outcome'},
        {'h': 'Emotion', 'd': 'Optimistic Energy'},
      ],
    },

    'counting-reports': {
      'title': 'Counting Reports (Hi & En)',
      'icon': Icons.summarize,
      'color': const Color(0xFF06B6D4),
      'features': [
        'Bilingual Reporting',
        'Realtime Metrics',
        'Automated Summaries',
      ],
      'items': [
        {'h': 'Hindi', 'd': 'स्थिरता रिपोर्ट'},
        {'h': 'English', 'd': 'System Stability Report'},
      ],
    },
  };
}
