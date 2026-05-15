import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'spirituality_lord_shiva_controller.dart';

// ─────────────────────────────────────────────
//  THEME COLORS  (sacred palette)
// ─────────────────────────────────────────────
const _saffron = Color(0xFFFF6F00);
const _deepBlue = Color(0xFF1A237E);
const _indigo = Color(0xFF283593);
const _gold = Color(0xFFFFD600);
const _ashGrey = Color(0xFF90A4AE);
const _teal = Color(0xFF00695C);
const _crimson = Color(0xFFB71C1C);

// ─────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────
class _Mantra {
  final String name;
  final String sanskrit;
  final String transliteration;
  final String meaning;
  final String bestTime;
  final String benefit;
  final Color accent;
  const _Mantra({
    required this.name,
    required this.sanskrit,
    required this.transliteration,
    required this.meaning,
    required this.bestTime,
    required this.benefit,
    required this.accent,
  });
}

class _Symbol {
  final String name;
  final String emoji;
  final String meaning;
  final String philosophy;
  final Color color;
  const _Symbol({
    required this.name,
    required this.emoji,
    required this.meaning,
    required this.philosophy,
    required this.color,
  });
}

class _Festival {
  final String name;
  final String date;
  final String significance;
  final List<String> rituals;
  final Color color;
  final IconData icon;
  const _Festival({
    required this.name,
    required this.date,
    required this.significance,
    required this.rituals,
    required this.color,
    required this.icon,
  });
}

class _Story {
  final String title;
  final String summary;
  final String lesson;
  final String source;
  final Color accent;
  final IconData icon;
  const _Story({
    required this.title,
    required this.summary,
    required this.lesson,
    required this.source,
    required this.accent,
    required this.icon,
  });
}

class _Jyotirlinga {
  final String name;
  final String location;
  final String state;
  final String significance;
  const _Jyotirlinga({
    required this.name,
    required this.location,
    required this.state,
    required this.significance,
  });
}

// ─────────────────────────────────────────────
//  STATIC DATA  (all original content preserved + expanded)
// ─────────────────────────────────────────────
const List<_Mantra> _mantras = [
  _Mantra(
    name: 'Maha Mrityunjaya Mantra',
    sanskrit:
        'ॐ त्र्यम्बकं यजामहे सुगन्धिं पुष्टिवर्धनम्।\nउर्वारुकमिव बन्धनान् मृत्योर्मुक्षीय माऽमृतात्॥',
    transliteration:
        'Om Tryambakam Yajamahe Sugandhim Pushti-vardhanam\nUrvarukamiva Bandhanat Mrityor Mukshiya Maamritat',
    meaning:
        'We worship the three-eyed Lord Shiva who is fragrant and nourishes all beings. May He liberate us from death for the sake of immortality, just as the cucumber is severed from its bondage to the vine.',
    bestTime: 'Dawn (Brahma Muhurta) — 4:00–6:00 AM',
    benefit:
        'Protection from untimely death, healing of illness, liberation from fear, and spiritual awakening.',
    accent: _saffron,
  ),
  _Mantra(
    name: 'Panchakshara Mantra',
    sanskrit: 'ॐ नमः शिवाय',
    transliteration: 'Om Namah Shivaya',
    meaning:
        'I bow to Lord Shiva. The five syllables Na-Ma-Shi-Va-Ya represent the five elements: Earth, Water, Fire, Air, and Space — and the five acts of Shiva: creation, preservation, dissolution, concealment, and grace.',
    bestTime: 'Any time — morning, evening, or during pradosh hours',
    benefit:
        'Purification of the mind, removal of ego, inner peace, and direct connection with the divine consciousness.',
    accent: _deepBlue,
  ),
  _Mantra(
    name: 'Shiva Gayatri Mantra',
    sanskrit: 'ॐ तत्पुरुषाय विद्महे महादेवाय धीमहि।\nतन्नो रुद्रः प्रचोदयात्॥',
    transliteration:
        'Om Tatpurushaya Vidmahe Mahadevaya Dhimahi\nTanno Rudrah Prachodayat',
    meaning:
        'We meditate on the Supreme Being, the Great God. May Rudra illuminate our intellect and inspire us toward the highest truth.',
    bestTime: 'Sunrise and sunset — the sandhya periods',
    benefit:
        'Illumination of the intellect, removal of ignorance, and alignment with divine will.',
    accent: _gold,
  ),
  _Mantra(
    name: 'Rudra Mantra',
    sanskrit: 'ॐ नमो भगवते रुद्राय',
    transliteration: 'Om Namo Bhagavate Rudraya',
    meaning:
        'I bow to the divine Lord Rudra — the roarer, the remover of suffering, the one who dissolves all that is impure.',
    bestTime: 'Monday mornings and during Shravan month',
    benefit:
        'Removal of obstacles, protection from negative energies, and courage in difficult times.',
    accent: _crimson,
  ),
  _Mantra(
    name: 'Shiva Dhyana Mantra',
    sanskrit:
        'करचरणकृतं वाक्कायजं कर्मजं वा\nश्रवणनयनजं वा मानसं वापराधम्।\nविहितमविहितं वा सर्वमेतत्क्षमस्व\nजय जय करुणाब्धे श्रीमहादेव शम्भो॥',
    transliteration: 'Karacharana Kritam Vaa Kaayajam Karmajam Vaa...',
    meaning:
        'O Lord Shiva, please forgive all my sins committed through hands, feet, speech, body, actions, ears, eyes, or mind — whether permitted or forbidden. Victory to you, O ocean of compassion, O great Mahadeva, O Shambho.',
    bestTime: 'Before sleep or at the end of puja',
    benefit:
        'Forgiveness of sins, purification of karma, and surrender to divine grace.',
    accent: _teal,
  ),
  _Mantra(
    name: 'Shiva Tandava Stotram (Opening)',
    sanskrit:
        'जटाटवीगलज्जलप्रवाहपावितस्थले\nगलेऽवलम्ब्य लम्बितां भुजङ्गतुङ्गमालिकाम्।\nडमड्डमड्डमड्डमन्निनादवड्डमर्वयं\nचकार चण्डताण्डवं तनोतु नः शिवः शिवम्॥',
    transliteration: 'Jatatavigalajjala Pravahapavitasthale...',
    meaning:
        'With the sacred Ganga flowing through his matted locks, adorned with a garland of serpents, to the sound of the Damaru — Lord Shiva performs the fierce Tandava dance. May that Shiva bestow auspiciousness upon us.',
    bestTime: 'During Maha Shivaratri or Monday evenings',
    benefit:
        'Awakening of cosmic energy, removal of lethargy, and connection with Shiva\'s dynamic creative power.',
    accent: _indigo,
  ),
];

