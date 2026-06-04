// ============================================================
//  EngageEntryView  v3
//  GetX · Material 3 · Dark/Light · Truly Responsive
//  No ScreenUtil dependency for sizing — pure MediaQuery + clamp
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'engage_entry_controller.dart';

// ════════════════════════════════════════════════════════════
//  _S – Sizing System  (MediaQuery-based, hard-clamped)
//  Never relies on ScreenUtil being initialised.
//  Pass [context] once per build method, read all sizes from it.
// ════════════════════════════════════════════════════════════
class _S {
  final double sw; // screen width
  final double sh; // screen height

  _S(BuildContext ctx)
    : sw = MediaQuery.sizeOf(ctx).width,
      sh = MediaQuery.sizeOf(ctx).height;

  // ── Is-breakpoint helpers ────────────────────────────────
  bool get isMobile => sw < 600;
  bool get isTablet => sw >= 600 && sw < 1200;
  bool get isDesktop => sw >= 1200;

  // ── Font sizes (clamp ensures minimum readable size) ─────
  double get f9 => (sw * 0.024).clamp(10.0, 12.0);
  double get f10 => (sw * 0.027).clamp(11.0, 13.0);
  double get f11 => (sw * 0.029).clamp(12.0, 14.0);
  double get f12 => (sw * 0.032).clamp(13.0, 15.0);
  double get f13 => (sw * 0.035).clamp(14.0, 16.0);
  double get f14 => (sw * 0.038).clamp(14.0, 17.0);
  double get f15 => (sw * 0.040).clamp(15.0, 18.0);
  double get f16 => (sw * 0.043).clamp(16.0, 20.0);
  double get f17 => (sw * 0.046).clamp(16.0, 22.0);
  double get f18 => (sw * 0.048).clamp(17.0, 24.0);
  double get f20 => (sw * 0.053).clamp(18.0, 26.0);
  double get f22 => (sw * 0.058).clamp(20.0, 28.0);

  // ── Spacing ───────────────────────────────────────────────
  double get sp2 => 2.0;
  double get sp4 => 4.0;
  double get sp5 => 5.0;
  double get sp6 => 6.0;
  double get sp8 => 8.0;
  double get sp9 => 9.0;
  double get sp10 => 10.0;
  double get sp12 => 12.0;
  double get sp14 => 14.0;
  double get sp16 => isMobile ? 16.0 : (isTablet ? 20.0 : 24.0);
  double get sp20 => isMobile ? 18.0 : 24.0;
  double get sp24 => isMobile ? 20.0 : 28.0;
  double get sp28 => isMobile ? 24.0 : 32.0;
  double get sp40 => isMobile ? 32.0 : 48.0;

  // ── Icon sizes ────────────────────────────────────────────
  double get ic11 => isMobile ? 14.0 : 13.0;
  double get ic12 => isMobile ? 15.0 : 14.0;
  double get ic13 => isMobile ? 16.0 : 15.0;
  double get ic14 => isMobile ? 17.0 : 16.0;
  double get ic16 => isMobile ? 18.0 : 18.0;
  double get ic18 => isMobile ? 20.0 : 20.0;
  double get ic20 => isMobile ? 22.0 : 22.0;
  double get ic22 => isMobile ? 24.0 : 24.0;
  double get ic28 => isMobile ? 28.0 : 30.0;
  double get ic56 => isMobile ? 52.0 : 60.0;

  // ── Avatar radii ──────────────────────────────────────────
  double get av10 => isMobile ? 12.0 : 11.0;
  double get av11 => isMobile ? 13.0 : 12.0;
  double get av13 => isMobile ? 15.0 : 14.0;
  double get av18 => isMobile ? 20.0 : 20.0;

  // ── Border radii (fixed) ──────────────────────────────────
  double get r6 => 6.0;
  double get r8 => 8.0;
  double get r9 => 9.0;
  double get r10 => 10.0;
  double get r12 => 12.0;
  double get r14 => 14.0;
  double get r16 => 16.0;
  double get r18 => 18.0;
  double get r20 => 20.0;
  double get r30 => 30.0;

  // ── Card / container padding ──────────────────────────────
  EdgeInsets get cardPad => EdgeInsets.all(isMobile ? 14.0 : 16.0);
  EdgeInsets get fieldPad => EdgeInsets.symmetric(
    horizontal: isMobile ? 14.0 : 16.0,
    vertical: isMobile ? 14.0 : 13.0,
  );

  // ── Horizontal page padding ───────────────────────────────
  double get hPad => isMobile ? 16.0 : (isTablet ? 24.0 : 0.0);

  // ── Form max width ────────────────────────────────────────
  double get formMax =>
      isDesktop ? 720.0 : (isTablet ? sw * 0.92 : double.infinity);

  // ── App-bar expanded height ───────────────────────────────
  double get appBarH => isMobile ? 100.0 : 110.0;

  // ── Section-title chip: items per row ────────────────────
  int get sectionCols => isDesktop ? 3 : (isTablet ? 3 : 2);

  // ── Assignee tile columns ─────────────────────────────────
  int get assigneeCols => isMobile ? 1 : 2;
}

// ════════════════════════════════════════════════════════════
//  _T – Theme Tokens  (context-aware dark / light)
// ════════════════════════════════════════════════════════════
class _T {
  final bool isDark;
  const _T._(this.isDark);
  factory _T(BuildContext ctx) =>
      _T._(Theme.of(ctx).brightness == Brightness.dark);

