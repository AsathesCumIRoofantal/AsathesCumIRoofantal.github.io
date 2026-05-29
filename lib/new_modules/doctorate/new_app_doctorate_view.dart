import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../new_modules/new_app_role_catalog.dart';
import 'new_app_doctorate_controller.dart';

/// Doctorate — alifiyas (beginner) lane.
/// Common requisites first, then role-shaped specifics.
class NewAppDoctorateView extends GetView<NewAppDoctorateController> {
  const NewAppDoctorateView({super.key});

  static const Color _c1 = Color(0xFF263238);
  static const Color _c2 = Color(0xFF607D8B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07111F),
      body: Obx(
        () => CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _hero(context),
            _roleStrip(),
            _beginnerToggle(),
            _commonHeader(),
            _needsGrid(common: true),
            _specificHeader(),
            _needsGrid(common: false),
            _digitalUx(),
            _footer(),
          ],
        ),
      ),
    );
  }

  // ---------- HERO ----------
  SliverAppBar _hero(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: 260,
      backgroundColor: _c1,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        title: Text(
          controller.title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        background: AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_c1, _c2],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -30,
                top: 30,
                child: Icon(
                  Icons.psychology,
                  size: 220,
                  color: Colors.white.withOpacity(.10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 90, 20, 56),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'ALIFIYAS · BEGINNER LANE',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.85),
                        fontSize: 12,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.tagline,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
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
    );
  }

  // ---------- ROLE / SPECIFIC STRIP ----------
  SliverToBoxAdapter _roleStrip() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final r in NewAppRoleCatalog.roles)
              ChoiceChip(
                label: Text(r),
                selected: controller.role.value == r,
                onSelected: (_) => controller.switchRole(r),
                selectedColor: _c2,
                backgroundColor: Colors.white10,
                labelStyle: TextStyle(
                  color: controller.role.value == r
                      ? Colors.white
                      : Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _beginnerToggle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Specific:',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final s in controller.specificsForRole)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: FilterChip(
                              label: Text(s),
                              selected: controller.specific.value == s,
                              onSelected: (_) => controller.switchSpecific(s),
                              selectedColor: _c1,
                              backgroundColor: Colors.white10,
                              labelStyle: TextStyle(
                                color: controller.specific.value == s
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SwitchListTile.adaptive(
              value: controller.beginnerMode.value,
              onChanged: (v) => controller.beginnerMode.value = v,
              activeColor: _c2,
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Beginner mode (alifiyas)',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text(
                'Show common requisites first, then specifics.',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- SECTION HEADERS ----------
  SliverToBoxAdapter _commonHeader() => _sectionHeader(
    'COMMON · for every alifiya',
    'Foundation requisites — secure these first, before role-shaped depth.',
  );
  SliverToBoxAdapter _specificHeader() => _sectionHeader(
    'SPECIFIC · for ${controller.role.value}',
    'Layered on top of the common foundation.',
  );

  SliverToBoxAdapter _sectionHeader(String t, String s) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.4,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              s,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- NEEDS GRID (Real vs Virtual) ----------
  SliverPadding _needsGrid({required bool common}) {
    final list = common
        ? NewAppRoleNeeds.common
        : (NewAppRoleNeeds.byRole[controller.role.value] ??
              const <NewAppNeedsBucket>[]);
    if (list.isEmpty) {
      return SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
        sliver: SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'No extra specifics curated yet for ${controller.role.value}. '
              'Common requisites above already cover the alifiya stage.',
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ),
      );
    }
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 360,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          mainAxisExtent: 196,
        ),
        delegate: SliverChildBuilderDelegate(
          (ctx, i) => _needsCard(list[i]),
          childCount: list.length,
        ),
      ),
    );
  }

  Widget _needsCard(NewAppNeedsBucket b) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [_c1.withOpacity(.85), _c2.withOpacity(.75)],
        ),
        boxShadow: [
          BoxShadow(
            color: _c2.withOpacity(.25),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            b.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          _line(Icons.public, 'Real-space', b.real),
          const SizedBox(height: 8),
          _line(Icons.cloud_done, 'Virtual / Web', b.virtual),
        ],
      ),
    );
  }

  Widget _line(IconData ic, String label, String body) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(ic, size: 16, color: Colors.white),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              Text(
                body,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------- WEB UX SUGGESTIONS ----------
  SliverToBoxAdapter _digitalUx() {
    final items = const [
      (
        'Onboarding tour',
        'Three-step guided overlay introducing role + specific.',
      ),
      (
        'Daily check-in widget',
        'One-tap log: studied, practised, asked, helped.',
      ),
      (
        'Progress slivers',
        'Sticky section headers with completion bars per requisite.',
      ),
      ('Talk-back recordings', 'Voice answers stored against each question.'),
      ('Mentor request button', 'Routes to Queries module for human help.'),
      (
        'Offline mode banner',
        'Lets alifiyas study without anxiety about data.',
      ),
    ];
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'WEB · UI / UX we can ship',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.4,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            ...items.map(
              (e) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.05),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: _c2.withOpacity(.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.bolt, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.$1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            e.$2,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
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
      ),
    );
  }

  SliverToBoxAdapter _footer() => const SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 40),
      child: Text(
        'Tip — alifiyas progress when common requisites become habits. '
        'Only then layer the role-shaped specifics above.',
        style: TextStyle(color: Colors.white38, fontSize: 12, height: 1.5),
      ),
    ),
  );
}
