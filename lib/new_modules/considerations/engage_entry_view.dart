// ============================================================
//  EngageEntryView – Full Form + Card Preview
//  GetX | Material 3 | Fully responsive
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'engage_entry_controller.dart';

// ── Palette (self-contained, no external theme dep needed) ──
class _P {
  static const bg       = Color(0xFF0C0E1A);
  static const surface  = Color(0xFF141728);
  static const card     = Color(0xFF1B1F35);
  static const border   = Color(0xFF252A45);
  static const primary  = Color(0xFF6366F1);
  static const accent   = Color(0xFF818CF8);
  static const text1    = Color(0xFFF1F5F9);
  static const text2    = Color(0xFF94A3B8);
  static const text3    = Color(0xFF475569);
  static const divider  = Color(0xFF1E2438);
}

// ════════════════════════════════════════════════════════════
//  MAIN VIEW
// ════════════════════════════════════════════════════════════
class EngageEntryView extends StatelessWidget {
  const EngageEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(EngageEntryController());

    return Scaffold(
      backgroundColor: _P.bg,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Sticky header ──────────────────────────────
            SliverAppBar(
              pinned:          true,
              backgroundColor: _P.bg,
              surfaceTintColor: Colors.transparent,
              elevation:       0,
              expandedHeight:  120.h,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                              begin: Alignment.topLeft, end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [BoxShadow(
                              color: _P.primary.withOpacity(0.4),
                              blurRadius: 12, offset: const Offset(0, 4),
                            )],
                          ),
                          child: Icon(Icons.add_task_rounded, color: Colors.white, size: 22.r),
                        ),
                        SizedBox(width: 12.w),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('New Entry',
                              style: TextStyle(color: _P.text1, fontSize: 22.sp,
                                  fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                          Text('Capture. Assign. Track.',
                              style: TextStyle(color: _P.text2, fontSize: 12.sp)),
                        ]),
                        const Spacer(),
                        Obx(() => ctrl.entries.isEmpty ? const SizedBox.shrink() :
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: _P.primary.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: _P.primary.withOpacity(0.3)),
                            ),
                            child: Text('${ctrl.entries.length} entries',
                                style: TextStyle(color: _P.accent, fontSize: 12.sp,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),

            // ── Form body ──────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: ctrl.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Section Title selector
                      _SectionTitlePicker(ctrl: ctrl),
                      SizedBox(height: 16.h),

                      // 2. Section Tab
                      _SectionTabRow(ctrl: ctrl),
                      SizedBox(height: 20.h),

                      // 3. Context Brief
                      _FormCard(
                        label:    'Context Brief',
                        icon:     Icons.short_text_rounded,
                        iconColor: const Color(0xFF22D3EE),
                        child: _AIRField(
                          controller: ctrl.contextBriefCtrl,
                          hint:       'Provide a brief context of this entry…',
                          maxLines:   2,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Context brief is required' : null,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // 4. Title
                      _FormCard(
                        label:    'Title',
                        icon:     Icons.title_rounded,
                        iconColor: _P.primary,
                        child: _AIRField(
                          controller: ctrl.titleCtrl,
                          hint:       'Enter a clear, concise title…',
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Title is required' : null,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // 5. Description
                      _FormCard(
                        label:    'Description',
                        icon:     Icons.notes_rounded,
                        iconColor: const Color(0xFF8B5CF6),
                        child: _AIRField(
                          controller: ctrl.descriptionCtrl,
                          hint:       'Describe in detail what this entry is about…',
                          maxLines:   4,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Description is required' : null,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // 6. Remark
                      _FormCard(
                        label:    'Remark',
                        icon:     Icons.comment_rounded,
                        iconColor: const Color(0xFFF59E0B),
                        child: _AIRField(
                          controller: ctrl.remarkCtrl,
                          hint:       'Any additional remarks or notes…',
                          maxLines:   2,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // 7. Catch Criteria chips
                      _CriteriaPicker(ctrl: ctrl),
                      SizedBox(height: 16.h),

                      // 8. Attachments
                      _AttachmentPicker(ctrl: ctrl),
                      SizedBox(height: 16.h),

                      // 9. Assignees
                      _AssigneePicker(ctrl: ctrl),
                      SizedBox(height: 24.h),

                      // 10. Submit button
                      _SubmitButton(ctrl: ctrl),
                      SizedBox(height: 28.h),
                    ],
                  ),
                ),
              ),
            ),

            // ── Divider + Entries list ──────────────────────
            SliverToBoxAdapter(
              child: Obx(() {
                if (ctrl.entries.isEmpty) return const SizedBox.shrink();
                return Column(children: [
                  _SectionDivider(count: ctrl.entries.length),
                  SizedBox(height: 4.h),
                ]);
              }),
            ),

            Obx(() => SliverList.builder(
              itemCount: ctrl.entries.length,
              itemBuilder: (_, i) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                child: _EntryCard(entry: ctrl.entries[i], ctrl: ctrl),
              ),
            )),

            SliverToBoxAdapter(child: SizedBox(height: 40.h)),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  1. SECTION TITLE PICKER
// ════════════════════════════════════════════════════════════
class _SectionTitlePicker extends StatelessWidget {
  final EngageEntryController ctrl;
  const _SectionTitlePicker({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _FieldLabel('Section Title', Icons.category_rounded, const Color(0xFF6366F1)),
      SizedBox(height: 10.h),
      Obx(() => Wrap(
        spacing: 8.w, runSpacing: 8.h,
        children: EntrySection.values.map((s) {
          final cfg     = EngageEntryController.sectionConfig[s]!;
          final selected = ctrl.selectedSection.value == s;
          return GestureDetector(
            onTap: () => ctrl.selectSection(s),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
              decoration: BoxDecoration(
                color: selected ? cfg.color.withOpacity(0.18) : _P.card,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: selected ? cfg.color : _P.border,
                  width: selected ? 1.5 : 1,
                ),
                boxShadow: selected ? [BoxShadow(
                  color: cfg.color.withOpacity(0.2),
                  blurRadius: 8, offset: const Offset(0, 2),
                )] : null,
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(cfg.icon, color: selected ? cfg.color : _P.text3, size: 16.r),
                SizedBox(width: 6.w),
                Text(cfg.label,
                    style: TextStyle(
                      color:      selected ? cfg.color : _P.text2,
                      fontSize:   13.sp,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    )),
              ]),
            ),
          );
        }).toList(),
      )),
    ]);
  }
}