const List<_Symbol> _symbols = [
  _Symbol(
    name: 'Trishul (Trident)',
    emoji: '🔱',
    meaning:
        'The three prongs represent the three fundamental forces: creation (Brahma), preservation (Vishnu), and dissolution (Shiva). They also symbolise the three states of consciousness: waking, dreaming, and deep sleep.',
    philosophy:
        'The Trishul teaches that all three forces are aspects of one divine reality. Shiva wields it to cut through the three types of suffering: physical, mental, and spiritual.',
    color: _saffron,
  ),
  _Symbol(
    name: 'Damaru (Drum)',
    emoji: '🥁',
    meaning:
        'The hourglass-shaped drum represents the primordial sound of creation — Nada Brahma. The two faces represent the dual nature of existence: matter and consciousness, masculine and feminine.',
    philosophy:
        'When Shiva dances the Tandava, the Damaru\'s sound is the first vibration from which all of creation emerges. It is the cosmic heartbeat — the rhythm underlying all existence.',
    color: _deepBlue,
  ),
  _Symbol(
    name: 'Third Eye',
    emoji: '👁️',
    meaning:
        'The third eye on Shiva\'s forehead represents the eye of wisdom and inner vision. It sees beyond the illusion of duality and perceives the ultimate truth of non-duality.',
    philosophy:
        'When the third eye opens, it burns away ignorance and ego. It is the seat of Ajna chakra — the command centre of higher consciousness. Shiva\'s third eye destroyed Kamadeva (desire) to teach that liberation requires transcending attachment.',
    color: _gold,
  ),
  _Symbol(
    name: 'Crescent Moon',
    emoji: '🌙',
    meaning:
        'The crescent moon on Shiva\'s head represents the mind and its cycles. Just as the moon waxes and wanes, the mind fluctuates — but Shiva holds it in perfect stillness.',
    philosophy:
        'The moon also represents time (Kala). By wearing it, Shiva shows mastery over time itself. The crescent is the fifth day moon (Panchami) — a symbol of eternal renewal and the promise that even in darkness, light returns.',
    color: _ashGrey,
  ),
  _Symbol(
    name: 'Ganga (Sacred River)',
    emoji: '🌊',
    meaning:
        'The river Ganga flows from Shiva\'s matted locks (Jata). When Ganga descended from heaven, her force would have destroyed the earth — Shiva caught her in his hair to break her fall.',
    philosophy:
        'This symbolises Shiva as the one who absorbs and transforms overwhelming forces for the benefit of all beings. His matted hair represents the forest of consciousness that can hold and purify even the most powerful energies.',
    color: _teal,
  ),
  _Symbol(
    name: 'Nandi (Sacred Bull)',
    emoji: '🐂',
    meaning:
        'Nandi, the white bull, is Shiva\'s vehicle (vahana) and the gatekeeper of Kailash. He represents dharma, strength, and unwavering devotion.',
    philosophy:
        'Nandi faces the Shivalinga in every Shiva temple — always in a state of perfect meditation on the divine. He teaches that the highest form of devotion is constant, undistracted attention to the divine presence.',
    color: _crimson,
  ),
  _Symbol(
    name: 'Vibhuti (Sacred Ash)',
    emoji: '⚪',
    meaning:
        'The three horizontal lines of sacred ash on Shiva\'s forehead represent the burning away of the three impurities: anava (ego), karma (action), and maya (illusion).',
    philosophy:
        'Ash is what remains after everything is burned — it is the ultimate truth, the indestructible essence. By wearing ash, Shiva reminds us that the body is temporary but the soul is eternal.',
    color: _ashGrey,
  ),
  _Symbol(
    name: 'Shivalinga',
    emoji: '🪨',
    meaning:
        'The Shivalinga is the most sacred symbol of Shiva — representing the formless, infinite, and eternal nature of the divine. Linga means "mark" or "symbol" — it is the mark of the formless Brahman.',
    philosophy:
        'The oval shape represents the cosmic egg (Brahmanda) from which all creation emerges. The base (Yoni Pitha) represents Shakti — the union of Shiva and Shakti is the source of all existence. It is not a physical symbol but a metaphysical one.',
    color: _indigo,
  ),
];

