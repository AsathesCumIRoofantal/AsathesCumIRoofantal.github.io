import '../../routes/app_pages.dart';

/// Copy for drawer section headers and list links (add-on; does not replace titles).
class DrawerNavigationCopy {
  DrawerNavigationCopy._();

  static const String drawerPreamble =
      'This drawer mirrors your all-space atlas. Each link opens a focused workspace—use it together with Entities, Unions, and Identity on the home tabs. '
      'Catalogue concrete nodes and relationships on those tabs first, then use the drawer when you need programmes, vision, motivation, production, or system tools.';

  static String sectionBlurb(String sectionTitle) {
    return _sectionBlurbs[sectionTitle] ??
        'Browse the links below to open the related AIR workspace.';
  }

  static const Map<String, String> _sectionBlurbs = {
    'EXPLORE - ALIFIYAS':
        'Learning paths and curiosity hubs under Alifiyas—pick a tile to study, play, and grow. '
        'Use Learn And Fun plus Learn Docs when you want tiles and papers in one rhythm.',
    'RULE - MAZEASTA':
        'Mazeasta rule-set: reflective reading and open questions that sharpen judgment. '
        'Keep Wisdom and Ask Any Thing in rotation so rules stay lived, not only memorised.',
    'BE-YOU & EARN LIVING':
        'Share lived experience, log posts, and track identity-linked earnings in one flow. '
        'What you log here pairs with the Identity tab and entity-linked unions on the home surface.',
    "Use AIR's Space & Resources":
        'Organisation knowledge, offerings, discussions, and guest utilities in shared AIR space. '
        'Reach for this block when home tabs hold your map but you still need shared AIR assets.',
    'Your Profile Specifics':
        'Everything tied to your operating profile—events, upkeep, rewards, APIs, and visibility. '
        'Treat it as the operational layer on top of entities, unions, and identity you already curate.',
    "AIR's - Aspects":
        'How AIR evolves: tours, contribution, timelines, anomalies, training, and system posture. '
        'Open it when you want the story and health of AIR, not only your personal catalogue.',
    'SERVICE & PRODUCTION':
        'From raw input through process to finished outcomes—your production chain in the app. '
        'Walk the three links in order when you are closing a real delivery cycle end to end.',
    "AIR'S VISION":
        'Mission, showcase, calendars, and wrap-ups that narrate where AIR is headed. '
        'Skim before deep SETUP topics so choices stay aligned with the wider AIR narrative.',
    'MOTIVATION & CONNECTIVITY':
        'Human-centred boosts—accountability, connection, greetings, and gentle responsibility nudges. '
        'Use between heavier modules to restore pace without abandoning structure.',
    'SETUP A-ONE':
        'A wide catalogue of life-and-work topics—each link is its own mini workspace for depth study. '
        'Bookmark mentally which drawers you revisit; depth grows with patient return visits.',
    'SYSTEM CORE':
        'Preferences, transparency about the app and organisation, and a safe sign-out. '
        'Review About entries before asking others—many answers already live here.',
  };

  /// Subtitle under each drawer [ListTile] title.
  static String linkSubtitle(String route, String title) {
    return _routeSubtitles[route] ??
        'Topic: $title — tap to open the matching AIR module in full screen.';
  }