// ════════════════════════════════════════════════════════════
//  2. SECTION TAB ROW
// ════════════════════════════════════════════════════════════
class _SectionTabRow extends StatelessWidget {
  final EngageEntryController ctrl;
  const _SectionTabRow({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _FieldLabel('Section Tab', Icons.tab_rounded, const Color(0xFF22D3EE)),
      SizedBox(height: 10.h),
      Container(
        decoration: BoxDecoration(
          color:        _P.card,
          borderRadius: BorderRadius.circular(14.r),
          border:       Border.all(color: _P.border),
        ),
        padding: EdgeInsets.all(4.r),
        child: Obx(() => Row(
          children: SectionTab.values.map((tab) {
            final cfg     = EngageEntryController.tabConfig[tab]!;
            final selected = ctrl.selectedTab.value == tab;
            return Expanded(
              child: GestureDetector(
                onTap: () => ctrl.selectTab(tab),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    gradient: selected ? const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                    ) : null,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: selected ? [BoxShadow(
                      color: _P.primary.withOpacity(0.35),
                      blurRadius: 8, offset: const Offset(0, 3),
                    )] : null,
                  ),
                  child: Column(children: [
                    Icon(cfg.icon,
                        color:  selected ? Colors.white : _P.text3,
                        size:   16.r),
                    SizedBox(height: 3.h),
                    Text(cfg.label,
                        style: TextStyle(
                          color:      selected ? Colors.white : _P.text2,
                          fontSize:   10.sp,
                          fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                        )),
                  ]),
                ),
              ),
            );
          }).toList(),
        )),
      ),
    ]);
  }
}

