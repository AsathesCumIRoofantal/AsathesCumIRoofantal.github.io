import 'package:get/get.dart';

/// Categorised role + specific catalog inferred from login page.
/// Used by every `new_app_*` alifiyas module to tailor content.
class NewAppRoleCatalog {
  NewAppRoleCatalog._();

  /// Top-level roles a logged-in user may carry.
  static const List<String> roles = <String>[
    'Diplomat',
    'Scholar',
    'Citizen',
    'Entrepreneur',
    'Worker',
    'Artist',
    'Scientist',
    'Caregiver',
    'Public Servant',
    'Spiritual Seeker',
    'Student',
    'Volunteer',
  ];

  /// Specifics per role - exhaustive starting catalogue.
  static const Map<String, List<String>> specifics = <String, List<String>>{
    'Diplomat':         ['Economist', 'Negotiator', 'Attache', 'Translator', 'Protocol Officer', 'Cultural Envoy'],
    'Scholar':          ['Historian', 'Philosopher', 'Linguist', 'Theologian', 'Critic', 'Archivist'],
    'Citizen':          ['Voter', 'Taxpayer', 'Neighbour', 'Parent', 'Tenant', 'Homeowner'],
    'Entrepreneur':     ['Founder', 'Trader', 'Shopkeeper', 'Investor', 'Freelancer', 'Cooperative Member'],
    'Worker':           ['Engineer', 'Technician', 'Driver', 'Farmer', 'Builder', 'Operator'],
    'Artist':           ['Painter', 'Musician', 'Writer', 'Designer', 'Performer', 'Photographer'],
    'Scientist':        ['Physicist', 'Biologist', 'Data Scientist', 'Chemist', 'Astronomer', 'Ecologist'],
    'Caregiver':        ['Nurse', 'Counsellor', 'Elder Care', 'Childcare', 'Therapist', 'Coach'],
    'Public Servant':   ['Police', 'Teacher', 'Judge', 'Clerk', 'Health Officer', 'Inspector'],
    'Spiritual Seeker': ['Devotee', 'Monastic', 'Pilgrim', 'Healer', 'Yogi', 'Chanter'],
    'Student':          ['Alifiya (Beginner)', 'Undergraduate', 'Postgraduate', 'Doctorate', 'Auditor', 'Apprentice'],
    'Volunteer':        ['Relief Worker', 'Mentor', 'Organiser', 'Translator', 'First Responder', 'Outreach'],
  };

  /// Whether the (role, specific) combo is recognised.
  static bool isValid(String role, String specific) =>
      specifics[role]?.contains(specific) ?? false;

  /// Beginner-friendly tag (alifiyas = absolute beginners).
  static bool isBeginner(String specific) => specific.contains('Alifiya');
}

/// Two-bucket categorisation used in every alifiyas view:
/// - real:    needs in the physical / real-space world
/// - virtual: needs in the digital / web world
class NewAppNeedsBucket {
  final String title;
  final String real;       // essential real-space requisite
  final String virtual;    // essential virtual / web requisite
  const NewAppNeedsBucket({required this.title, required this.real, required this.virtual});
}

/// Common requisites first, then role-shaped specifics.
class NewAppRoleNeeds {
  NewAppRoleNeeds._();

  /// Universal needs every alifiya carries, regardless of role.
  static const List<NewAppNeedsBucket> common = <NewAppNeedsBucket>[
    NewAppNeedsBucket(
      title: 'Identity & Safety',
      real: 'Verified ID, safe shelter, drinking water, basic medical access.',
      virtual: 'Account, recovery email/phone, 2FA, privacy defaults.',
    ),
    NewAppNeedsBucket(
      title: 'Daily Rhythm',
      real: 'Sleep, food, hygiene, a quiet hour to read or pray.',
      virtual: 'Calendar, reminders, focus timer, low-noise notifications.',
    ),
    NewAppNeedsBucket(
      title: 'Language & Literacy',
      real: 'A teacher or peer to practise with, printed primers.',
      virtual: 'Translation, dictionary, captioned video, reading queue.',
    ),
    NewAppNeedsBucket(
      title: 'Money & Records',
      real: 'Wallet, bank or cooperative account, receipts folder.',
      virtual: 'Ledger, invoice template, secure document vault.',
    ),
    NewAppNeedsBucket(
      title: 'Community',
      real: 'Neighbours, mentors, a meeting space.',
      virtual: 'Chat room, discussion thread, shared calendar.',
    ),
  ];

  /// Role-shaped requisites layered on top of `common`.
  static const Map<String, List<NewAppNeedsBucket>> byRole = <String, List<NewAppNeedsBucket>>{
    'Diplomat': [
      NewAppNeedsBucket(title: 'Briefing Pack',  real: 'Country file, protocol guide, dress code.', virtual: 'Cable archive, briefing notes, secure call.'),
      NewAppNeedsBucket(title: 'Negotiation',    real: 'Quiet room, interpreter, witness.',         virtual: 'Minutes template, version diff, signed PDF.'),
    ],
    'Scholar': [
      NewAppNeedsBucket(title: 'Source Discipline', real: 'Library card, primary texts, notebooks.', virtual: 'Citation manager, OCR, full-text search.'),
    ],
    'Student': [
      NewAppNeedsBucket(title: 'First Steps',    real: 'Notebook, pen, a steady seat at home.',      virtual: 'Course feed, flashcards, progress tracker.'),
      NewAppNeedsBucket(title: 'Practice Loop',  real: 'Daily 30-minute drill with a peer.',         virtual: 'Spaced repetition, recorded answers.'),
    ],
    'Entrepreneur': [
      NewAppNeedsBucket(title: 'Trade Toolkit',  real: 'Inventory, packaging, transport.',           virtual: 'Catalogue page, payments, order log.'),
    ],
  };

  /// Returns common + role-specific (role-specific may be empty).
  static List<NewAppNeedsBucket> resolve(String role) {
    final extra = byRole[role] ?? const <NewAppNeedsBucket>[];
    return <NewAppNeedsBucket>[...common, ...extra];
  }
}