const List<_Festival> _festivals = [
  _Festival(
    name: 'Maha Shivaratri',
    date: 'Phalguna Krishna Chaturdashi (Feb/Mar)',
    significance:
        'The great night of Shiva — the most sacred night in the Shaivite calendar. It marks the night when Shiva performed the Tandava dance and when the Shivalinga first manifested as an infinite pillar of light.',
    rituals: [
      'All-night vigil (jaagaran) with continuous chanting of Om Namah Shivaya',
      'Abhisheka (ritual bathing) of the Shivalinga with milk, honey, curd, ghee, and water',
      'Offering of Bel (Bilva) leaves — each leaf represents the three eyes of Shiva',
      'Fasting throughout the day and night',
      'Four prahar (3-hour) pujas at midnight, 3 AM, 6 AM, and 9 AM',
      'Reading of Shiva Purana and Shiva Mahimna Stotram',
    ],
    color: _indigo,
    icon: Icons.nightlight_round,
  ),
  _Festival(
    name: 'Shravan Somvar',
    date: 'Every Monday of Shravan month (Jul/Aug)',
    significance:
        'The entire month of Shravan is sacred to Shiva. Mondays (Somvar) are especially auspicious as Soma (the moon) is Shiva\'s ornament. Devotees observe fasts and visit temples throughout the month.',
    rituals: [
      'Fasting on Mondays — consuming only fruits and milk',
      'Visiting Shiva temples and performing Rudrabhisheka',
      'Offering water (Jal Abhisheka) to the Shivalinga',
      'Chanting Shiva Sahasranama (1008 names of Shiva)',
      'Lighting lamps with sesame oil',
      'Reading Shiva Chalisa and Shiva Ashtakam',
    ],
    color: _saffron,
    icon: Icons.calendar_month_outlined,
  ),
  _Festival(
    name: 'Pradosh Vrat',
    date: 'Trayodashi (13th day) of each lunar fortnight',
    significance:
        'Pradosh is the twilight period on the 13th day of each lunar fortnight. It is believed that during this time, Shiva and Parvati are in a joyful mood and grant boons to devotees easily.',
    rituals: [
      'Fasting from sunrise until after the evening puja',
      'Visiting Shiva temple during the pradosh window (1.5 hours before and after sunset)',
      'Circumambulating the Shivalinga 108 times',
      'Offering Bilva leaves, white flowers, and milk',
      'Chanting Pradosh Stotra and Shiva Panchakshara',
    ],
    color: _gold,
    icon: Icons.wb_twilight_outlined,
  ),
  _Festival(
    name: 'Kartik Purnima',
    date: 'Full moon of Kartik month (Oct/Nov)',
    significance:
        'On this day, Shiva destroyed the demon Tripurasura — the three cities of evil — with a single arrow. It is celebrated as Tripurotsava and marks the victory of divine light over darkness.',
    rituals: [
      'Lighting lamps (deepotsava) at temples and on rivers',
      'Taking a holy dip in sacred rivers at dawn',
      'Offering lamps to the Shivalinga',
      'Chanting Tripura Sundari Stotram',
      'Visiting Kashi (Varanasi) for special darshan',
    ],
    color: _teal,
    icon: Icons.brightness_high_outlined,
  ),
];