// ════════════════════════════════════════════════════════════
//  7. CATCH CRITERIA CHIPS
// ════════════════════════════════════════════════════════════
class _CriteriaPicker extends StatelessWidget {
  final EngageEntryController ctrl;
  const _CriteriaPicker({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:        _P.card,
        borderRadius: BorderRadius.circular(16.r),
        border:       Border.all(color: _P.border),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withOpacity(0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.local_offer_rounded,
                color: const Color(0xFFF59E0B), size: 16.r),
          ),
          SizedBox(width: 8.w),
          Text('Catch Criteria',
              style: TextStyle(color: _P.text1, fontSize: 14.sp,
                  fontWeight: FontWeight.w700)),
          const Spacer(),
          Obx(() => ctrl.selectedCriteria.isEmpty
              ? const SizedBox.shrink()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: _P.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text('${ctrl.selectedCriteria.length} selected',
                      style: TextStyle(color: _P.accent, fontSize: 10.sp,
                          fontWeight: FontWeight.w600)),
                )),
        ]),
        SizedBox(height: 4.h),
        Text('Tag this entry – select all that apply',
            style: TextStyle(color: _P.text3, fontSize: 11.sp)),
        SizedBox(height: 14.h),
        Obx(() => Wrap(
          spacing: 8.w, runSpacing: 8.h,
          children: CatchCriteria.values.map((c) {
            final cfg      = EngageEntryController.criteriaConfig[c]!;
            final selected = ctrl.selectedCriteria.contains(c);
            return GestureDetector(
              onTap: () => ctrl.toggleCriteria(c),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color:        selected ? cfg.color.withOpacity(0.15) : _P.surface,
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    color: selected ? cfg.color : _P.border,
                    width: selected ? 1.5 : 1,
                  ),
                  boxShadow: selected ? [BoxShadow(
                    color:     cfg.color.withOpacity(0.2),
                    blurRadius: 6, offset: const Offset(0, 2),
                  )] : null,
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    child: Icon(
                      selected ? Icons.check_circle_rounded : cfg.icon,
                      color:  cfg.color,
                      size:   14.r,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(cfg.label,
                      style: TextStyle(
                        color:      selected ? cfg.color : _P.text2,
                        fontSize:   12.sp,
                        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      )),
                ]),
              ),
            );
          }).toList(),
        )),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  8. ATTACHMENT PICKER
// ════════════════════════════════════════════════════════════
class _AttachmentPicker extends StatelessWidget {
  final EngageEntryController ctrl;
  const _AttachmentPicker({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:        _P.card,
        borderRadius: BorderRadius.circular(16.r),
        border:       Border.all(color: _P.border),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.attach_file_rounded,
                color: const Color(0xFF3B82F6), size: 16.r),
          ),
          SizedBox(width: 8.w),
          Text('Attachments',
              style: TextStyle(color: _P.text1, fontSize: 14.sp,
                  fontWeight: FontWeight.w700)),
          const Spacer(),
          GestureDetector(
            onTap: ctrl.pickFiles,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.12),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.3)),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.add_rounded, color: const Color(0xFF3B82F6), size: 14.r),
                SizedBox(width: 4.w),
                Text('Add File',
                    style: TextStyle(color: const Color(0xFF3B82F6),
                        fontSize: 12.sp, fontWeight: FontWeight.w600)),
              ]),
            ),
          ),
        ]),
        Obx(() {
          if (ctrl.attachments.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 14.h),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 18.h),
                decoration: BoxDecoration(
                  color:        _P.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                      color: _P.border, style: BorderStyle.solid),
                ),
                child: Column(children: [
                  Icon(Icons.cloud_upload_outlined,
                      color: _P.text3, size: 28.r),
                  SizedBox(height: 6.h),
                  Text('No files attached',
                      style: TextStyle(color: _P.text3, fontSize: 12.sp)),
                  Text('Tap "Add File" to attach',
                      style: TextStyle(color: _P.text3.withOpacity(0.6),
                          fontSize: 11.sp)),
                ]),
              ),
            );
          }
          return Column(
            children: [
              SizedBox(height: 12.h),
              ...ctrl.attachments.asMap().entries.map((e) =>
                  _AttachmentTile(file: e.value, index: e.key, ctrl: ctrl)),
            ],
          );
        }),
      ]),
    );
  }
}

