// ============================================================
// web_modules/_shared/web_nav_data.dart
// All drawer sections + items. Imported by the shell and home page.
// ============================================================

import 'package:flutter/material.dart';

class WebNavItem {
  final String title;
  final IconData icon;
  final String description;
  const WebNavItem({
    required this.title,
    required this.icon,
    required this.description,
  });
}

class WebNavSection {
  final String slug;
  final String title;
  final String tagline;
  final String blurb;
  final Color primary;
  final Color secondary;
  final Color accent;
  final IconData icon;
  final String route;
  final List<WebNavItem> items;
  const WebNavSection({
    required this.slug,
    required this.title,
    required this.tagline,
    required this.blurb,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.icon,
    required this.route,
    required this.items,
  });
}

class WebNavData {
  WebNavData._();

  static const String homeRoute = '/web-home';
  static const String homeWebRtcRoute = '/web-home/web-rtc';
  static const String homeAgoraRoute = '/web-home/agora-rtc';
  static const String homeLivekitRtcRoute = '/web-home/livekit-rtc';

  static const setup_digitalizeHub = '/setup-aone/digitalize-hub';
  static const setup_projectsAssessments = '/setup-aone/projects-assessments';
  static const setup_categoryTree = '/setup-aone/category-tree';
  static const setup_easeTools = '/setup-aone/ease-tools';
  static const setup_vocabulary = '/setup-aone/vocabulary';
  static const setup_codeConduct = '/setup-aone/code-conduct';
  static const setup_scriptStrategy = '/setup-aone/script-strategy';
  static const setup_safety = '/setup-aone/safety';
  static const setup_hospitalityCare = '/setup-aone/hospitality-care';
  static const setup_utilityFacilities = '/setup-aone/utility-facilities';
  static const setup_commerce = '/setup-aone/commerce';
  static const setup_social = '/setup-aone/social';