const List<_Story> _stories = [
  _Story(
    title: 'Shiva Drinks the Halahala Poison',
    summary:
        'During the churning of the cosmic ocean (Samudra Manthan), a deadly poison called Halahala emerged that threatened to destroy all creation. Neither gods nor demons could contain it. Lord Shiva, out of infinite compassion, drank the entire poison to save the universe. Goddess Parvati held his throat to prevent the poison from reaching his stomach, turning his throat blue — earning him the name Neelakantha (the blue-throated one).',
    lesson:
        'True greatness lies in absorbing the suffering of others without being destroyed by it. Shiva\'s act teaches selfless sacrifice, compassion without limit, and the power of inner strength to transform poison into protection.',
    source: 'Bhagavata Purana, Vishnu Purana',
    accent: _teal,
    icon: Icons.water_drop_outlined,
  ),
  _Story(
    title: 'Arjuna and the Kirata (Hunter)',
    summary:
        'During the Mahabharata, Arjuna performed intense penance to obtain the Pashupatastra weapon from Shiva. Shiva appeared disguised as a Kirata (forest hunter) and fought Arjuna. Arjuna\'s arrows had no effect on the hunter. Humbled, Arjuna offered flowers to Shiva — and the flowers appeared on the hunter\'s body. Arjuna realised the hunter was Shiva himself and surrendered. Shiva, pleased, granted him the divine weapon.',
    lesson:
        'Pride in one\'s abilities is the greatest obstacle to divine grace. True strength comes from surrender, not conquest. Shiva tests devotees not to defeat them but to reveal their highest potential.',
    source: 'Mahabharata, Vana Parva',
    accent: _saffron,
    icon: Icons.sports_martial_arts_outlined,
  ),
  _Story(
    title: 'Shiva and Sati — The First Love',
    summary:
        'Sati, daughter of Daksha, loved Shiva deeply and married him against her father\'s wishes. When Daksha organised a grand yajna and insulted Shiva by not inviting him, Sati attended alone and could not bear the humiliation of her husband. She immolated herself in the sacred fire. Shiva, overcome with grief, carried her body across the universe in a cosmic dance of mourning. Vishnu used his Sudarshana Chakra to cut Sati\'s body into 51 pieces — each piece fell to earth and became a Shakti Peetha.',
    lesson:
        'Love that transcends social convention is sacred. Grief, when fully felt, becomes the seed of transformation. The 51 Shakti Peethas remind us that the divine feminine is present everywhere on earth.',
    source: 'Shiva Purana, Devi Bhagavata Purana',
    accent: _crimson,
    icon: Icons.favorite_outline_rounded,
  ),
  _Story(
    title: 'Ganga Descends Through Shiva\'s Locks',
    summary:
        'King Bhagiratha performed intense penance to bring the celestial river Ganga to earth to liberate his ancestors. Ganga agreed but warned that her force would destroy the earth. Bhagiratha prayed to Shiva, who agreed to receive Ganga in his matted locks. Ganga descended with full force — but Shiva\'s locks absorbed her completely. Bhagiratha prayed again, and Shiva released Ganga gently, allowing her to flow to earth as a life-giving river.',
    lesson:
        'The greatest power is not force but the capacity to receive, hold, and transform. Shiva\'s act of catching Ganga shows that true strength is the ability to absorb overwhelming energy and release it in a form that nourishes rather than destroys.',
    source: 'Ramayana (Bala Kanda), Bhagavata Purana',
    accent: _deepBlue,
    icon: Icons.waves_outlined,
  ),
  _Story(
    title: 'Shiva and the Demon Bhasmasura',
    summary:
        'The demon Bhasmasura performed severe penance and obtained a boon from Shiva: whatever he touched with his right hand would turn to ash. Immediately, Bhasmasura tried to touch Shiva himself. Shiva fled across the universe. Vishnu, disguised as the beautiful Mohini, distracted Bhasmasura with a dance. Bhasmasura imitated her moves and placed his own hand on his head — turning himself to ash.',
    lesson:
        'Boons obtained without wisdom become curses. Ego and desire, when unchecked, destroy their own possessor. Shiva\'s willingness to grant even dangerous boons reflects his infinite trust in the self-correcting nature of karma.',
    source: 'Shiva Purana',
    accent: _gold,
    icon: Icons.local_fire_department_outlined,
  ),
];