class _AttachmentTile extends StatelessWidget {
  final AttachmentFile file;
  final int            index;
  final EngageEntryController ctrl;
  const _AttachmentTile({required this.file, required this.index, required this.ctrl});

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.only(bottom: 8.h),
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
    decoration: BoxDecoration(
      color:        _P.surface,
      borderRadius: BorderRadius.circular(12.r),
      border:       Border.all(color: _P.border),
    ),
    child: Row(children: [
      Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color:        file.iconColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(file.icon, color: file.iconColor, size: 18.r),
      ),
      SizedBox(width: 10.w),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('${file.name}.${file.extension}',
            style: TextStyle(color: _P.text1, fontSize: 13.sp,
                fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis),
        Text(file.sizeLabel,
            style: TextStyle(color: _P.text3, fontSize: 11.sp)),
      ])),
      GestureDetector(
        onTap: () => ctrl.removeAttachment(index),
        child: Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color:  Colors.red.withOpacity(0.1),
            shape:  BoxShape.circle,
          ),
          child: Icon(Icons.close_rounded, color: Colors.red.shade400, size: 14.r),
        ),
      ),
    ]),
  );
}

// ════════════════════════════════════════════════════════════
//  9. ASSIGNEE PICKER
// ════════════════════════════════════════════════════════════
class _AssigneePicker extends StatelessWidget {
  final EngageEntryController ctrl;
  const _AssigneePicker({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:        _P.card,
        borderRadius: BorderRadius.circular(16.r),
        border:       Border.all(color: _P.border),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: const Color(0xFFEC4899).withOpacity(0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.people_alt_rounded,
                color: const Color(0xFFEC4899), size: 16.r),
          ),
          SizedBox(width: 8.w),
          Text('Assignees',
              style: TextStyle(color: _P.text1, fontSize: 14.sp,
                  fontWeight: FontWeight.w700)),
          const Spacer(),
          Obx(() => ctrl.selectedAssignees.isEmpty
              ? const SizedBox.shrink()
              : Text('${ctrl.selectedAssignees.length} selected',
                  style: TextStyle(color: const Color(0xFFEC4899),
                      fontSize: 11.sp, fontWeight: FontWeight.w600))),
        ]),
        SizedBox(height: 4.h),
        Text('Choose who to assign this entry to',
            style: TextStyle(color: _P.text3, fontSize: 11.sp)),
        // ── Selected chips ───────────────────────────────
        Obx(() {
          if (ctrl.selectedAssignees.isEmpty) return const SizedBox.shrink();
          return Container(
            margin: EdgeInsets.only(top: 12.h),
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color:        _P.surface,
              borderRadius: BorderRadius.circular(12.r),
              border:       Border.all(color: _P.border),
            ),
            child: Wrap(
              spacing: 6.w, runSpacing: 6.h,
              children: ctrl.selectedAssignees.map((a) =>
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: a.avatarColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: a.avatarColor.withOpacity(0.4)),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    CircleAvatar(
                      radius: 10.r,
                      backgroundColor: a.avatarColor,
                      child: Text(a.initials,
                          style: TextStyle(color: Colors.white, fontSize: 8.sp,
                              fontWeight: FontWeight.w800)),
                    ),
                    SizedBox(width: 5.w),
                    Text(a.name.split(' ').first,
                        style: TextStyle(color: _P.text1, fontSize: 11.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: () => ctrl.toggleAssignee(a),
                      child: Icon(Icons.close_rounded,
                          color: _P.text3, size: 13.r),
                    ),
                  ]),
                ),
              ).toList(),
            ),
          );
        }),
        SizedBox(height: 12.h),
        // ── All assignees ────────────────────────────────
        ...ctrl.allAssignees.map((a) {
          return Obx(() {
            final selected = ctrl.isAssigneeSelected(a);
            return GestureDetector(
              onTap: () => ctrl.toggleAssignee(a),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: EdgeInsets.only(bottom: 6.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color:        selected ? a.avatarColor.withOpacity(0.1) : _P.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: selected ? a.avatarColor.withOpacity(0.5) : _P.border,
                    width: selected ? 1.5 : 1,
                  ),
                ),
                child: Row(children: [
                  CircleAvatar(
                    radius: 18.r,
                    backgroundColor: a.avatarColor,
                    child: Text(a.initials,
                        style: TextStyle(color: Colors.white, fontSize: 12.sp,
                            fontWeight: FontWeight.w800)),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a.name, style: TextStyle(color: _P.text1,
                          fontSize: 13.sp, fontWeight: FontWeight.w600)),
                      Text(a.role, style: TextStyle(color: _P.text3, fontSize: 11.sp)),
                    ])),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 22.r, height: 22.r,
                    decoration: BoxDecoration(
                      color:  selected ? a.avatarColor : Colors.transparent,
                      shape:  BoxShape.circle,
                      border: Border.all(
                        color: selected ? a.avatarColor : _P.border, width: 1.5),
                    ),
                    child: selected
                        ? Icon(Icons.check_rounded, color: Colors.white, size: 13.r)
                        : null,
                  ),
                ]),
              ),
            );
          });
        }),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  SUBMIT BUTTON