  static const Map<String, String> _routeSubtitles = {
    AppRoutes.LEARN_FUN:
        'Themed grids of learn-and-fun spaces; drill into categories and linked documents.',
    AppRoutes.LEARN_DOCS:
        'Category-indexed documents and reading rooms—pair with Learn And Fun for study depth.',
    AppRoutes.HEIGHER_STUDIES:
        'Structured higher-education orientation and references inside AIR.',
    AppRoutes.DOCTORATE:
        'Advanced study lane—research habits, depth reading, and scholarly rhythm.',
    AppRoutes.LIFE_HACKS:
        'Practical shortcuts and everyday efficiencies curated for busy learners.',
    AppRoutes.QUERIES:
        'Ask Anything channel—surface questions, follow threads, and invite answers.',
    AppRoutes.WISDOM:
        'Curated wisdom readings and AIR-aligned perspective for steady judgment.',
    AppRoutes.SHARE_EXPERIENCE:
        'Publish lived experience so others can learn from your path in all-space.',
    AppRoutes.RECORD_POST:
        'Capture posts, notes, or milestones as durable records in your profile.',
    AppRoutes.IDENTITIES_EARNINGS:
        'Log entity- or union-shaped work and see how identity effort translates to earnings.',
    AppRoutes.KNOWLEDGE_CENTER:
        'Central library of AIR knowledge assets—browse, filter, and open resources.',
    AppRoutes.PRODUCTS_SERVICES:
        'What AIR offers—catalogue of products and services you can explore or request.',
    AppRoutes.QUERY_DISCUSSION:
        'Threaded discussion for deeper queries beyond a single quick question.',
    AppRoutes.UTILITIES_GUEST:
        'Guest-friendly calculators and tools you can try before full onboarding.',
    AppRoutes.EVENTS:
        'Your schedule of AIR and profile events—plan, confirm, and follow up.',
    AppRoutes.MANAGEMENTS:
        'Operational controls for what you steward—teams, assets, or programmes.',
    AppRoutes.MAINTENANCE:
        'Health checks, upkeep tasks, and reminders so nothing silently drifts.',
    AppRoutes.CONNECT_COLLABORATE:
        'Find partners, co-create, and keep collaboration visible in one place.',
    AppRoutes.NOTICES:
        'Official notices that affect you—read, acknowledge, and archive.',
    AppRoutes.TRACKS_TRACES:
        'Audit-style trails—who did what, when—so accountability stays crisp.',
    AppRoutes.YOUR_BUSINESS:
        'Commercial or side-project footprint you declare to AIR for matching services.',
    AppRoutes.REWARDS_CREDITS:
        'Recognition ledger—credits, rewards, and redemption posture.',
    AppRoutes.APPROVAL_APPEALS:
        'Submit or review appeals where human approval gates sensitive actions.',
    AppRoutes.NETWORK_APIS:
        'Integrations and API touchpoints for power users and technical partners.',
    AppRoutes.PRIVATE_CONFIDENTIAL:
        'Sensitive artefacts stay here—treat as confidential by default.',
    AppRoutes.PUBLIC_STUFF:
        'What you are comfortable exposing publicly—bios, showcases, open links.',
    AppRoutes.RESUME_TOUR:
        'Pick up the guided tour where you left off and finish orientation steps.',
    AppRoutes.BE_PART_OF_AIR:
        'Pathways to belong—roles, expectations, and how to plug into AIR properly.',
    AppRoutes.CONTRIBUTE_TO_AIR:
        'Ideas, patches, content, or time—channel contributions responsibly.',
    AppRoutes.TIMELINE_OF_AIR:
        'Historical and upcoming beats of the organisation on one timeline.',
    AppRoutes.NEW_IN_AIR:
        'Release notes and fresh capabilities—skim what changed recently.',
    AppRoutes.CHECKED_ANOMALIES:
        'Reviewed irregularities—closed items with rationale and owners.',
    AppRoutes.UNCHECKED_ANOMALIES:
        'Open anomalies that still need triage, owners, or verification.',
    AppRoutes.LIMITS_0_1:
        'Binary and threshold thinking—where only zero-or-one decisions apply.',
    AppRoutes.COMMUNICATION:
        'Channels, tone, and cadence—keep communication intentional, not noisy.',
    AppRoutes.IMAGINATION_FEATURES:
        'Imagined futures and feature concepts—brainstorm without breaking production.',
    AppRoutes.BELIEFS_VALUES:
        'Articulate what you stand for so AIR can align coaching and matching.',
    AppRoutes.ENTERTAINMENT:
        'Light cultural content—balance seriousness with restoration.',
    AppRoutes.SKILLS_TALENTS:
        'Inventory strengths; pair them with opportunities AIR surfaces.',
    AppRoutes.BEING_RECORDED_REWARDED:
        'Transparency on logging, metrics, and how recognition follows behaviour.',
    AppRoutes.TRAINING:
        'Structured drills, curricula, and practice loops to level up.',
    AppRoutes.SYSTEM_ALL_TOGETHER:
        'Holistic systems view—how parts interlock across AIR operations.',
    AppRoutes.INPUT_IN_PROCESS:
        'Capture what enters the pipeline before it is transformed.',
    AppRoutes.PROCESS:
        'Middle state—rules, owners, and SLAs while work is underway.',
    AppRoutes.OUTCOME_PROCESSED:
        'Finished artefacts and receipts once processing completes.',
    AppRoutes.AIR_VISION:
        'Foundational narrative—how AIR maps all-space and why it matters.',
    AppRoutes.AIRS_MISSION:
        'Mission statements, priorities, and non-negotiable commitments.',
    AppRoutes.AIRS_SHOWCASE:
        'Highlights and exemplars that demonstrate AIR in action.',
    AppRoutes.WINDUP_ELSE:
        'Graceful closures—how to wind down initiatives without losing truth.',
    AppRoutes.FOLLOW_CALENDAR:
        'Cadence view—anchor habits and deadlines to a humane calendar.',
    AppRoutes.PICK_GOOD_GOING:
        'Choose constructive next steps instead of drifting by default.',
    AppRoutes.REVISE_IMPROVE:
        'Iterative refinement—inspect outputs and tighten the next cycle.',
    AppRoutes.PRACTICE_EXPERTISE:
        'Deliberate practice log—reps, feedback, and specialisation depth.',
    AppRoutes.SHARE_CARE:
        'Mutual aid posture—share resources and care loops with your circle.',
    AppRoutes.FINALLY_BLESSINGS:
        'Closing gratitude and benedictions—end sessions with clarity.',
    AppRoutes.MOTIVATION:
        'Short motivational passages to reset morale on hard days.',
    AppRoutes.NEVER_GIVE_UP:
        'Persistence framing—when to hold the line versus pivot smartly.',
    AppRoutes.INNOVATION_KEY:
        'Why novelty matters and how to innovate without losing integrity.',
    AppRoutes.ACCOUNTABLE:
        'Own outcomes—ledgers, promises, and transparent follow-through.',
    AppRoutes.LIVE_FULLEST:
        'Whole-life design—energy, ethics, and joy in the same frame.',
    AppRoutes.GET_CONNECTED_SOCIAL:
        'Healthy social graph hygiene—who you follow and why.',
    AppRoutes.TOGETHER_UNISON:
        'Harmony in groups—roles, rhythm, and conflict repair.',
    AppRoutes.ONBOARD:
        'Welcome path—first tasks so new members feel oriented fast.',
    AppRoutes.GREETINGS:
        'Warm protocols—how AIR greets people across cultures and contexts.',
    AppRoutes.RESPONSIBILITIES:
        'Duty mapping—what you owe to self, family, work, and community.',
    AppRoutes.SETTINGS:
        'App preferences, appearance, notifications, and safety toggles.',
    AppRoutes.ABOUT_APP:
        'Version, credits, and behaviour of this AIR mobile client.',
    AppRoutes.ABOUT_ORG:
        'Background on the AIR Organisation itself—charter and contact posture.',
    AppRoutes.LOGOUT:
        'End this session securely on this device.',
    AppRoutes.digitalize_records:
        'Digitise products and records—templates, scans, and structured capture.',
    AppRoutes.projects_assessments:
        'Project portfolios and assessment rubrics in one review lane.',
    AppRoutes.category_tree:
        'Navigate hierarchical categories like a living taxonomy tree.',
    AppRoutes.ease_tools:
        'Small utilities that remove friction from repetitive chores.',
    AppRoutes.vocabulary:
        'Terms, glossaries, and AIR-specific language for precise communication.',
    AppRoutes.code_conduct:
        'Ethical codes and conduct expectations while you operate inside AIR.',
    AppRoutes.script_strategy:
        'Narrative scripts and strategic storylines for campaigns or teaching.',
    AppRoutes.SAFETY:
        'Safety playbooks—physical, digital, and emotional guardrails.',
    AppRoutes.HOSPITALITY_CARE:
        'Care protocols—hosting, healing touches, and dignified reception.',
    AppRoutes.UTILITY_FACILITIES:
        'Facilities and shared utilities you rely on day to day.',
    AppRoutes.COMMERCE:
        'Buying, selling, and fair exchange within AIR-aligned commerce.',
    AppRoutes.SOCIAL:
        'Social graph hygiene—groups, norms, and healthy boundaries.',
    AppRoutes.RESEARCH_DEVELOPMENT:
        'R&D notebooks—hypotheses, experiments, and reproducible notes.',
    AppRoutes.TRAVEL_TRANSPORT:
        'Movement logistics—trips, fleets, and transport coordination.',
    AppRoutes.LOOP_HOLE:
        'Identify gaps before they become incidents—close loopholes early.',
    AppRoutes.ADVANTAGE:
        'Where you have edge—double down ethically and document why.',
    AppRoutes.CHALLENGE:
        'Name hard problems explicitly so teams can swarm them.',
    AppRoutes.SOLUTION:
        'Solution patterns—playbooks that turn insight into shipped fixes.',
    AppRoutes.INNOVATION:
        'Innovation pipeline—from idea intake to validated prototypes.',
    AppRoutes.DISCOVERY:
        'Exploration mode—customer discovery, field notes, and surprises.',
    AppRoutes.ENHANCEMENT:
        'Incremental upgrades that compound without big-bang risk.',
    AppRoutes.HOPE:
        'Forward narratives—why effort still makes sense on bleak days.',
    AppRoutes.SUCCESS_FAILURE:
        'Post-mortems and celebrations—learn equally from both poles.',
    AppRoutes.RELIGION_PRAYER:
        'Spiritual practice space—respectful, optional, and personal.',
    AppRoutes.FEEDBACK:
        'Collect and triage feedback so product loops stay honest.',
    AppRoutes.marketing_promotion:
        'Campaigns, promos, and ethical outreach you can stand behind.',
    AppRoutes.serve:
        'Service mindset—volunteer hours, seva logs, and community give-back.',
    AppRoutes.RELATIONSHIPS:
        'Map important ties—mentors, peers, dependents, and allies.',
    AppRoutes.OBLIGATIONS:
        'Legal and moral obligations you track so nothing slips.',
    AppRoutes.PUNCTUALITY:
        'Time integrity—SLAs, clocks, and respect for others’ minutes.',
    AppRoutes.LOYALTY:
        'Loyalty signals—where you commit long term versus experiment.',
    AppRoutes.APPRECIATIONS_THANKS:
        'Gratitude ledger—thank people while memory is fresh.',
    AppRoutes.EMPATHY_SYMPATHY:
        'Emotional intelligence drills—feel with, not just for, others.',
    AppRoutes.FORGIVNESS:
        'Forgiveness practice—release without pretending harm never mattered.',
    AppRoutes.KINDNESS:
        'Kindness and politeness as operational habits, not ornaments.',
    AppRoutes.RESPECT:
        'Respect baselines—titles, boundaries, and dignity defaults.',
    AppRoutes.SELF_DISCIPLINE:
        'Discipline systems—habits, streaks, and consequence design.',
    AppRoutes.AFFECTION_LOVE:
        'Healthy affection—boundaries plus warmth in the same frame.',
    AppRoutes.FAMILY:
        'Family roles, rituals, and shared calendars in AIR context.',
    AppRoutes.FRIENDSHIP:
        'Friend maintenance—reach-outs, reciprocity, and depth checks.',
    AppRoutes.RIVALRY:
        'Competitive tension—when rivalry sharpens instead of corroding.',
    AppRoutes.COMPITITION:
        'Fair competition—rules, scoring, and recovery after contests.',
    AppRoutes.TECHNOLOGY:
        'Tech stack notes—what you run, why, and upgrade windows.',
    AppRoutes.LANGUAGE_TRANSLATION:
        'Multilingual work—glossaries, translators, and cultural nuance.',
    AppRoutes.MONITORSHIP:
        'Mentor/monitor relationships—cadence, goals, and feedback loops.',
    AppRoutes.SURVELLENCE_INVESTIGATION:
        'Investigations—evidence chains with proportionate oversight.',
    AppRoutes.LEADERSHIP:
        'Leadership posture—vision, delegation, and follow-through.',
    AppRoutes.CONTROL_COORDINATION:
        'Controls and coordination—who pulls which levers, when.',
    AppRoutes.ONLY_ONE_WAY:
        'Present-moment focus—commit to one truthful path forward.',
    AppRoutes.TRADE_IMPORT_EXPORT:
        'Trade lanes—imports, exports, compliance, and counterparties.',
    AppRoutes.RANKING_ORDERS:
        'Ranked lists—priorities, leaderboards, and ordered decisions.',
    AppRoutes.STATISTICS:
        'Numbers that matter—distributions, trends, and honest baselines.',
    AppRoutes.PEACE_PROSPERITY:
        'Peace and prosperity indicators—community-level wellbeing view.',
    AppRoutes.WORLD:
        'Global context—regions, crises, and opportunities at planetary scale.',
    AppRoutes.UNIVERSAL_PEACE_RULE:
        'Norms that aspire toward universal peace without naive erasure.',
    AppRoutes.KEEP_ADDING_WITH_PATIENCE:
        'Long-horizon growth—add capacity slowly and compound kindly.',
    AppRoutes.MEDIA_NEWS:
        'Media diet—trusted sources, fact checks, and headline triage.',
    AppRoutes.ENGAGEMENTS:
        'Engagement metrics—events, RSVPs, and follow-up tasks.',
    AppRoutes.DEMONSTRATION:
        'Demos and walkthroughs—show, don’t only tell, your progress.',
    AppRoutes.GROUP_DISCUSSIONS:
        'Facilitated discussions—agendas, notes, and action items.',
    AppRoutes.SITUATION_REACTION:
        'Scenario drills—stimulus, response, and lessons captured.',
    AppRoutes.GROUND_TASK:
        'Field tasks—on-site work orders with proof of completion.',
    AppRoutes.INTERVIEWS:
        'Interview guides—questions, rubrics, and debrief templates.',
    AppRoutes.MERITS_DEMERITS:
        'Balanced evaluation—merits and demerits on the same page.',
    AppRoutes.MEDICAL:
        'Medical checks—appointments, reports, and consent-aware storage.',
    AppRoutes.JOINING_SERVICES:
        'Onboarding into services—contracts, oaths, and first-week plans.',
    AppRoutes.RULES_REGULATIONS:
        'Rules corpora—what is allowed, forbidden, and grey-zone.',
    AppRoutes.COURT_CASES:
        'Case files—dockets, hearings, and counsel coordination (informational).',
    AppRoutes.ELECTIONS:
        'Election literacy—platforms, timelines, and voter responsibility.',
    AppRoutes.HEART_WINNING:
        'Leadership with heart—policy plus empathy in public roles.',
    AppRoutes.SPIRITUALITY_LORD_SHIVA:
        'Spiritual content focused on Lord Shiva—devotional and educational.',
    AppRoutes.PRAYER_FOR_ALL:
        'Inclusive prayer intentions—peace, healing, and collective good.',
    AppRoutes.FINGERS_ARE_CROSSED:
        'Hopeful waiting—track pending outcomes without losing agency.',
    AppRoutes.COUNTING_REPORTS:
        'Bilingual counting reports—Hindi and English reporting rhythm.',
  };
}