const List<_Jyotirlinga> _jyotirlingas = [
  _Jyotirlinga(
    name: 'Somnath',
    location: 'Prabhas Patan, Veraval',
    state: 'Gujarat',
    significance:
        'The first and most sacred Jyotirlinga — where Shiva appeared as a pillar of light to settle a dispute between Brahma and Vishnu about supremacy.',
  ),
  _Jyotirlinga(
    name: 'Mallikarjuna',
    location: 'Srisailam',
    state: 'Andhra Pradesh',
    significance:
        'Where Shiva and Parvati reside together as Mallikarjuna and Bhramaramba — the only Jyotirlinga that is also a Shakti Peetha.',
  ),
  _Jyotirlinga(
    name: 'Mahakaleshwar',
    location: 'Ujjain',
    state: 'Madhya Pradesh',
    significance:
        'The only south-facing (Dakshinamukhi) Jyotirlinga — Mahakal is the lord of time and death, worshipped for liberation from the cycle of birth and death.',
  ),
  _Jyotirlinga(
    name: 'Omkareshwar',
    location: 'Mandhata Island',
    state: 'Madhya Pradesh',
    significance:
        'Located on an island shaped like the sacred syllable OM in the Narmada river — representing the primordial sound of creation.',
  ),
  _Jyotirlinga(
    name: 'Kedarnath',
    location: 'Kedarnath',
    state: 'Uttarakhand',
    significance:
        'The highest Jyotirlinga at 3,583m in the Himalayas — where Shiva appeared as a bull to the Pandavas after the Kurukshetra war.',
  ),
  _Jyotirlinga(
    name: 'Bhimashankar',
    location: 'Bhimashankar',
    state: 'Maharashtra',
    significance:
        'Where Shiva destroyed the demon Bhima — the source of the Bhima river, surrounded by the sacred Sahyadri forest.',
  ),
  _Jyotirlinga(
    name: 'Kashi Vishwanath',
    location: 'Varanasi',
    state: 'Uttar Pradesh',
    significance:
        'The most sacred city in Hinduism — Shiva himself is said to whisper the Taraka mantra into the ears of the dying, granting liberation.',
  ),
  _Jyotirlinga(
    name: 'Trimbakeshwar',
    location: 'Trimbak',
    state: 'Maharashtra',
    significance:
        'The source of the sacred Godavari river — the only Jyotirlinga with three faces representing Brahma, Vishnu, and Shiva.',
  ),
  _Jyotirlinga(
    name: 'Vaidyanath',
    location: 'Deoghar',
    state: 'Jharkhand',
    significance:
        'The physician Jyotirlinga — where Shiva healed Ravana after he offered his ten heads. Worshipped for healing and liberation from disease.',
  ),
  _Jyotirlinga(
    name: 'Nageshwar',
    location: 'Dwarka',
    state: 'Gujarat',
    significance:
        'The lord of serpents — where Shiva protected his devotee Supriya from the demon Daruka, demonstrating that devotion is the ultimate protection.',
  ),
  _Jyotirlinga(
    name: 'Rameshwaram',
    location: 'Rameswaram Island',
    state: 'Tamil Nadu',
    significance:
        'Established by Lord Rama before crossing to Lanka — the southernmost Jyotirlinga, where the sacred waters of the ocean meet the divine.',
  ),
  _Jyotirlinga(
    name: 'Grishneshwar',
    location: 'Ellora',
    state: 'Maharashtra',
    significance:
        'The last of the twelve Jyotirlingas — near the magnificent Ellora caves, representing Shiva as the lord of compassion who fulfils all desires.',
  ),
];

// ─────────────────────────────────────────────
//  MAIN VIEW
// ─────────────────────────────────────────────
class SpiritualityLordShivaView
    extends GetView<SpiritualityLordShivaController> {
  const SpiritualityLordShivaView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            _buildSliverAppBar(context, isDark),
          ],
          body: const TabBarView(
            children: [
              _MantrasTab(),
              _SymbolsTab(),
              _FestivalsStoriesTab(),
              _PilgrimageGuideTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, bool isDark) {
    return SliverAppBar(
      expandedHeight: 230,
      floating: false,
      pinned: true,
      backgroundColor: isDark ? const Color(0xFF0D0B1A) : _deepBlue,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: const EdgeInsets.only(left: 16, bottom: 56),
        title: const Text(
          'Spirituality — Lord Shiva',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 1.2,
          ),
        ),
        background: _ShivaHeroBackground(isDark: isDark),
      ),
      bottom: TabBar(
        indicatorColor: _gold,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white54,
        isScrollable: true,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
          letterSpacing: 0.5,
        ),
        tabs: const [
          Tab(icon: Icon(Icons.music_note, size: 16), text: 'Mantras'),
          Tab(icon: Icon(Icons.auto_awesome, size: 16), text: 'Symbols'),
          Tab(
            icon: Icon(Icons.celebration, size: 16),
            text: 'Festivals & Stories',
          ),
          Tab(icon: Icon(Icons.place, size: 16), text: 'Pilgrimage'),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  HERO BACKGROUND
// ─────────────────────────────────────────────
class _ShivaHeroBackground extends StatefulWidget {
  final bool isDark;
  const _ShivaHeroBackground({required this.isDark});
  @override
  State<_ShivaHeroBackground> createState() => _ShivaHeroBackgroundState();
}

class _ShivaHeroBackgroundState extends State<_ShivaHeroBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _glow = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.isDark
              ? [
                  const Color(0xFF1A0533),
                  const Color(0xFF0D1B4A),
                  const Color(0xFF1A0A00),
                ]
              : [_deepBlue, _indigo, const Color(0xFF4A148C)],
        ),
      ),
      child: Stack(
        children: [
          // Mandala-like decorative circles
          ..._buildDecorativeCircles(),
          // Floating sacred symbols
          ..._buildFloatingSymbols(),
          // Main content
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 68),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Animated Om symbol
                AnimatedBuilder(
                  animation: _glow,
                  builder: (_, __) => Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: _saffron.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: _gold.withOpacity(_glow.value),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _saffron.withOpacity(_glow.value * 0.4),
                          blurRadius: 24,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: const Text(
                      'ॐ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ॐ नमः शिवाय',
                        style: TextStyle(
                          color: _gold,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Explore devotional content, sacred texts, and the timeless wisdom of Mahadeva.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.72),
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _HeroBadge(label: '6 Mantras', color: _saffron),
                          const SizedBox(width: 8),
                          _HeroBadge(label: '8 Symbols', color: _gold),
                          const SizedBox(width: 8),
                          _HeroBadge(label: '12 Jyotirlingas', color: _teal),
                        ],
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

  List<Widget> _buildDecorativeCircles() {
    return [
      Positioned(
        top: -50,
        right: -50,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _saffron.withOpacity(0.05),
          ),
        ),
      ),
      Positioned(
        bottom: 20,
        left: -40,
        child: Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _gold.withOpacity(0.05),
          ),
        ),
      ),
      Positioned(
        top: 30,
        right: 80,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.03),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildFloatingSymbols() {
    final rng = math.Random(7);
    const symbols = ['🔱', '🌙', '🪔', '🌸', '⭐'];
    return List.generate(8, (i) {
      final x = rng.nextDouble() * 380;
      final y = rng.nextDouble() * 220;
      final sym = symbols[i % symbols.length];
      return Positioned(
        left: x,
        top: y,
        child: Opacity(
          opacity: rng.nextDouble() * 0.25 + 0.05,
          child: Text(
            sym,
            style: TextStyle(fontSize: rng.nextDouble() * 12 + 8),
          ),
        ),
      );
    });
  }
}