// ════════════════════════════════════════════════════════════
class _SubmitButton extends StatelessWidget {
  final EngageEntryController ctrl;
  const _SubmitButton({required this.ctrl});

  @override
  Widget build(BuildContext context) => Obx(() => GestureDetector(
    onTap: ctrl.isSubmitting.value ? null : ctrl.submit,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height:   54.h,
      decoration: BoxDecoration(
        gradient: ctrl.isSubmitting.value
            ? null
            : const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.centerLeft, end: Alignment.centerRight,
              ),
        color: ctrl.isSubmitting.value ? _P.border : null,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ctrl.isSubmitting.value ? null : [BoxShadow(
          color: _P.primary.withOpacity(0.4),
          blurRadius: 16, offset: const Offset(0, 6),
        )],
      ),
      child: Center(
        child: ctrl.isSubmitting.value
            ? Row(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(
                  width: 18.r, height: 18.r,
                  child: const CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                ),
                SizedBox(width: 10.w),
                Text('Saving entry…',
                    style: TextStyle(color: Colors.white, fontSize: 15.sp,
                        fontWeight: FontWeight.w700)),
              ])
            : Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.add_task_rounded, color: Colors.white, size: 20.r),
                SizedBox(width: 8.w),
                Text('Add Entry',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp,
                        fontWeight: FontWeight.w800, letterSpacing: 0.2)),
              ]),
      ),
    ),
  ));
}

// ════════════════════════════════════════════════════════════
//  ENTRIES DIVIDER
// ════════════════════════════════════════════════════════════
class _SectionDivider extends StatelessWidget {
  final int count;
  const _SectionDivider({required this.count});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    child: Row(children: [
      Container(width: 32.w, height: 1.5, color: _P.border),
      SizedBox(width: 10.w),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
        decoration: BoxDecoration(
          color:        _P.card,
          borderRadius: BorderRadius.circular(20.r),
          border:       Border.all(color: _P.border),
        ),
        child: Row(children: [
          Icon(Icons.inventory_2_rounded, color: _P.accent, size: 13.r),
          SizedBox(width: 5.w),
          Text('$count Recent ${count == 1 ? "Entry" : "Entries"}',
              style: TextStyle(color: _P.accent, fontSize: 11.sp,
                  fontWeight: FontWeight.w700)),
        ]),
      ),
      SizedBox(width: 10.w),
      Expanded(child: Container(height: 1.5, color: _P.border)),
    ]),
  );
}