  Color get bg => isDark ? const Color(0xFF0C0E1A) : const Color(0xFFF5F7FF);
  Color get surface =>
      isDark ? const Color(0xFF141728) : const Color(0xFFFFFFFF);
  Color get card => isDark ? const Color(0xFF1B1F35) : const Color(0xFFFFFFFF);
  Color get cardAlt =>
      isDark ? const Color(0xFF141728) : const Color(0xFFF0F4FF);
  Color get border =>
      isDark ? const Color(0xFF252A45) : const Color(0xFFDDE3F4);
  Color get divider =>
      isDark ? const Color(0xFF1E2438) : const Color(0xFFEEF2FF);
  Color get primary => const Color(0xFF6366F1);
  Color get accent =>
      isDark ? const Color(0xFF818CF8) : const Color(0xFF4F46E5);
  Color get primarySoft => primary.withOpacity(isDark ? 0.18 : 0.10);
  Color get text1 => isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);
  Color get text2 => isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569);
  Color get text3 => isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8);

  List<BoxShadow> get cardShadow => isDark
      ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.30),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ]
      : [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ];
}

// ════════════════════════════════════════════════════════════
//  MAIN VIEW
// ════════════════════════════════════════════════════════════
class EngageEntryView extends StatelessWidget {
  const EngageEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(EngageEntryController());
    final t = _T(context);
    final s = _S(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: t.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: t.bg,
        body: SafeArea(
          child: s.isDesktop
              ? _DesktopLayout(ctrl: ctrl, t: t)
              : _MobileTabletLayout(ctrl: ctrl, t: t),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  DESKTOP LAYOUT  (≥ 1200) — split pane
// ════════════════════════════════════════════════════════════
class _DesktopLayout extends StatelessWidget {
  final EngageEntryController ctrl;
  final _T t;
  const _DesktopLayout({required this.ctrl, required this.t});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _AppBarSliver(ctrl: ctrl, t: t),
              _FormSliver(ctrl: ctrl, t: t),
              const SliverToBoxAdapter(child: SizedBox(height: 48)),
            ],
          ),
        ),
        VerticalDivider(width: 1, color: t.border),
        Expanded(
          flex: 5,
          child: _EntriesColumn(ctrl: ctrl, t: t),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════
//  MOBILE / TABLET LAYOUT  (< 1200) — single scroll
// ════════════════════════════════════════════════════════════
class _MobileTabletLayout extends StatelessWidget {
  final EngageEntryController ctrl;
  final _T t;
  const _MobileTabletLayout({required this.ctrl, required this.t});

  @override
  Widget build(BuildContext context) {
    final s = _S(context);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _AppBarSliver(ctrl: ctrl, t: t),
        _FormSliver(ctrl: ctrl, t: t),
        SliverToBoxAdapter(
          child: Obx(
            () => ctrl.entries.isEmpty
                ? const SizedBox.shrink()
                : _SectionDivider(count: ctrl.entries.length, t: t, s: s),
          ),
        ),
        Obx(
          () => SliverList.builder(
            itemCount: ctrl.entries.length,
            itemBuilder: (_, i) => Padding(
              padding: EdgeInsets.symmetric(horizontal: s.hPad, vertical: 6),
              child: _EntryCard(entry: ctrl.entries[i], ctrl: ctrl, t: t, s: s),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 48)),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════
//  DESKTOP ENTRIES COLUMN
// ════════════════════════════════════════════════════════════
class _EntriesColumn extends StatelessWidget {
  final EngageEntryController ctrl;
  final _T t;
  const _EntriesColumn({required this.ctrl, required this.t});

  @override
  Widget build(BuildContext context) {
    final s = _S(context);
    return Obx(() {
      if (ctrl.entries.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.inbox_rounded, size: s.ic56, color: t.text3),
              const SizedBox(height: 12),
              Text(
                'No entries yet',
                style: TextStyle(color: t.text3, fontSize: s.f15),
              ),
              const SizedBox(height: 6),
              Text(
                'Submit the form to see entries here',
                style: TextStyle(
                  color: t.text3.withOpacity(0.6),
                  fontSize: s.f12,
                ),
              ),
            ],
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              children: [
                Icon(Icons.inventory_2_rounded, color: t.accent, size: s.ic18),
                const SizedBox(width: 8),
                Text(
                  'Entries',
                  style: TextStyle(
                    color: t.text1,
                    fontSize: s.f18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: t.primarySoft,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${ctrl.entries.length}',
                    style: TextStyle(
                      color: t.accent,
                      fontSize: s.f12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 48),
              physics: const BouncingScrollPhysics(),
              itemCount: ctrl.entries.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _EntryCard(
                  entry: ctrl.entries[i],
                  ctrl: ctrl,
                  t: t,
                  s: s,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

// ════════════════════════════════════════════════════════════
//  APP BAR SLIVER
// ════════════════════════════════════════════════════════════
class _AppBarSliver extends StatelessWidget {
  final EngageEntryController ctrl;
  final _T t;
  const _AppBarSliver({required this.ctrl, required this.t});

  @override
  Widget build(BuildContext context) {
    final s = _S(context);
    return SliverAppBar(
      pinned: true,
      floating: false,
      snap: false,
      backgroundColor: t.bg,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      expandedHeight: s.appBarH,
      collapsedHeight: 64,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          color: t.bg,
          padding: EdgeInsets.fromLTRB(
            s.hPad == 0 ? 20 : s.hPad,
            10,
            s.hPad == 0 ? 20 : s.hPad,
            0,
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              // Logo
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(s.r14),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withOpacity(0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add_task_rounded,
                  color: Colors.white,
                  size: s.ic22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Entry',
                      style: TextStyle(
                        color: t.text1,
                        fontSize: s.f20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'Capture · Assign · Track',
                      style: TextStyle(color: t.text2, fontSize: s.f12),
                    ),
                  ],
                ),
              ),
              // Entry count badge
              Obx(
                () => ctrl.entries.isEmpty
                    ? const SizedBox.shrink()
                    : Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: t.primarySoft,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: t.primary.withOpacity(0.25),
                          ),
                        ),
                        child: Text(
                          '${ctrl.entries.length}',
                          style: TextStyle(
                            color: t.accent,
                            fontSize: s.f12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: 10),
              // Theme toggle
              GestureDetector(
                onTap: () => Get.changeThemeMode(
                  t.isDark ? ThemeMode.light : ThemeMode.dark,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: t.card,
                    borderRadius: BorderRadius.circular(s.r12),
                    border: Border.all(color: t.border),
                    boxShadow: t.cardShadow,
                  ),
                  child: Icon(
                    t.isDark
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    color: t.isDark
                        ? const Color(0xFFFBBF24)
                        : const Color(0xFF6366F1),
                    size: s.ic18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  FORM SLIVER
// ════════════════════════════════════════════════════════════
class _FormSliver extends StatelessWidget {
  final EngageEntryController ctrl;
  final _T t;
  const _FormSliver({required this.ctrl, required this.t});

  @override
  Widget build(BuildContext context) {
    final s = _S(context);
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: s.formMax),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: s.hPad),
            child: Form(
              key: ctrl.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: s.sp10),

                  // ① Section Title
                  _SectionTitlePicker(ctrl: ctrl, t: t, s: s),
                  SizedBox(height: s.sp16),

                  // ② Section Tab
                  _SectionTabRow(ctrl: ctrl, t: t, s: s),
                  SizedBox(height: s.sp20),

                  // ③④ Context Brief + Title
                  if (!s.isMobile)
                    _Row2(
                      left: _FormCard(
                        label: 'Context Brief',
                        icon: Icons.short_text_rounded,
                        iconColor: const Color(0xFF22D3EE),
                        t: t,
                        s: s,
                        child: _AIRField(
                          ctrl: ctrl.contextBriefCtrl,
                          t: t,
                          s: s,
                          hint: 'Brief context…',
                          maxLines: 2,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Context brief required'
                              : null,
                        ),
                      ),
                      right: _FormCard(
                        label: 'Title',
                        icon: Icons.title_rounded,
                        iconColor: const Color(0xFF6366F1),
                        t: t,
                        s: s,
                        child: _AIRField(
                          ctrl: ctrl.titleCtrl,
                          t: t,
                          s: s,
                          hint: 'Clear, concise title…',
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Title required'
                              : null,
                        ),
                      ),
                    )
                  else ...[
                    _FormCard(
                      label: 'Context Brief',
                      icon: Icons.short_text_rounded,
                      iconColor: const Color(0xFF22D3EE),
                      t: t,
                      s: s,
                      child: _AIRField(
                        ctrl: ctrl.contextBriefCtrl,
                        t: t,
                        s: s,
                        hint: 'Provide a brief context of this entry…',
                        maxLines: 2,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Context brief required'
                            : null,
                      ),
                    ),
                    SizedBox(height: s.sp12),
                    _FormCard(
                      label: 'Title',
                      icon: Icons.title_rounded,
                      iconColor: const Color(0xFF6366F1),
                      t: t,
                      s: s,
                      child: _AIRField(
                        ctrl: ctrl.titleCtrl,
                        t: t,
                        s: s,
                        hint: 'Enter a clear, concise title…',
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Title required'
                            : null,
                      ),
                    ),
                  ],
                  SizedBox(height: s.sp12),

                  // ⑤⑥ Description + Remark
                  if (!s.isMobile)
                    _Row2(
                      leftFlex: 3,
                      rightFlex: 2,
                      left: _FormCard(
                        label: 'Description',
                        icon: Icons.notes_rounded,
                        iconColor: const Color(0xFF8B5CF6),
                        t: t,
                        s: s,
                        child: _AIRField(
                          ctrl: ctrl.descriptionCtrl,
                          t: t,
                          s: s,
                          hint: 'Describe in detail…',
                          maxLines: 5,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Description required'
                              : null,
                        ),
                      ),
                      right: _FormCard(
                        label: 'Remark',
                        icon: Icons.comment_rounded,
                        iconColor: const Color(0xFFF59E0B),
                        t: t,
                        s: s,
                        child: _AIRField(
                          ctrl: ctrl.remarkCtrl,
                          t: t,
                          s: s,
                          hint: 'Additional remarks…',
                          maxLines: 5,
                        ),
                      ),
                    )
                  else ...[
                    _FormCard(
                      label: 'Description',
                      icon: Icons.notes_rounded,
                      iconColor: const Color(0xFF8B5CF6),
                      t: t,
                      s: s,
                      child: _AIRField(
                        ctrl: ctrl.descriptionCtrl,
                        t: t,
                        s: s,
                        hint: 'Describe in detail what this entry is about…',
                        maxLines: 4,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Description required'
                            : null,
                      ),
                    ),
                    SizedBox(height: s.sp12),
                    _FormCard(
                      label: 'Remark',
                      icon: Icons.comment_rounded,
                      iconColor: const Color(0xFFF59E0B),
                      t: t,
                      s: s,
                      child: _AIRField(
                        ctrl: ctrl.remarkCtrl,
                        t: t,
                        s: s,
                        hint: 'Any additional remarks or notes…',
                        maxLines: 3,
                      ),
                    ),
                  ],
                  SizedBox(height: s.sp16),

                  // ⑦ Criteria chips
                  _CriteriaPicker(ctrl: ctrl, t: t, s: s),
                  SizedBox(height: s.sp16),

                  // ⑧⑨ Attachments + Assignees
                  if (s.isDesktop)
                    _Row2(
                      left: _AttachmentPicker(ctrl: ctrl, t: t, s: s),
                      right: _AssigneePicker(ctrl: ctrl, t: t, s: s),
                    )
                  else ...[
                    _AttachmentPicker(ctrl: ctrl, t: t, s: s),
                    SizedBox(height: s.sp16),
                    _AssigneePicker(ctrl: ctrl, t: t, s: s),
                  ],
                  SizedBox(height: s.sp24),

                  // ⑩ Submit
                  _SubmitButton(ctrl: ctrl, t: t, s: s),
                  SizedBox(height: s.sp28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  SECTION TITLE PICKER
// ════════════════════════════════════════════════════════════
class _SectionTitlePicker extends StatelessWidget {
  final EngageEntryController ctrl;
  final _T t;
  final _S s;
  const _SectionTitlePicker({
    required this.ctrl,
    required this.t,
    required this.s,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _FieldLabel(
        'Section Title',
        Icons.category_rounded,
        const Color(0xFF6366F1),
        t,
        s,
      ),
      SizedBox(height: s.sp10),
      LayoutBuilder(
        builder: (ctx, box) {
          final cols = s.sectionCols;
          final gap = 8.0;
          final chipW = (box.maxWidth - gap * (cols - 1)) / cols;
          return Obx(
            () => Wrap(
              spacing: gap,
              runSpacing: 8,
              children: EntrySection.values.map((sec) {
                final cfg = EngageEntryController.sectionConfig[sec]!;
                final sel = ctrl.selectedSection.value == sec;
                return GestureDetector(
                  onTap: () => ctrl.selectSection(sec),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: chipW,
                    padding: EdgeInsets.symmetric(
                      horizontal: s.sp10,
                      vertical: s.sp10,
                    ),
                    decoration: BoxDecoration(
                      color: sel
                          ? cfg.color.withOpacity(t.isDark ? 0.18 : 0.10)
                          : t.card,
                      borderRadius: BorderRadius.circular(s.r14),
                      border: Border.all(
                        color: sel ? cfg.color : t.border,
                        width: sel ? 1.5 : 1,
                      ),
                      boxShadow: sel
                          ? [
                              BoxShadow(
                                color: cfg.color.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : t.cardShadow,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(s.sp6),
                          decoration: BoxDecoration(
                            color: cfg.color.withOpacity(sel ? 0.22 : 0.12),
                            borderRadius: BorderRadius.circular(s.r8),
                          ),
                          child: Icon(cfg.icon, color: cfg.color, size: s.ic16),
                        ),
                        SizedBox(width: s.sp8),
                        Expanded(
                          child: Text(
                            cfg.label,
                            style: TextStyle(
                              color: sel ? cfg.color : t.text2,
                              fontSize: s.f12,
                              fontWeight: sel
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                        if (sel)
                          Icon(
                            Icons.check_circle_rounded,
                            color: cfg.color,
                            size: s.ic13,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    ],
  );
}

// ════════════════════════════════════════════════════════════
//  SECTION TAB ROW
// ════════════════════════════════════════════════════════════
class _SectionTabRow extends StatelessWidget {
  final EngageEntryController ctrl;
  final _T t;
  final _S s;
  const _SectionTabRow({required this.ctrl, required this.t, required this.s});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _FieldLabel(
        'Section Tab',
        Icons.tab_rounded,
        const Color(0xFF22D3EE),
        t,
        s,
      ),
      SizedBox(height: s.sp10),
      Container(
        decoration: BoxDecoration(
          color: t.card,
          borderRadius: BorderRadius.circular(s.r16),
          border: Border.all(color: t.border),
          boxShadow: t.cardShadow,
        ),
        padding: const EdgeInsets.all(4),
        child: Obx(
          () => Row(
            children: SectionTab.values.map((tab) {
              final cfg = EngageEntryController.tabConfig[tab]!;
              final sel = ctrl.selectedTab.value == tab;
              return Expanded(
                child: GestureDetector(
                  onTap: () => ctrl.selectTab(tab),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    padding: EdgeInsets.symmetric(vertical: s.sp10),
                    decoration: BoxDecoration(
                      gradient: sel
                          ? const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(s.r12),
                      boxShadow: sel
                          ? [
                              BoxShadow(
                                color: const Color(
                                  0xFF6366F1,
                                ).withOpacity(0.35),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          cfg.icon,
                          color: sel ? Colors.white : t.text3,
                          size: s.ic16,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cfg.label,
                          style: TextStyle(
                            color: sel ? Colors.white : t.text2,
                            fontSize: s.f10,
                            fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ],
  );
}

// ════════════════════════════════════════════════════════════
//  CRITERIA PICKER
// ════════════════════════════════════════════════════════════
class _CriteriaPicker extends StatelessWidget {
  final EngageEntryController ctrl;
  final _T t;
  final _S s;
  const _CriteriaPicker({required this.ctrl, required this.t, required this.s});

  @override
  Widget build(BuildContext context) => _SectionBox(
    t: t,
    s: s,
    header: Row(
      children: [
        _IconBadge(Icons.local_offer_rounded, const Color(0xFFF59E0B), s),
        SizedBox(width: s.sp9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Catch Criteria',
                style: TextStyle(
                  color: t.text1,
                  fontSize: s.f14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Tag this entry — select all that apply',
                style: TextStyle(color: t.text3, fontSize: s.f11),
              ),
            ],
          ),
        ),
        Obx(
          () => ctrl.selectedCriteria.isEmpty
              ? const SizedBox.shrink()
              : AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: t.primarySoft,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${ctrl.selectedCriteria.length} selected',
                    style: TextStyle(
                      color: t.accent,
                      fontSize: s.f10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
        ),
      ],
    ),
    body: Obx(
      () => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: CatchCriteria.values.map((c) {
          final cfg = EngageEntryController.criteriaConfig[c]!;
          final sel = ctrl.selectedCriteria.contains(c);
          return GestureDetector(
            onTap: () => ctrl.toggleCriteria(c),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.symmetric(
                horizontal: s.sp12,
                vertical: s.sp8,
              ),
              decoration: BoxDecoration(
                color: sel
                    ? cfg.color.withOpacity(t.isDark ? 0.15 : 0.10)
                    : t.cardAlt,
                borderRadius: BorderRadius.circular(s.r30),
                border: Border.all(
                  color: sel ? cfg.color : t.border,
                  width: sel ? 1.5 : 1,
                ),
                boxShadow: sel
                    ? [
                        BoxShadow(
                          color: cfg.color.withOpacity(0.18),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    sel ? Icons.check_circle_rounded : cfg.icon,
                    color: sel ? cfg.color : t.text3,
                    size: s.ic14,
                  ),
                  SizedBox(width: s.sp5),
                  Text(
                    cfg.label,
                    style: TextStyle(
                      color: sel ? cfg.color : t.text2,
                      fontSize: s.f12,
                      fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

// ════════════════════════════════════════════════════════════
//  ATTACHMENT PICKER
// ════════════════════════════════════════════════════════════
class _AttachmentPicker extends StatelessWidget {
  final EngageEntryController ctrl;
  final _T t;
  final _S s;
  const _AttachmentPicker({
    required this.ctrl,
    required this.t,
    required this.s,
  });

  @override
  Widget build(BuildContext context) => _SectionBox(
    t: t,
    s: s,
    header: Row(
      children: [
        _IconBadge(Icons.attach_file_rounded, const Color(0xFF3B82F6), s),
        SizedBox(width: s.sp9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Attachments',
                style: TextStyle(
                  color: t.text1,
                  fontSize: s.f14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Obx(
                () => Text(
                  '${ctrl.attachments.length} file(s)',
                  style: TextStyle(color: t.text3, fontSize: s.f11),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: ctrl.pickFiles,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: s.sp12, vertical: s.sp8),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.12),
              borderRadius: BorderRadius.circular(s.r10),
              border: Border.all(
                color: const Color(0xFF3B82F6).withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_rounded,
                  color: const Color(0xFF3B82F6),
                  size: s.ic14,
                ),
                SizedBox(width: s.sp4),
                Text(
                  'Add File',
                  style: TextStyle(
                    color: const Color(0xFF3B82F6),
                    fontSize: s.f12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    body: Obx(
      () => ctrl.attachments.isEmpty
          ? GestureDetector(
              onTap: ctrl.pickFiles,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: s.sp20),
                decoration: BoxDecoration(
                  color: t.cardAlt,
                  borderRadius: BorderRadius.circular(s.r12),
                  border: Border.all(color: t.border),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      color: t.text3,
                      size: s.ic28,
                    ),
                    SizedBox(height: s.sp6),
                    Text(
                      'Tap to attach files',
                      style: TextStyle(
                        color: t.text3,
                        fontSize: s.f13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: s.sp2),
                    Text(
                      'PDF · Images · Docs · Videos',
                      style: TextStyle(
                        color: t.text3.withOpacity(0.6),
                        fontSize: s.f11,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: ctrl.attachments
                  .asMap()
                  .entries
                  .map(
                    (e) => _AttachTile(
                      file: e.value,
                      idx: e.key,
                      ctrl: ctrl,
                      t: t,
                      s: s,
                    ),
                  )
                  .toList(),
            ),
    ),
  );
}

class _AttachTile extends StatelessWidget {
  final AttachmentFile file;
  final int idx;
  final EngageEntryController ctrl;
  final _T t;
  final _S s;
  const _AttachTile({
    required this.file,
    required this.idx,
    required this.ctrl,
    required this.t,
    required this.s,
  });

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.only(bottom: s.sp8),
    padding: EdgeInsets.symmetric(horizontal: s.sp12, vertical: s.sp10),
    decoration: BoxDecoration(
      color: t.cardAlt,
      borderRadius: BorderRadius.circular(s.r12),
      border: Border.all(color: t.border),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(s.sp8),
          decoration: BoxDecoration(
            color: file.iconColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(s.r8),
          ),
          child: Icon(file.icon, color: file.iconColor, size: s.ic18),
        ),
        SizedBox(width: s.sp10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${file.name}.${file.extension}',
                style: TextStyle(
                  color: t.text1,
                  fontSize: s.f13,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                file.sizeLabel,
                style: TextStyle(color: t.text3, fontSize: s.f11),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => ctrl.removeAttachment(idx),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close_rounded,
              color: Colors.red.shade400,
              size: s.ic13,
            ),
          ),
        ),
      ],
    ),
  );
}

// ════════════════════════════════════════════════════════════
//  ASSIGNEE PICKER
// ════════════════════════════════════════════════════════════
class _AssigneePicker extends StatelessWidget {
  final EngageEntryController ctrl;
  final _T t;
  final _S s;
  const _AssigneePicker({required this.ctrl, required this.t, required this.s});

  @override
  Widget build(BuildContext context) => _SectionBox(
    t: t,
    s: s,
    header: Row(
      children: [
        _IconBadge(Icons.people_alt_rounded, const Color(0xFFEC4899), s),
        SizedBox(width: s.sp9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assignees',
                style: TextStyle(
                  color: t.text1,
                  fontSize: s.f14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Tap to select team members',
                style: TextStyle(color: t.text3, fontSize: s.f11),
              ),
            ],
          ),
        ),
        Obx(
          () => ctrl.selectedAssignees.isEmpty
              ? const SizedBox.shrink()
              : Text(
                  '${ctrl.selectedAssignees.length} selected',
                  style: TextStyle(
                    color: const Color(0xFFEC4899),
                    fontSize: s.f11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selected chips
        Obx(
          () => ctrl.selectedAssignees.isEmpty
              ? const SizedBox.shrink()
              : Container(
                  margin: EdgeInsets.only(bottom: s.sp12),
                  padding: EdgeInsets.all(s.sp10),
                  decoration: BoxDecoration(
                    color: t.cardAlt,
                    borderRadius: BorderRadius.circular(s.r12),
                    border: Border.all(color: t.border),
                  ),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: ctrl.selectedAssignees
                        .map(
                          (a) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: s.sp8,
                              vertical: s.sp4,
                            ),
                            decoration: BoxDecoration(
                              color: a.avatarColor.withOpacity(0.14),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: a.avatarColor.withOpacity(0.35),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: s.av10,
                                  backgroundColor: a.avatarColor,
                                  child: Text(
                                    a.initials,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: s.f9,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                SizedBox(width: s.sp5),
                                Text(
                                  a.name.split(' ').first,
                                  style: TextStyle(
                                    color: t.text1,
                                    fontSize: s.f12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: s.sp4),
                                GestureDetector(
                                  onTap: () => ctrl.toggleAssignee(a),
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: t.text3,
                                    size: s.ic12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
        // Assignee grid
        _AssigneeGrid(ctrl: ctrl, t: t, s: s),
      ],
    ),
  );
}

class _AssigneeGrid extends StatelessWidget {
  final EngageEntryController ctrl;
  final _T t;
  final _S s;
  const _AssigneeGrid({required this.ctrl, required this.t, required this.s});

  @override
  Widget build(BuildContext context) {
    final cols = s.assigneeCols;
    if (cols == 1) {
      return Column(
        children: ctrl.allAssignees
            .map((a) => _AssigneeTile(a: a, ctrl: ctrl, t: t, s: s))
            .toList(),
      );
    }
    final rows = <Widget>[];
    for (var i = 0; i < ctrl.allAssignees.length; i += 2) {
      final left = ctrl.allAssignees[i];
      final right = i + 1 < ctrl.allAssignees.length
          ? ctrl.allAssignees[i + 1]
          : null;
      rows.add(
        Row(
          children: [
            Expanded(
              child: _AssigneeTile(a: left, ctrl: ctrl, t: t, s: s),
            ),
            if (right != null) ...[
              SizedBox(width: s.sp8),
              Expanded(
                child: _AssigneeTile(a: right, ctrl: ctrl, t: t, s: s),
              ),
            ] else
              const Expanded(child: SizedBox()),
          ],
        ),
      );
      rows.add(SizedBox(height: s.sp6));
    }
    return Column(children: rows);
  }
}

class _AssigneeTile extends StatelessWidget {
  final Assignee a;
  final EngageEntryController ctrl;
  final _T t;
  final _S s;
  const _AssigneeTile({
    required this.a,
    required this.ctrl,
    required this.t,
    required this.s,
  });

  @override
  Widget build(BuildContext context) => Obx(() {
    final sel = ctrl.isAssigneeSelected(a);
    return GestureDetector(
      onTap: () => ctrl.toggleAssignee(a),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: EdgeInsets.only(bottom: s.sp6),
        padding: EdgeInsets.symmetric(horizontal: s.sp12, vertical: s.sp10),
        decoration: BoxDecoration(
          color: sel
              ? a.avatarColor.withOpacity(t.isDark ? 0.12 : 0.08)
              : t.cardAlt,
          borderRadius: BorderRadius.circular(s.r12),
          border: Border.all(
            color: sel ? a.avatarColor.withOpacity(0.5) : t.border,
            width: sel ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: s.av18,
              backgroundColor: a.avatarColor,
              child: Text(
                a.initials,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: s.f13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(width: s.sp10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a.name,
                    style: TextStyle(
                      color: t.text1,
                      fontSize: s.f13,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    a.role,
                    style: TextStyle(color: t.text3, fontSize: s.f11),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: sel ? a.avatarColor : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: sel ? a.avatarColor : t.border,
                  width: 1.5,
                ),
              ),
              child: sel
                  ? Icon(Icons.check_rounded, color: Colors.white, size: s.ic12)
                  : null,
            ),
          ],
        ),
      ),
    );
  });
}

// ════════════════════════════════════════════════════════════
//  SUBMIT BUTTON
// ════════════════════════════════════════════════════════════
class _SubmitButton extends StatelessWidget {
  final EngageEntryController ctrl;
  final _T t;
  final _S s;
  const _SubmitButton({required this.ctrl, required this.t, required this.s});

  @override
  Widget build(BuildContext context) => Obx(
    () => GestureDetector(
      onTap: ctrl.isSubmitting.value ? null : ctrl.submit,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 54,
        decoration: BoxDecoration(
          gradient: ctrl.isSubmitting.value
              ? null
              : const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
          color: ctrl.isSubmitting.value ? t.border : null,
          borderRadius: BorderRadius.circular(s.r16),
          boxShadow: ctrl.isSubmitting.value
              ? null
              : [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withOpacity(0.38),
                    blurRadius: 18,
                    offset: const Offset(0, 7),
                  ),
                ],
        ),
        child: Center(
          child: ctrl.isSubmitting.value
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Saving entry…',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: s.f15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_task_rounded,
                      color: Colors.white,
                      size: s.ic20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Add Entry',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: s.f16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    ),
  );
}

// ════════════════════════════════════════════════════════════
//  SECTION DIVIDER
// ════════════════════════════════════════════════════════════
class _SectionDivider extends StatelessWidget {
  final int count;
  final _T t;
  final _S s;
  const _SectionDivider({
    required this.count,
    required this.t,
    required this.s,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: s.hPad, vertical: s.sp12),
    child: Row(
      children: [
        Container(width: 32, height: 1.5, color: t.border),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: t.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: t.border),
          ),
          child: Row(
            children: [
              Icon(Icons.inventory_2_rounded, color: t.accent, size: s.ic13),
              const SizedBox(width: 5),
              Text(
                '$count Recent ${count == 1 ? "Entry" : "Entries"}',
                style: TextStyle(
                  color: t.accent,
                  fontSize: s.f11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Container(height: 1.5, color: t.border)),
      ],
    ),
  );
}

// ════════════════════════════════════════════════════════════
//  ENTRY CARD
// ════════════════════════════════════════════════════════════
class _EntryCard extends StatelessWidget {
  final EngageEntry entry;
  final EngageEntryController ctrl;
  final _T t;
  final _S s;
  const _EntryCard({
    required this.entry,
    required this.ctrl,
    required this.t,
    required this.s,
  });

  @override
  Widget build(BuildContext context) {
    final sc = EngageEntryController.sectionConfig[entry.section]!;
    final tab = EngageEntryController.tabConfig[entry.sectionTab]!;

    return Container(
      decoration: BoxDecoration(
        color: t.card,
        borderRadius: BorderRadius.circular(s.r20),
        border: Border.all(color: sc.color.withOpacity(0.28)),
        boxShadow: [
          BoxShadow(
            color: sc.color.withOpacity(t.isDark ? 0.08 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
          ...t.cardShadow,
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header strip ─────────────────────────────────
          Container(
            padding: EdgeInsets.symmetric(horizontal: s.sp16, vertical: s.sp12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  sc.color.withOpacity(t.isDark ? 0.18 : 0.10),
                  sc.color.withOpacity(0.03),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(s.r20),
                topRight: Radius.circular(s.r20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(s.sp6),
                  decoration: BoxDecoration(
                    color: sc.color.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(s.r8),
                  ),
                  child: Icon(sc.icon, color: sc.color, size: s.ic14),
                ),
                SizedBox(width: s.sp8),
                Text(
                  sc.label,
                  style: TextStyle(
                    color: sc.color,
                    fontSize: s.f12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: s.sp8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: t.bg.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(s.r6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(tab.icon, color: t.text3, size: s.ic11),
                      const SizedBox(width: 3),
                      Text(
                        tab.label,
                        style: TextStyle(color: t.text3, fontSize: s.f10),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  _formatTime(entry.createdAt),
                  style: TextStyle(color: t.text3, fontSize: s.f10),
                ),
                SizedBox(width: s.sp10),
                GestureDetector(
                  onTap: () => ctrl.deleteEntry(entry.id),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.10),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red.shade400,
                      size: s.ic13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Body ─────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(s.sp16, s.sp14, s.sp16, s.sp16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Context brief badge
                if (entry.contextBrief.isNotEmpty) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: s.sp10,
                      vertical: s.sp5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF22D3EE).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(s.r8),
                      border: Border.all(
                        color: const Color(0xFF22D3EE).withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.short_text_rounded,
                          color: const Color(0xFF22D3EE),
                          size: s.ic12,
                        ),
                        SizedBox(width: s.sp5),
                        Flexible(
                          child: Text(
                            entry.contextBrief,
                            style: TextStyle(
                              color: const Color(0xFF22D3EE),
                              fontSize: s.f11,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: s.sp10),
                ],

                // Title
                Text(
                  entry.title,
                  style: TextStyle(
                    color: t.text1,
                    fontSize: s.f17,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(height: s.sp8),

                // Description
                Text(
                  entry.description,
                  style: TextStyle(
                    color: t.text2,
                    fontSize: s.f13,
                    height: 1.55,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                // Remark
                if (entry.remark.isNotEmpty) ...[
                  SizedBox(height: s.sp10),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: s.sp10,
                      vertical: s.sp8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(s.r10),
                      border: Border.all(
                        color: const Color(0xFFF59E0B).withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.comment_rounded,
                          color: const Color(0xFFF59E0B),
                          size: s.ic13,
                        ),
                        SizedBox(width: s.sp6),
                        Expanded(
                          child: Text(
                            entry.remark,
                            style: TextStyle(
                              color: const Color(0xFFF59E0B),
                              fontSize: s.f12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Criteria chips
                if (entry.criteria.isNotEmpty) ...[
                  SizedBox(height: s.sp12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: entry.criteria.map((c) {
                      final cfg = EngageEntryController.criteriaConfig[c]!;
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: s.sp9,
                          vertical: s.sp4,
                        ),
                        decoration: BoxDecoration(
                          color: cfg.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: cfg.color.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(cfg.icon, color: cfg.color, size: s.ic11),
                            SizedBox(width: s.sp4),
                            Text(
                              cfg.label,
                              style: TextStyle(
                                color: cfg.color,
                                fontSize: s.f10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],

                // Attachments
                if (entry.attachments.isNotEmpty) ...[
                  SizedBox(height: s.sp12),
                  Container(
                    padding: EdgeInsets.all(s.sp10),
                    decoration: BoxDecoration(
                      color: t.cardAlt,
                      borderRadius: BorderRadius.circular(s.r10),
                      border: Border.all(color: t.border),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.attach_file_rounded,
                          color: t.text3,
                          size: s.ic14,
                        ),
                        SizedBox(width: s.sp6),
                        Text(
                          '${entry.attachments.length} file${entry.attachments.length > 1 ? "s" : ""} attached',
                          style: TextStyle(color: t.text3, fontSize: s.f11),
                        ),
                        SizedBox(width: s.sp8),
                        ...entry.attachments
                            .take(3)
                            .map(
                              (f) => Container(
                                margin: const EdgeInsets.only(right: 4),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: f.iconColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '.${f.extension}',
                                  style: TextStyle(
                                    color: f.iconColor,
                                    fontSize: s.f9,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ],

                // Assignees
                if (entry.assignees.isNotEmpty) ...[
                  SizedBox(height: s.sp12),
                  Row(
                    children: [
                      Icon(
                        Icons.people_alt_rounded,
                        color: t.text3,
                        size: s.ic13,
                      ),
                      SizedBox(width: s.sp6),
                      Text(
                        'Assignees',
                        style: TextStyle(color: t.text3, fontSize: s.f11),
                      ),
                      SizedBox(width: s.sp10),
                      SizedBox(
                        height: 28,
                        width: (entry.assignees.length * 20.0 + 8).clamp(
                          0.0,
                          120.0,
                        ),
                        child: Stack(
                          children: entry.assignees
                              .take(5)
                              .toList()
                              .asMap()
                              .entries
                              .map(
                                (e) => Positioned(
                                  left: e.key * 18.0,
                                  child: CircleAvatar(
                                    radius: s.av13,
                                    backgroundColor: t.card,
                                    child: CircleAvatar(
                                      radius: s.av11,
                                      backgroundColor: e.value.avatarColor,
                                      child: Text(
                                        e.value.initials,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: s.f9,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      if (entry.assignees.length > 5) ...[
                        SizedBox(width: s.sp4),
                        Text(
                          '+${entry.assignees.length - 5} more',
                          style: TextStyle(color: t.text3, fontSize: s.f10),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final d = DateTime.now().difference(dt);
    if (d.inSeconds < 60) return 'Just now';
    if (d.inMinutes < 60) return '${d.inMinutes}m ago';
    if (d.inHours < 24) return '${d.inHours}h ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

// ════════════════════════════════════════════════════════════
//  HELPER WIDGETS
// ════════════════════════════════════════════════════════════

/// Uniform section container (header + body)
class _SectionBox extends StatelessWidget {
  final Widget header, body;
  final _T t;
  final _S s;
  const _SectionBox({
    required this.header,
    required this.body,
    required this.t,
    required this.s,
  });

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: t.card,
      borderRadius: BorderRadius.circular(s.r18),
      border: Border.all(color: t.border),
      boxShadow: t.cardShadow,
    ),
    padding: s.cardPad,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header,
        SizedBox(height: s.sp14),
        body,
      ],
    ),
  );
}

/// FormCard with label header
class _FormCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final Widget child;
  final _T t;
  final _S s;
  const _FormCard({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.child,
    required this.t,
    required this.s,
  });

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: t.card,
      borderRadius: BorderRadius.circular(s.r16),
      border: Border.all(color: t.border),
      boxShadow: t.cardShadow,
    ),
    padding: s.cardPad,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label, icon, iconColor, t, s),
        SizedBox(height: s.sp10),
        child,
      ],
    ),
  );
}

/// Field label with coloured icon badge
class _FieldLabel extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final _T t;
  final _S s;
  const _FieldLabel(this.text, this.icon, this.color, this.t, this.s);

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        padding: EdgeInsets.all(s.sp5),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(s.r6),
        ),
        child: Icon(icon, color: color, size: s.ic13),
      ),
      SizedBox(width: s.sp8),
      Text(
        text,
        style: TextStyle(
          color: t.text1,
          fontSize: s.f13,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

/// Coloured icon badge (for section headers)
class _IconBadge extends StatelessWidget {
  final IconData icon;
  final Color color;
  final _S s;
  const _IconBadge(this.icon, this.color, this.s);

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(s.sp6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(s.r9),
    ),
    child: Icon(icon, color: color, size: s.ic16),
  );
}

/// Text field with theme-aware decoration
class _AIRField extends StatelessWidget {
  final TextEditingController ctrl;
  final String hint;
  final int maxLines;
  final String? Function(String?)? validator;
  final _T t;
  final _S s;
  const _AIRField({
    required this.ctrl,
    required this.hint,
    required this.t,
    required this.s,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: ctrl,
    maxLines: maxLines,
    minLines: 1,
    validator: validator,
    style: TextStyle(color: t.text1, fontSize: s.f14),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: t.text3, fontSize: s.f13),
      filled: true,
      fillColor: t.cardAlt,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(s.r12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(s.r12),
        borderSide: BorderSide(color: t.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(s.r12),
        borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(s.r12),
        borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(s.r12),
        borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
      ),
      errorStyle: TextStyle(fontSize: s.f11, color: Colors.red.shade400),
      contentPadding: s.fieldPad,
    ),
  );
}

/// Two-column row helper
class _Row2 extends StatelessWidget {
  final Widget left, right;
  final int leftFlex, rightFlex;
  const _Row2({
    required this.left,
    required this.right,
    this.leftFlex = 1,
    this.rightFlex = 1,
  });

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(flex: leftFlex, child: left),
      const SizedBox(width: 12),
      Expanded(flex: rightFlex, child: right),
    ],
  );
}