class _HeroBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _HeroBadge({required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 1 — MANTRAS
// ─────────────────────────────────────────────
class _MantrasTab extends StatelessWidget {
  const _MantrasTab();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        // _InfoBanner(
        //   icon: Icons.music_note,
        //   color: _saffron,
        //   text:
        //       'Each mantra includes the Sanskrit text, transliteration, meaning, best time for recitation, and spiritual benefit. Tap any card to expand. Tap the copy icon to copy the mantra.',
        //   isDark: isDark,
        //   onSurface: onSurface,
        // ),
        const SizedBox(height: 16),
        ..._mantras.map(
          (m) => _MantraCard(mantra: m, isDark: isDark, onSurface: onSurface),
        ),
        const SizedBox(height: 16),
        _MantraGuidanceCard(isDark: isDark, onSurface: onSurface),
      ],
    );
  }
}

class _MantraCard extends StatefulWidget {
  final _Mantra mantra;
  final bool isDark;
  final Color onSurface;
  const _MantraCard({
    required this.mantra,
    required this.isDark,
    required this.onSurface,
  });
  @override
  State<_MantraCard> createState() => _MantraCardState();
}

class _MantraCardState extends State<_MantraCard> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final m = widget.mantra;
    final isDark = widget.isDark;
    final onSurface = widget.onSurface;
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1E193B).withOpacity(0.75)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: m.accent.withOpacity(isDark ? 0.35 : 0.22)),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: m.accent.withOpacity(0.13),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.music_note,
                          color: m.accent,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          m.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: onSurface,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: '${m.sanskrit}\n\n${m.transliteration}',
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${m.name} copied'),
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
                          size: 16,
                          color: onSurface.withOpacity(0.35),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        _expanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: onSurface.withOpacity(0.35),
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Sanskrit text
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: m.accent.withOpacity(isDark ? 0.1 : 0.06),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: m.accent.withOpacity(0.2)),
                    ),
                    child: Text(
                      m.sanskrit,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.8,
                        color: onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_expanded) ...[
              Divider(height: 1, color: m.accent.withOpacity(0.15)),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MantraDetail(
                      label: 'TRANSLITERATION',
                      value: m.transliteration,
                      color: m.accent,
                      onSurface: onSurface,
                    ),
                    const SizedBox(height: 12),
                    _MantraDetail(
                      label: 'MEANING',
                      value: m.meaning,
                      color: m.accent,
                      onSurface: onSurface,
                    ),
                    const SizedBox(height: 12),
                    _MantraDetail(
                      label: 'BEST TIME',
                      value: m.bestTime,
                      color: m.accent,
                      onSurface: onSurface,
                    ),
                    const SizedBox(height: 12),
                    _MantraDetail(
                      label: 'SPIRITUAL BENEFIT',
                      value: m.benefit,
                      color: m.accent,
                      onSurface: onSurface,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MantraDetail extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final Color onSurface;
  const _MantraDetail({
    required this.label,
    required this.value,
    required this.color,
    required this.onSurface,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            letterSpacing: 1.5,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: onSurface.withOpacity(0.78),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _MantraGuidanceCard extends StatelessWidget {
  final bool isDark;
  final Color onSurface;
  const _MantraGuidanceCard({required this.isDark, required this.onSurface});
  @override
  Widget build(BuildContext context) {
    const tips = [
      (
        'Sit facing East or North',
        'The direction of sunrise and the divine north are considered most auspicious for mantra recitation.',
      ),
      (
        'Use a Rudraksha mala',
        'A 108-bead Rudraksha mala helps maintain count and focus. Complete 108 repetitions for one mala.',
      ),
      (
        'Maintain a clean body and mind',
        'Bathe before recitation. Approach the mantra with a calm, focused, and reverent mind.',
      ),
      (
        'Consistency over intensity',
        'Daily recitation of even 11 repetitions is more powerful than occasional marathon sessions.',
      ),
      (
        'Understand the meaning',
        'Reciting with understanding of the meaning multiplies the mantra\'s effect many times over.',
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _saffron.withOpacity(isDark ? 0.1 : 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _saffron.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.tips_and_updates_outlined,
                color: _saffron,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Mantra Recitation Guidance',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...tips.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('🔱 ', style: TextStyle(fontSize: 12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.$1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                            color: onSurface,
                          ),
                        ),
                        Text(
                          t.$2,
                          style: TextStyle(
                            fontSize: 12,
                            color: onSurface.withOpacity(0.65),
                            height: 1.4,
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

// ─────────────────────────────────────────────
//  TAB 2 — SYMBOLS
// ─────────────────────────────────────────────
class _SymbolsTab extends StatelessWidget {
  const _SymbolsTab();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        _ShivaIntro(
          icon: Icons.auto_awesome,
          color: _gold,
          title: 'Iconography of the Mahadeva',
          body:
              'Every symbol on Shiva\'s person is a teaching. Each emblem '
              'encodes a metaphysical truth — together they form a complete '
              'philosophy of consciousness, energy, and liberation.',
          isDark: isDark,
          onSurface: onSurface,
        ),
        const SizedBox(height: 16),
        ..._symbols.map(
          (s) => _SymbolCard(symbol: s, isDark: isDark, onSurface: onSurface),
        ),
        const SizedBox(height: 8),
        _ShivaIntro(
          icon: Icons.menu_book_outlined,
          color: _indigo,
          title: 'Why iconography matters',
          body:
              'In the Shaivite tradition, contemplating a symbol (dhyana) is '
              'considered as potent as reciting a mantra. The symbol is a '
              'doorway — the philosophy behind it is the room you enter.',
          isDark: isDark,
          onSurface: onSurface,
        ),
      ],
    );
  }
}

class _SymbolCard extends StatelessWidget {
  final _Symbol symbol;
  final bool isDark;
  final Color onSurface;
  const _SymbolCard({
    required this.symbol,
    required this.isDark,
    required this.onSurface,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E193B).withOpacity(0.75)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: symbol.color.withOpacity(isDark ? 0.35 : 0.22)),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: symbol.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: symbol.color.withOpacity(0.3)),
            ),
            alignment: Alignment.center,
            child: Text(symbol.emoji, style: const TextStyle(fontSize: 26)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbol.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.5,
                    color: onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                _MantraDetail(
                  label: 'MEANING',
                  value: symbol.meaning,
                  color: symbol.color,
                  onSurface: onSurface,
                ),
                const SizedBox(height: 10),
                _MantraDetail(
                  label: 'PHILOSOPHY',
                  value: symbol.philosophy,
                  color: symbol.color,
                  onSurface: onSurface,
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
//  TAB 3 — FESTIVALS & STORIES
// ─────────────────────────────────────────────
class _FestivalsStoriesTab extends StatelessWidget {
  const _FestivalsStoriesTab();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        _SectionTitle(text: 'Sacred Festivals', color: _saffron, onSurface: onSurface),
        const SizedBox(height: 10),
        ..._festivals.map(
          (f) => _FestivalCard(festival: f, isDark: isDark, onSurface: onSurface),
        ),
        const SizedBox(height: 18),
        _SectionTitle(text: 'Eternal Stories', color: _crimson, onSurface: onSurface),
        const SizedBox(height: 10),
        ..._stories.map(
          (s) => _StoryCard(story: s, isDark: isDark, onSurface: onSurface),
        ),
      ],
    );
  }
}

class _FestivalCard extends StatelessWidget {
  final _Festival festival;
  final bool isDark;
  final Color onSurface;
  const _FestivalCard({
    required this.festival,
    required this.isDark,
    required this.onSurface,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E193B).withOpacity(0.75)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: festival.color.withOpacity(isDark ? 0.35 : 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  festival.color.withOpacity(0.18),
                  festival.color.withOpacity(0.04),
                ],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: festival.color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(festival.icon, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        festival.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14.5,
                          color: onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        festival.date,
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 0.5,
                          color: festival.color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  festival.significance,
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.55,
                    color: onSurface.withOpacity(0.78),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'RITUALS',
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w800,
                    color: festival.color,
                  ),
                ),
                const SizedBox(height: 6),
                ...festival.rituals.map(
                  (r) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6, right: 8),
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: festival.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            r,
                            style: TextStyle(
                              fontSize: 12.5,
                              height: 1.45,
                              color: onSurface.withOpacity(0.82),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class _StoryCard extends StatefulWidget {
  final _Story story;
  final bool isDark;
  final Color onSurface;
  const _StoryCard({
    required this.story,
    required this.isDark,
    required this.onSurface,
  });
  @override
  State<_StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<_StoryCard> {
  bool _open = false;
  @override
  Widget build(BuildContext context) {
    final s = widget.story;
    return GestureDetector(
      onTap: () => setState(() => _open = !_open),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: widget.isDark
              ? const Color(0xFF1E193B).withOpacity(0.75)
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: s.accent.withOpacity(_open ? 0.5 : 0.22)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: s.accent.withOpacity(0.13),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(s.icon, color: s.accent, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    s.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13.5,
                      color: widget.onSurface,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: _open ? 0.5 : 0,
                  duration: const Duration(milliseconds: 220),
                  child: Icon(Icons.keyboard_arrow_down_rounded,
                      color: s.accent),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              s.summary,
              maxLines: _open ? null : 3,
              overflow: _open ? TextOverflow.visible : TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.55,
                color: widget.onSurface.withOpacity(0.78),
              ),
            ),
            if (_open) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: s.accent.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: s.accent.withOpacity(0.22)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LESSON',
                      style: TextStyle(
                        fontSize: 9,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w800,
                        color: s.accent,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      s.lesson,
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.55,
                        color: widget.onSurface.withOpacity(0.82),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.menu_book_outlined,
                      size: 12, color: widget.onSurface.withOpacity(0.5)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Source · ${s.source}',
                      style: TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: widget.onSurface.withOpacity(0.55),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 4 — PILGRIMAGE (12 Jyotirlingas)
// ─────────────────────────────────────────────
class _PilgrimageGuideTab extends StatelessWidget {
  const _PilgrimageGuideTab();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        _ShivaIntro(
          icon: Icons.place,
          color: _saffron,
          title: 'The Twelve Jyotirlingas',
          body:
              'Across the sacred geography of Bharat, twelve self-manifested '
              'Jyotirlingas mark the points where Lord Shiva revealed himself '
              'as an infinite pillar of light. A pilgrimage to all twelve is '
              'considered the highest Shaivite yatra.',
          isDark: isDark,
          onSurface: onSurface,
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < _jyotirlingas.length; i++)
          _JyotirlingaTile(
            index: i + 1,
            item: _jyotirlingas[i],
            isDark: isDark,
            onSurface: onSurface,
          ),
        const SizedBox(height: 14),
        _ShivaIntro(
          icon: Icons.tips_and_updates_outlined,
          color: _teal,
          title: 'Pilgrimage Etiquette',
          body:
              'Approach each shrine with humility — bathe before darshan, '
              'wear modest clothing, observe silence inside the garbhagriha, '
              'and never turn your back to the Shivalinga while leaving. '
              'Offer Bilva leaves, water and unbroken devotion.',
          isDark: isDark,
          onSurface: onSurface,
        ),
      ],
    );
  }
}

class _JyotirlingaTile extends StatelessWidget {
  final int index;
  final _Jyotirlinga item;
  final bool isDark;
  final Color onSurface;
  const _JyotirlingaTile({
    required this.index,
    required this.item,
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
            ? const Color(0xFF1E193B).withOpacity(0.75)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _gold.withOpacity(isDark ? 0.3 : 0.22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_saffron, _gold],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              index.toString().padLeft(2, '0'),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 12, color: _saffron),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${item.location} · ${item.state}',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: onSurface.withOpacity(0.6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.significance,
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.5,
                    color: onSurface.withOpacity(0.78),
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
//  SHARED HELPERS
// ─────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String text;
  final Color color;
  final Color onSurface;
  const _SectionTitle({
    required this.text,
    required this.color,
    required this.onSurface,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: onSurface,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

class _ShivaIntro extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final bool isDark;
  final Color onSurface;
  const _ShivaIntro({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    required this.isDark,
    required this.onSurface,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.1 : 0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13.5,
                    color: onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.55,
              color: onSurface.withOpacity(0.78),
            ),
          ),
        ],
      ),
    );
  }
}