// ════════════════════════════════════════════════════════════
//  ENTRY CARD
// ════════════════════════════════════════════════════════════
class _EntryCard extends StatelessWidget {
  final EngageEntry           entry;
  final EngageEntryController ctrl;
  const _EntryCard({required this.entry, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final sectionCfg = EngageEntryController.sectionConfig[entry.section]!;
    final tabCfg     = EngageEntryController.tabConfig[entry.sectionTab]!;
    final timeStr    = _formatTime(entry.createdAt);

    return Container(
      decoration: BoxDecoration(
        color:        _P.card,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: sectionCfg.color.withOpacity(0.25), width: 1),
        boxShadow: [BoxShadow(
          color:      sectionCfg.color.withOpacity(0.08),
          blurRadius: 16, offset: const Offset(0, 4),
        )],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        // ── Card header ──────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [sectionCfg.color.withOpacity(0.15),
                       sectionCfg.color.withOpacity(0.04)],
              begin: Alignment.centerLeft, end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft:  Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Row(children: [
            Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color:        sectionCfg.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(sectionCfg.icon, color: sectionCfg.color, size: 16.r),
            ),
            SizedBox(width: 8.w),
            Text(sectionCfg.label,
                style: TextStyle(color: sectionCfg.color, fontSize: 12.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(width: 6.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
              decoration: BoxDecoration(
                color:        _P.bg.withOpacity(0.6),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(tabCfg.icon, color: _P.text3, size: 10.r),
                SizedBox(width: 3.w),
                Text(tabCfg.label,
                    style: TextStyle(color: _P.text3, fontSize: 10.sp)),
              ]),
            ),
            const Spacer(),
            Text(timeStr,
                style: TextStyle(color: _P.text3, fontSize: 10.sp)),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () => ctrl.deleteEntry(entry.id),
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color:  Colors.red.withOpacity(0.1),
                  shape:  BoxShape.circle,
                ),
                child: Icon(Icons.delete_outline_rounded,
                    color: Colors.red.shade400, size: 14.r),
              ),
            ),
          ]),
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.h),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            // ── Context brief badge ───────────────────────
            if (entry.contextBrief.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color:        const Color(0xFF22D3EE).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                      color: const Color(0xFF22D3EE).withOpacity(0.2)),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.short_text_rounded,
                      color: const Color(0xFF22D3EE), size: 12.r),
                  SizedBox(width: 5.w),
                  Text(entry.contextBrief,
                      style: TextStyle(color: const Color(0xFF22D3EE),
                          fontSize: 11.sp, fontWeight: FontWeight.w600)),
                ]),
              ),
              SizedBox(height: 10.h),
            ],

            // ── Title ─────────────────────────────────────
            Text(entry.title,
                style: TextStyle(color: _P.text1, fontSize: 17.sp,
                    fontWeight: FontWeight.w800, letterSpacing: -0.3)),
            SizedBox(height: 8.h),

            // ── Description ───────────────────────────────
            Text(entry.description,
                style: TextStyle(color: _P.text2, fontSize: 13.sp,
                    height: 1.5),
                maxLines: 3, overflow: TextOverflow.ellipsis),

            // ── Remark ────────────────────────────────────
            if (entry.remark.isNotEmpty) ...[
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color:        const Color(0xFFF59E0B).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                      color: const Color(0xFFF59E0B).withOpacity(0.2)),
                  ),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Icon(Icons.comment_rounded,
                      color: const Color(0xFFF59E0B), size: 13.r),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(entry.remark,
                        style: TextStyle(color: const Color(0xFFF59E0B),
                            fontSize: 12.sp)),
                  ),
                ]),
              ),
            ],

            // ── Criteria chips ────────────────────────────
            if (entry.criteria.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Wrap(spacing: 6.w, runSpacing: 6.h,
                children: entry.criteria.map((c) {
                  final cfg = EngageEntryController.criteriaConfig[c]!;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color:        cfg.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20.r),
                      border:       Border.all(color: cfg.color.withOpacity(0.3)),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(cfg.icon, color: cfg.color, size: 11.r),
                      SizedBox(width: 4.w),
                      Text(cfg.label,
                          style: TextStyle(color: cfg.color, fontSize: 10.sp,
                              fontWeight: FontWeight.w700)),
                    ]),
                  );
                }).toList(),
              ),
            ],

            // ── Attachments row ───────────────────────────
            if (entry.attachments.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color:        _P.surface,
                  borderRadius: BorderRadius.circular(10.r),
                  border:       Border.all(color: _P.border),
                ),
                child: Row(children: [
                  Icon(Icons.attach_file_rounded,
                      color: _P.text3, size: 14.r),
                  SizedBox(width: 6.w),
                  Text('${entry.attachments.length} file${entry.attachments.length > 1 ? "s" : ""} attached',
                      style: TextStyle(color: _P.text3, fontSize: 11.sp)),
                  SizedBox(width: 10.w),
                  ...entry.attachments.take(3).map((f) =>
                    Container(
                      margin: EdgeInsets.only(right: 4.w),
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color:        f.iconColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text('.${f.extension}',
                          style: TextStyle(color: f.iconColor,
                              fontSize: 9.sp, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ]),
              ),
            ],

            // ── Assignees ─────────────────────────────────
            if (entry.assignees.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Row(children: [
                Icon(Icons.people_alt_rounded, color: _P.text3, size: 13.r),
                SizedBox(width: 6.w),
                Text('Assignees',
                    style: TextStyle(color: _P.text3, fontSize: 11.sp)),
                SizedBox(width: 10.w),
                // Stacked avatars
                SizedBox(
                  height: 26.r,
                  width: (entry.assignees.length * 18.0 + 8).clamp(0, 100).w,
                  child: Stack(
                    children: entry.assignees.take(5).toList().asMap().entries.map((e) {
                      return Positioned(
                        left: (e.key * 16.0).w,
                        child: CircleAvatar(
                          radius: 13.r,
                          backgroundColor: _P.card,
                          child: CircleAvatar(
                            radius: 11.r,
                            backgroundColor: e.value.avatarColor,
                            child: Text(e.value.initials,
                                style: TextStyle(color: Colors.white, fontSize: 8.sp,
                                    fontWeight: FontWeight.w800)),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                if (entry.assignees.length > 5) ...[
                  SizedBox(width: 4.w),
                  Text('+${entry.assignees.length - 5} more',
                      style: TextStyle(color: _P.text3, fontSize: 10.sp)),
                ],
              ]),
            ],

          ]),
        ),
      ]),
    );
  }

  String _formatTime(DateTime dt) {
    final now  = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24)   return '${diff.inHours}h ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

// ════════════════════════════════════════════════════════════
//  HELPER WIDGETS
// ════════════════════════════════════════════════════════════
class _FormCard extends StatelessWidget {
  final String   label;
  final IconData icon;
  final Color    iconColor;
  final Widget   child;
  const _FormCard({required this.label, required this.icon,
      required this.iconColor, required this.child});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color:        _P.card,
      borderRadius: BorderRadius.circular(16.r),
      border:       Border.all(color: _P.border),
    ),
    padding: EdgeInsets.all(14.r),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _FieldLabel(label, icon, iconColor),
      SizedBox(height: 10.h),
      child,
    ]),
  );
}