  static final List<WebNavSection> sections = [
    WebNavSection(
      slug: 'explore',
      title: 'EXPLORE - ALIFIYAS',
      tagline: 'Curiosity is the first principle',
      blurb:
          'Learning paths and curiosity hubs under Alifiyas. Pick a tile to study, play, and grow. Use Learn And Fun plus Learn Docs when you want tiles and papers in one rhythm.',
      primary: Color(0xFFF59E0B),
      secondary: Color(0xFFEA580C),
      accent: Color(0xFFFEF3C7),
      icon: Icons.lightbulb_outline,
      route: '/web-explore',
      items: [
        WebNavItem(
          title: 'Learn And Fun',
          icon: Icons.lightbulb_outline,
          description:
              'Themed grids of learn-and-fun spaces; drill into categories and linked documents.',
        ),
        WebNavItem(
          title: 'Learn Docs (by category)',
          icon: Icons.menu_book_outlined,
          description:
              'Category-indexed documents and reading rooms — pair with Learn And Fun for study depth.',
        ),
        WebNavItem(
          title: 'Heigher Studies',
          icon: Icons.school_outlined,
          description:
              'Structured higher-education orientation and references inside AIR.',
        ),
        WebNavItem(
          title: 'Doctorate',
          icon: Icons.local_hospital,
          description:
              'Advanced study lane — research habits, depth reading, and scholarly rhythm.',
        ),
        WebNavItem(
          title: 'Life Hacks',
          icon: Icons.heat_pump_rounded,
          description:
              'Practical shortcuts and everyday efficiencies curated for busy learners.',
        ),
        WebNavItem(
          title: 'Ask Any Thing',
          icon: Icons.question_answer,
          description:
              'Ask Anything channel — surface questions, follow threads, and invite answers.',
        ),
      ],
    ),
    WebNavSection(
      slug: 'wisdom',
      title: 'RULE - MAZEASTA',
      tagline: 'Rules that breathe, wisdom that holds',
      blurb:
          'Mazeasta rule-set: reflective reading and open questions that sharpen judgment. Keep Wisdom and Ask Any Thing in rotation so rules stay lived, not only memorised.',
      primary: Color(0xFF4F46E5),
      secondary: Color(0xFF312E81),
      accent: Color(0xFFE0E7FF),
      icon: Icons.auto_stories_rounded,
      route: '/web-wisdom',
      items: [
        WebNavItem(
          title: 'Wisdom',
          icon: Icons.book,
          description:
              'Curated wisdom readings and AIR-aligned perspective for steady judgment.',
        ),
        WebNavItem(
          title: 'Ask Any Thing',
          icon: Icons.question_answer,
          description:
              'Surface questions, follow threads, and invite answers from the community.',
        ),
      ],
    ),
    WebNavSection(
      slug: 'be_you',
      title: 'BE-YOU & EARN LIVING',
      tagline: 'Your voice. Your work. Your living.',
      blurb:
          'Share lived experience, log posts, and track identity-linked earnings in one flow. What you log here pairs with the Identity tab and entity-linked unions on the home surface.',
      primary: Color(0xFF059669),
      secondary: Color(0xFF065F46),
      accent: Color(0xFFD1FAE5),
      icon: Icons.person_pin_rounded,
      route: '/web-be_you',
      items: [
        WebNavItem(
          title: 'Share Experience',
          icon: Icons.share,
          description:
              'Publish lived experience so others can learn from your path in all-space.',
        ),
        WebNavItem(
          title: 'Record Your Post',
          icon: Icons.post_add,
          description:
              'Capture posts, notes, or milestones as durable records in your profile.',
        ),
        WebNavItem(
          title: 'Identities Cum Earnings',
          icon: Icons.format_list_numbered,
          description:
              'Log entity- or union-shaped work and see how identity effort translates to earnings.',
        ),
      ],
    ),
    WebNavSection(
      slug: 'air_space',
      title: 'Use AIR\'s Space & Resources',
      tagline: 'Shared atlas. Shared workshop.',
      blurb:
          'Organisation knowledge, offerings, discussions, and guest utilities in shared AIR space. Reach for this block when home tabs hold your map but you still need shared AIR assets.',
      primary: Color(0xFF0284C7),
      secondary: Color(0xFF075985),
      accent: Color(0xFFE0F2FE),
      icon: Icons.hub_rounded,
      route: '/web-air_space',
      items: [
        WebNavItem(
          title: 'Knowledge Center',
          icon: Icons.unarchive,
          description:
              'Central library of AIR knowledge assets — browse, filter, and open resources.',
        ),
        WebNavItem(
          title: 'Products & Services',
          icon: Icons.output,
          description:
              'What AIR offers — catalogue of products and services you can explore or request.',
        ),
        WebNavItem(
          title: 'Query & Discussion',
          icon: Icons.question_answer,
          description:
              'Threaded discussion for deeper queries beyond a single quick question.',
        ),
        WebNavItem(
          title: 'Utilities as Guest',
          icon: Icons.extension_outlined,
          description:
              'Guest-friendly calculators and tools you can try before full onboarding.',
        ),
      ],
    ),
    WebNavSection(
      slug: 'profile',
      title: 'Your Profile Specifics',
      tagline: 'The operational layer of you',
      blurb:
          'Everything tied to your operating profile — events, upkeep, rewards, APIs, and visibility. Treat it as the operational layer on top of entities, unions, and identity you already curate.',
      primary: Color(0xFF7C3AED),
      secondary: Color(0xFF4C1D95),
      accent: Color(0xFFEDE9FE),
      icon: Icons.account_circle_rounded,
      route: '/web-profile',
      items: [
        WebNavItem(
          title: 'Events',
          icon: Icons.event,
          description:
              'Your schedule of AIR and profile events — plan, confirm, and follow up.',
        ),
        WebNavItem(
          title: 'Managements',
          icon: Icons.manage_accounts,
          description:
              'Operational controls for what you steward — teams, assets, or programmes.',
        ),
        WebNavItem(
          title: 'Maintenance',
          icon: Icons.build_outlined,
          description:
              'Health checks, upkeep tasks, and reminders so nothing silently drifts.',
        ),
        WebNavItem(
          title: 'Connect & Collaborate',
          icon: Icons.connect_without_contact,
          description:
              'Find partners, co-create, and keep collaboration visible in one place.',
        ),
        WebNavItem(
          title: 'Notices',
          icon: Icons.notifications_none,
          description:
              'Official notices that affect you — read, acknowledge, and archive.',
        ),
        WebNavItem(
          title: 'Tracks & Traces',
          icon: Icons.track_changes,
          description:
              'Audit-style trails — who did what, when — so accountability stays crisp.',
        ),
        WebNavItem(
          title: 'Your Business',
          icon: Icons.business_sharp,
          description:
              'Commercial or side-project footprint you declare to AIR for matching services.',
        ),
        WebNavItem(
          title: 'Rewards/Credits',
          icon: Icons.diamond,
          description:
              'Recognition ledger — credits, rewards, and redemption posture.',
        ),
        WebNavItem(
          title: 'Approval of Appeals',
          icon: Icons.approval,
          description:
              'Submit or review appeals where human approval gates sensitive actions.',
        ),
        WebNavItem(
          title: 'Network (APIs) Stuff',
          icon: Icons.api,
          description:
              'Integrations and API touchpoints for power users and technical partners.',
        ),
        WebNavItem(
          title: 'Private/Confidential Stuff',
          icon: Icons.public_off,
          description:
              'Sensitive artefacts stay here — treat as confidential by default.',
        ),
        WebNavItem(
          title: 'Public Stuff',
          icon: Icons.public,
          description:
              'What you are comfortable exposing publicly — bios, showcases, open links.',
        ),
      ],
    ),
    WebNavSection(
      slug: 'aspects',
      title: 'AIR\'s - Aspects',
      tagline: 'The story and health of AIR',
      blurb:
          'How AIR evolves: tours, contribution, timelines, anomalies, training, and system posture. Open it when you want the story and health of AIR, not only your personal catalogue.',
      primary: Color(0xFFE11D48),
      secondary: Color(0xFF881337),
      accent: Color(0xFFFFE4E6),
      icon: Icons.hub_outlined,
      route: '/web-aspects',
      items: [
        WebNavItem(
          title: 'Let\'s resume your tour',
          icon: Icons.travel_explore,
          description:
              'Pick up the guided tour where you left off and finish orientation steps.',
        ),
        WebNavItem(
          title: 'Be the part of AIR',
          icon: Icons.grade,
          description:
              'Pathways to belong — roles, expectations, and how to plug into AIR properly.',
        ),
        WebNavItem(
          title: 'Contribute to AIR',
          icon: Icons.add_box,
          description:
              'Ideas, patches, content, or time — channel contributions responsibly.',
        ),
        WebNavItem(
          title: 'Timeline of AIR',
          icon: Icons.timeline,
          description:
              'Historical and upcoming beats of the organisation on one timeline.',
        ),
        WebNavItem(
          title: 'New in AIR',
          icon: Icons.new_releases,
          description:
              'Release notes and fresh capabilities — skim what changed recently.',
        ),
        WebNavItem(
          title: 'Checked Space Anomalies',
          icon: Icons.check_circle_outline_rounded,
          description:
              'Reviewed irregularities — closed items with rationale and owners.',
        ),
        WebNavItem(
          title: 'Un-Checked Space Anomalies',
          icon: Icons.question_mark_outlined,
          description:
              'Open anomalies that still need triage, owners, or verification.',
        ),
        WebNavItem(
          title: 'Limits (0 or 1)',
          icon: Icons.calculate_outlined,
          description:
              'Binary and threshold thinking — where only zero-or-one decisions apply.',
        ),
        WebNavItem(
          title: 'Communication',
          icon: Icons.transform_rounded,
          description:
              'Channels, tone, and cadence — keep communication intentional, not noisy.',
        ),
        WebNavItem(
          title: 'Imagination & Features',
          icon: Icons.featured_play_list_outlined,
          description:
              'Imagined futures and feature concepts — brainstorm without breaking production.',
        ),
        WebNavItem(
          title: 'Beliefs & Values',
          icon: Icons.flag_outlined,
          description:
              'Articulate what you stand for so AIR can align coaching and matching.',
        ),
        WebNavItem(
          title: 'Entertainment',
          icon: Icons.play_circle_outline_rounded,
          description:
              'Light cultural content — balance seriousness with restoration.',
        ),
        WebNavItem(
          title: 'Skills & Talents',
          icon: Icons.star_border_rounded,
          description:
              'Inventory strengths; pair them with opportunities AIR surfaces.',
        ),
        WebNavItem(
          title: 'Being Recorded & Rewarded',
          icon: Icons.data_object_rounded,
          description:
              'Transparency on logging, metrics, and how recognition follows behaviour.',
        ),
        WebNavItem(
          title: 'Training',
          icon: Icons.lens_blur_rounded,
          description:
              'Structured drills, curricula, and practice loops to level up.',
        ),
        WebNavItem(
          title: 'System All Together',
          icon: Icons.all_inclusive_rounded,
          description:
              'Holistic systems view — how parts interlock across AIR operations.',
        ),
      ],
    ),
    WebNavSection(
      slug: 'service',
      title: 'SERVICE & PRODUCTION',
      tagline: 'From input to outcome — closing the loop',
      blurb:
          'From raw input through process to finished outcomes — your production chain in the app. Walk the three links in order when you are closing a real delivery cycle end to end.',
      primary: Color(0xFF0D9488),
      secondary: Color(0xFF115E59),
      accent: Color(0xFFCCFBF1),
      icon: Icons.precision_manufacturing_rounded,
      route: '/web-service',
      items: [
        WebNavItem(
          title: 'Input in Process',
          icon: Icons.arrow_forward_ios_rounded,
          description:
              'Capture what enters the pipeline before it is transformed.',
        ),
        WebNavItem(
          title: 'Process',
          icon: Icons.gavel_rounded,
          description:
              'Middle state — rules, owners, and SLAs while work is underway.',
        ),
        WebNavItem(
          title: 'Outcome of Processed',
          icon: Icons.computer_sharp,
          description:
              'Finished artefacts and receipts once processing completes.',
        ),
      ],
    ),
    WebNavSection(
      slug: 'vision',
      title: 'AIR\'S VISION',
      tagline: 'Where AIR is headed — and why',
      blurb:
          'Mission, showcase, calendars, and wrap-ups that narrate where AIR is headed. Skim before deep SETUP topics so choices stay aligned with the wider AIR narrative.',
      primary: Color(0xFFD4AF37),
      secondary: Color(0xFF78350F),
      accent: Color(0xFFFEF3C7),
      icon: Icons.visibility_rounded,
      route: '/web-vision',
      items: [
        WebNavItem(
          title: 'AIR\'s Vision',
          icon: Icons.visibility_outlined,
          description:
              'Foundational narrative — how AIR maps all-space and why it matters.',
        ),
        WebNavItem(
          title: 'AIR\'s Mission',
          icon: Icons.music_note_sharp,
          description:
              'Mission statements, priorities, and non-negotiable commitments.',
        ),
        WebNavItem(
          title: 'AIR\'s Show Case',
          icon: Icons.show_chart,
          description:
              'Highlights and exemplars that demonstrate AIR in action.',
        ),
        WebNavItem(
          title: 'Let\'s Windup Else',
          icon: Icons.wrap_text,
          description:
              'Graceful closures — how to wind down initiatives without losing truth.',
        ),
        WebNavItem(
          title: 'Follow like Calender',
          icon: Icons.calendar_month_outlined,
          description:
              'Cadence view — anchor habits and deadlines to a humane calendar.',
        ),
        WebNavItem(
          title: 'Pick Your Good Going',
          icon: Icons.golf_course,
          description:
              'Choose constructive next steps instead of drifting by default.',
        ),
      ],
    ),
    WebNavSection(
      slug: 'motivation',
      title: 'MOTIVATION & CONNECTIVITY',
      tagline: 'Pace, presence, and people',
      blurb:
          'Human-centred boosts — accountability, connection, greetings, and gentle responsibility nudges. Use between heavier modules to restore pace without abandoning structure.',
      primary: Color(0xFFEC4899),
      secondary: Color(0xFF9D174D),
      accent: Color(0xFFFCE7F3),
      icon: Icons.favorite_rounded,
      route: '/web-motivation',
      items: [
        WebNavItem(
          title: 'Revise & Improve',
          icon: Icons.icecream_rounded,
          description:
              'Iterative refinement — inspect outputs and tighten the next cycle.',
        ),
        WebNavItem(
          title: 'Practice & Expertise',
          icon: Icons.hail_outlined,
          description:
              'Deliberate practice log — reps, feedback, and specialisation depth.',
        ),
        WebNavItem(
          title: 'Share & Care',
          icon: Icons.handshake_rounded,
          description:
              'Mutual aid posture — share resources and care loops with your circle.',
        ),
        WebNavItem(
          title: 'Finnally All is Blessings',
          icon: Icons.widgets,
          description:
              'Closing gratitude and benedictions — end sessions with clarity.',
        ),
        WebNavItem(
          title: 'A Word of Motivation',
          icon: Icons.elderly_sharp,
          description:
              'Short motivational passages to reset morale on hard days.',
        ),
        WebNavItem(
          title: 'Never Give Up',
          icon: Icons.window,
          description:
              'Persistence framing — when to hold the line versus pivot smartly.',
        ),
        WebNavItem(
          title: 'Innovation is Key',
          icon: Icons.lightbulb_outline,
          description:
              'Why novelty matters and how to innovate without losing integrity.',
        ),
        WebNavItem(
          title: 'You Got All of it Accountable',
          icon: Icons.account_balance_wallet,
          description:
              'Own outcomes — ledgers, promises, and transparent follow-through.',
        ),
        WebNavItem(
          title: 'Live Life to the Fullest',
          icon: Icons.favorite,
          description:
              'Whole-life design — energy, ethics, and joy in the same frame.',
        ),
        WebNavItem(
          title: 'Get Connected',
          icon: Icons.groups_2_rounded,
          description: 'Healthy social graph hygiene — who you follow and why.',
        ),
        WebNavItem(
          title: 'Being Together is Unison',
          icon: Icons.compare_arrows,
          description:
              'Harmony in groups — roles, rhythm, and conflict repair.',
        ),
        WebNavItem(
          title: 'Great to Have You Onboard',
          icon: Icons.airplanemode_active,
          description:
              'Welcome path — first tasks so new members feel oriented fast.',
        ),
        WebNavItem(
          title: 'All Greetings',
          icon: Icons.waving_hand,
          description:
              'Warm protocols — how AIR greets people across cultures and contexts.',
        ),
        WebNavItem(
          title: 'Be Liable to Responsibilities',
          icon: Icons.home_work_rounded,
          description:
              'Duty mapping — what you owe to self, family, work, and community.',
        ),
      ],
    ),
    WebNavSection(
      slug: 'setup',
      title: 'SETUP A-ONE',
      tagline: 'A wide catalogue of life-and-work topics',
      blurb:
          'A wide catalogue of life-and-work topics — each link is its own mini workspace for depth study. Depth grows with patient return visits.',
      primary: Color(0xFF6366F1),
      secondary: Color(0xFF1E1B4B),
      accent: Color(0xFFE0E7FF),
      icon: Icons.settings_suggest_rounded,
      route: '/web-setup',
      items: [
        WebNavItem(
          title: 'Product & Record (DIGITALIZE)',
          icon: Icons.all_inclusive_rounded,
          description:
              'Digitise products and records — templates, scans, and structured capture.',
        ),
        WebNavItem(
          title: 'Projects & Assessments',
          icon: Icons.assessment,
          description:
              'Project portfolios and assessment rubrics in one review lane.',
        ),
        WebNavItem(
          title: 'Category Tree',
          icon: Icons.local_florist,
          description:
              'Navigate hierarchical categories like a living taxonomy tree.',
        ),
        WebNavItem(
          title: 'Ease Tools',
          icon: Icons.handyman,
          description:
              'Small utilities that remove friction from repetitive chores.',
        ),
        WebNavItem(
          title: 'Vocabulary',
          icon: Icons.wordpress,
          description:
              'Terms, glossaries, and AIR-specific language for precise communication.',
        ),
        WebNavItem(
          title: 'Code & Conduct',
          icon: Icons.code,
          description:
              'Ethical codes and conduct expectations while you operate inside AIR.',
        ),
        WebNavItem(
          title: 'Script & Strategy',
          icon: Icons.video_collection,
          description:
              'Narrative scripts and strategic storylines for campaigns or teaching.',
        ),
        WebNavItem(
          title: 'Safety',
          icon: Icons.safety_check,
          description:
              'Safety playbooks — physical, digital, and emotional guardrails.',
        ),
        WebNavItem(
          title: 'Hospitality & Care',
          icon: Icons.self_improvement_rounded,
          description:
              'Care protocols — hosting, healing touches, and dignified reception.',
        ),
        WebNavItem(
          title: 'Utility & Facilities',
          icon: Icons.amp_stories_rounded,
          description:
              'Facilities and shared utilities you rely on day to day.',
        ),
        WebNavItem(
          title: 'Commerce',
          icon: Icons.cabin,
          description:
              'Buying, selling, and fair exchange within AIR-aligned commerce.',
        ),
        WebNavItem(
          title: 'Social',
          icon: Icons.social_distance,
          description:
              'Social graph hygiene — groups, norms, and healthy boundaries.',
        ),
        WebNavItem(
          title: 'Research & Development',
          icon: Icons.science_outlined,
          description:
              'R&D notebooks — hypotheses, experiments, and reproducible notes.',
        ),
        WebNavItem(
          title: 'Travel & Transport',
          icon: Icons.flight_land_outlined,
          description:
              'Movement logistics — trips, fleets, and transport coordination.',
        ),
        WebNavItem(
          title: 'Loop Hole',
          icon: Icons.loop,
          description:
              'Identify gaps before they become incidents — close loopholes early.',
        ),
        WebNavItem(
          title: 'Advantage',
          icon: Icons.star_border_rounded,
          description:
              'Where you have edge — double down ethically and document why.',
        ),
        WebNavItem(
          title: 'Challenge',
          icon: Icons.flag_outlined,
          description: 'Name hard problems explicitly so teams can swarm them.',
        ),
        WebNavItem(
          title: 'Solution',
          icon: Icons.lightbulb_outline,
          description:
              'Solution patterns — playbooks that turn insight into shipped fixes.',
        ),
        WebNavItem(
          title: 'Innovation',
          icon: Icons.new_label,
          description:
              'Innovation pipeline — from idea intake to validated prototypes.',
        ),
        WebNavItem(
          title: 'Discovery',
          icon: Icons.search,
          description:
              'Exploration mode — customer discovery, field notes, and surprises.',
        ),
        WebNavItem(
          title: 'Enhancement',
          icon: Icons.auto_fix_high,
          description:
              'Incremental upgrades that compound without big-bang risk.',
        ),
        WebNavItem(
          title: 'Hope',
          icon: Icons.cloud_rounded,
          description:
              'Forward narratives — why effort still makes sense on bleak days.',
        ),
        WebNavItem(
          title: 'Success & Failure',
          icon: Icons.star,
          description:
              'Post-mortems and celebrations — learn equally from both poles.',
        ),
        WebNavItem(
          title: 'Religion & Prayer',
          icon: Icons.auto_fix_high,
          description:
              'Spiritual practice space — respectful, optional, and personal.',
        ),
        WebNavItem(
          title: 'Feedback',
          icon: Icons.feedback,
          description:
              'Collect and triage feedback so product loops stay honest.',
        ),
        WebNavItem(
          title: 'Marketing & Promotion',
          icon: Icons.shop,
          description:
              'Campaigns, promos, and ethical outreach you can stand behind.',
        ),
        WebNavItem(
          title: 'Serve',
          icon: Icons.volunteer_activism,
          description:
              'Service mindset — volunteer hours, seva logs, and community give-back.',
        ),
        WebNavItem(
          title: 'Relationships',
          icon: Icons.group,
          description:
              'Map important ties — mentors, peers, dependents, and allies.',
        ),
        WebNavItem(
          title: 'Obligations',
          icon: Icons.rule,
          description:
              'Legal and moral obligations you track so nothing slips.',
        ),
        WebNavItem(
          title: 'Punctuality',
          icon: Icons.watch_later_outlined,
          description:
              'Time integrity — SLAs, clocks, and respect for others\' minutes.',
        ),
        WebNavItem(
          title: 'Loyalty',
          icon: Icons.verified_user,
          description:
              'Loyalty signals — where you commit long term versus experiment.',
        ),
        WebNavItem(
          title: 'Appreciations & Thanks',
          icon: Icons.wallet_giftcard,
          description: 'Gratitude ledger — thank people while memory is fresh.',
        ),
        WebNavItem(
          title: 'Empathy & Sympathy',
          icon: Icons.heart_broken,
          description:
              'Emotional intelligence drills — feel with, not just for, others.',
        ),
        WebNavItem(
          title: 'Forgivness',
          icon: Icons.forest,
          description:
              'Forgiveness practice — release without pretending harm never mattered.',
        ),
        WebNavItem(
          title: 'Kindness & Politeness',
          icon: Icons.face,
          description:
              'Kindness and politeness as operational habits, not ornaments.',
        ),
        WebNavItem(
          title: 'Respect',
          icon: Icons.account_circle_sharp,
          description:
              'Respect baselines — titles, boundaries, and dignity defaults.',
        ),
        WebNavItem(
          title: 'Discipline',
          icon: Icons.architecture,
          description:
              'Discipline systems — habits, streaks, and consequence design.',
        ),
        WebNavItem(
          title: 'Affection & Love',
          icon: Icons.favorite,
          description:
              'Healthy affection — boundaries plus warmth in the same frame.',
        ),
        WebNavItem(
          title: 'Family',
          icon: Icons.family_restroom,
          description:
              'Family roles, rituals, and shared calendars in AIR context.',
        ),
        WebNavItem(
          title: 'Friendship',
          icon: Icons.people_outline,
          description:
              'Friend maintenance — reach-outs, reciprocity, and depth checks.',
        ),
        WebNavItem(
          title: 'Rivalry And War',
          icon: Icons.military_tech,
          description:
              'Competitive tension — when rivalry sharpens instead of corroding.',
        ),
        WebNavItem(
          title: 'Competition',
          icon: Icons.flag,
          description:
              'Fair competition — rules, scoring, and recovery after contests.',
        ),
        WebNavItem(
          title: 'Technology',
          icon: Icons.computer,
          description:
              'Tech stack notes — what you run, why, and upgrade windows.',
        ),
        WebNavItem(
          title: 'Language & Translation',
          icon: Icons.language,
          description:
              'Multilingual work — glossaries, translators, and cultural nuance.',
        ),
        WebNavItem(
          title: 'Monitorship',
          icon: Icons.remove_red_eye,
          description:
              'Mentor/monitor relationships — cadence, goals, and feedback loops.',
        ),
        WebNavItem(
          title: 'Survellence & Investigation',
          icon: Icons.security,
          description:
              'Investigations — evidence chains with proportionate oversight.',
        ),
        WebNavItem(
          title: 'Leadership',
          icon: Icons.co_present_rounded,
          description:
              'Leadership posture — vision, delegation, and follow-through.',
        ),
        WebNavItem(
          title: 'Control & Coordination',
          icon: Icons.pan_tool_alt_outlined,
          description:
              'Controls and coordination — who pulls which levers, when.',
        ),
        WebNavItem(
          title: 'The Present - The Only One Way',
          icon: Icons.currency_rupee,
          description:
              'Present-moment focus — commit to one truthful path forward.',
        ),
        WebNavItem(
          title: 'Trade Import-Export',
          icon: Icons.import_export,
          description:
              'Trade lanes — imports, exports, compliance, and counterparties.',
        ),
        WebNavItem(
          title: 'Ranking Orders',
          icon: Icons.format_list_numbered,
          description:
              'Ranked lists — priorities, leaderboards, and ordered decisions.',
        ),
        WebNavItem(
          title: 'Statistics',
          icon: Icons.show_chart,
          description:
              'Numbers that matter — distributions, trends, and honest baselines.',
        ),
        WebNavItem(
          title: 'Peace and Prosperity',
          icon: Icons.landscape_rounded,
          description:
              'Peace and prosperity indicators — community-level wellbeing view.',
        ),
        WebNavItem(
          title: 'World',
          icon: Icons.public,
          description:
              'Global context — regions, crises, and opportunities at planetary scale.',
        ),
        WebNavItem(
          title: 'Universal Peace Rule',
          icon: Icons.gavel,
          description:
              'Norms that aspire toward universal peace without naive erasure.',
        ),
        WebNavItem(
          title: 'Keep Adding With Patience',
          icon: Icons.add,
          description:
              'Long-horizon growth — add capacity slowly and compound kindly.',
        ),
        WebNavItem(
          title: 'Media & News',
          icon: Icons.newspaper,
          description:
              'Media diet — trusted sources, fact checks, and headline triage.',
        ),
        WebNavItem(
          title: 'Engagements',
          icon: Icons.energy_savings_leaf,
          description:
              'Engagement metrics — events, RSVPs, and follow-up tasks.',
        ),
        WebNavItem(
          title: 'Demonstration',
          icon: Icons.engineering,
          description:
              'Demos and walkthroughs — show, don\'t only tell, your progress.',
        ),
        WebNavItem(
          title: 'Group Discussions',
          icon: Icons.chat,
          description:
              'Facilitated discussions — agendas, notes, and action items.',
        ),
        WebNavItem(
          title: 'Situation & Reaction',
          icon: Icons.announcement,
          description:
              'Scenario drills — stimulus, response, and lessons captured.',
        ),
        WebNavItem(
          title: 'Ground Task',
          icon: Icons.task_alt,
          description:
              'Field tasks — on-site work orders with proof of completion.',
        ),
        WebNavItem(
          title: 'Interviews',
          icon: Icons.record_voice_over,
          description:
              'Interview guides — questions, rubrics, and debrief templates.',
        ),
        WebNavItem(
          title: 'Merits and Demerits',
          icon: Icons.list_alt_rounded,
          description:
              'Balanced evaluation — merits and demerits on the same page.',
        ),
        WebNavItem(
          title: 'Medical Test',
          icon: Icons.medical_services,
          description:
              'Medical checks — appointments, reports, and consent-aware storage.',
        ),
        WebNavItem(
          title: 'Joining Services',
          icon: Icons.join_right_rounded,
          description:
              'Onboarding into services — contracts, oaths, and first-week plans.',
        ),
        WebNavItem(
          title: 'Rules & Regulations',
          icon: Icons.rule_folder_rounded,
          description:
              'Rules corpora — what is allowed, forbidden, and grey-zone.',
        ),
        WebNavItem(
          title: 'Court & Cases',
          icon: Icons.balance,
          description:
              'Case files — dockets, hearings, and counsel coordination (informational).',
        ),
        WebNavItem(
          title: 'Elections',
          icon: Icons.how_to_vote,
          description:
              'Election literacy — platforms, timelines, and voter responsibility.',
        ),
        WebNavItem(
          title: 'Ruling & Heart Winning',
          icon: Icons.emoji_flags,
          description:
              'Leadership with heart — policy plus empathy in public roles.',
        ),
        WebNavItem(
          title: 'Spirituality & Lord-Shiva',
          icon: Icons.temple_hindu,
          description:
              'Devotional and contemplative anchors — held with respect.',
        ),
        WebNavItem(
          title: 'Prayer For All',
          icon: Icons.volunteer_activism,
          description:
              'Universal prayer practices that honour every tradition.',
        ),
        WebNavItem(
          title: 'Fingers Are Crossed',
          icon: Icons.cruelty_free,
          description:
              'Hope and luck rituals — name them rather than pretending they don\'t matter.',
        ),
        WebNavItem(
          title: 'Counting Reports — Hindi & English',
          icon: Icons.read_more,
          description:
              'Bilingual counting and reporting drills for clarity across languages.',
        ),
      ],
    ),
    WebNavSection(
      slug: 'system',
      title: 'SYSTEM CORE',
      tagline: 'Preferences, transparency, and a safe exit',
      blurb:
          'Preferences, transparency about the app and organisation, and a safe sign-out. Review About entries before asking others — many answers already live here.',
      primary: Color(0xFF475569),
      secondary: Color(0xFF0F172A),
      accent: Color(0xFFE2E8F0),
      icon: Icons.tune_rounded,
      route: '/web-system',
      items: [
        WebNavItem(
          title: 'App Setting',
          icon: Icons.settings,
          description:
              'App preferences, appearance, notifications, and safety toggles.',
        ),
        WebNavItem(
          title: 'About AIR-APP',
          icon: Icons.air,
          description:
              'Version, credits, and behaviour of this AIR mobile client.',
        ),
        WebNavItem(
          title: 'About AIR Organization',
          icon: Icons.info,
          description:
              'Background on the AIR Organisation itself — charter and contact posture.',
        ),
        WebNavItem(
          title: 'Sign Out',
          icon: Icons.logout_rounded,
          description: 'End this session securely on this device.',
        ),
      ],
    ),
  ];

  static WebNavSection bySlug(String slug) =>
      sections.firstWhere((s) => s.slug == slug);
}