class _FieldLabel extends StatelessWidget {
  final String   text;
  final IconData icon;
  final Color    color;
  const _FieldLabel(this.text, this.icon, this.color);

  @override
  Widget build(BuildContext context) => Row(children: [
    Container(
      padding: EdgeInsets.all(5.r),
      decoration: BoxDecoration(
        color:        color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Icon(icon, color: color, size: 13.r),
    ),
    SizedBox(width: 7.w),
    Text(text, style: TextStyle(color: _P.text1, fontSize: 13.sp,
        fontWeight: FontWeight.w700)),
  ]);
}

class _AIRField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int    maxLines;
  final String? Function(String?)? validator;
  const _AIRField({required this.controller, required this.hint,
      this.maxLines = 1, this.validator});

  @override
  Widget build(BuildContext context) => TextFormField(
    controller:   controller,
    maxLines:     maxLines,
    minLines:     1,
    validator:    validator,
    style:        TextStyle(color: _P.text1, fontSize: 14.sp),
    decoration: InputDecoration(
      hintText:        hint,
      hintStyle:       TextStyle(color: _P.text3, fontSize: 13.sp),
      filled:          true,
      fillColor:       _P.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide:   BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide:   const BorderSide(color: _P.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide:   BorderSide(color: Colors.red.shade400, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide:   BorderSide(color: Colors.red.shade400, width: 1.5),
      ),
      errorStyle:    TextStyle(fontSize: 11.sp, color: Colors.red.shade400),
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
    ),
  );
}
