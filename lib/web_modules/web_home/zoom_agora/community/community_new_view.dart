import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'community_controller.dart';
import '../widgets/zoom_theme.dart';

/// Create a new 1-on-1 DM, group chat, or broadcast room.
class CommunityNewView extends StatefulWidget {
  const CommunityNewView({super.key});
  @override
  State<CommunityNewView> createState() => _CommunityNewViewState();
}

class _CommunityNewViewState extends State<CommunityNewView> {
  final _nameCtrl   = TextEditingController();
  final _searchCtrl = TextEditingController();
  String _type      = 'individual';
  final List<Map<String, dynamic>> _selected = [];
  bool _saving = false;

  late final CommunityController _c;

  @override
  void initState() {
    super.initState();
    _c = Get.find<CommunityController>();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    if (_saving) return;
    final name = _type == 'individual' && _selected.length == 1
        ? _selected.first['name'] as String
        : _nameCtrl.text.trim();
    if (name.isEmpty && _type != 'individual') {
      Get.snackbar('Name required', 'Enter a group name.');
      return;
    }
    if (_selected.isEmpty) {
      Get.snackbar('Select people', 'Add at least one person.');
      return;
    }
    setState(() => _saving = true);
    try {
      await _c.createRoom(
        name: name.isEmpty ? 'New group' : name,
        type: _type,
        memberIds: _selected.map((u) => u['user_id'] as String).toList(),
      );
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ZoomTheme.bg,
    appBar: AppBar(
      backgroundColor: ZoomTheme.surface,
      title: const Text('New conversation', style: TextStyle(color: ZoomTheme.text)),
      iconTheme: const IconThemeData(color: ZoomTheme.text),
      elevation: 0,
      actions: [
        TextButton(
          onPressed: _saving ? null : _create,
          child: Text(_saving ? 'Creating…' : 'Create',
              style: TextStyle(color: _saving ? ZoomTheme.textMuted : ZoomTheme.primary,
                  fontWeight: FontWeight.w700)),
        ),
      ],
    ),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      // Type selector
      Row(children: [
        for (final t in [
          ('individual', Icons.person_rounded,   'DM'),
          ('group',      Icons.group_rounded,     'Group'),
          ('broadcast',  Icons.campaign_rounded,  'Broadcast'),
        ])
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: OutlinedButton.icon(
              onPressed: () => setState(() => _type = t.$1),
              icon: Icon(t.$2, size: 16),
              label: Text(t.$3),
              style: OutlinedButton.styleFrom(
                foregroundColor: _type == t.$1 ? ZoomTheme.primary : ZoomTheme.textMuted,
                side: BorderSide(color: _type == t.$1 ? ZoomTheme.primary : ZoomTheme.stroke),
                backgroundColor: _type == t.$1 ? ZoomTheme.primary.withOpacity(.1) : Colors.transparent,
              ),
            ),
          )),
      ]),
      const SizedBox(height: 16),
      // Group name (hidden for DM)
      if (_type != 'individual') ...[
        TextField(
          controller: _nameCtrl,
          style: const TextStyle(color: ZoomTheme.text),
          decoration: InputDecoration(
            labelText: _type == 'group' ? 'Group name' : 'Channel name',
            labelStyle: const TextStyle(color: ZoomTheme.textMuted),
            filled: true, fillColor: ZoomTheme.surface2,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 16),
      ],
      // Selected chips
      if (_selected.isNotEmpty) ...[
        Wrap(spacing: 8, runSpacing: 8, children: _selected.map((u) => Chip(
          backgroundColor: ZoomTheme.primary.withOpacity(.15),
          label: Text(u['name'] as String? ?? '', style: const TextStyle(color: ZoomTheme.primary)),
          deleteIcon: const Icon(Icons.close, size: 14, color: ZoomTheme.primary),
          onDeleted: () => setState(() => _selected.remove(u)),
        )).toList()),
        const SizedBox(height: 12),
      ],
      // Search
      TextField(
        controller: _searchCtrl,
        style: const TextStyle(color: ZoomTheme.text),
        onChanged: (v) => v.length > 1 ? _c.searchUsers(v) : null,
        decoration: InputDecoration(
          hintText: 'Search people by name or mobile…',
          hintStyle: const TextStyle(color: ZoomTheme.textMuted),
          prefixIcon: const Icon(Icons.search, color: ZoomTheme.textMuted, size: 18),
          filled: true, fillColor: ZoomTheme.surface2,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      ),
      const SizedBox(height: 8),
      // Results
      Obx(() => Column(children: _c.searchResults.map((u) {
        final alreadyAdded = _selected.any((s) => s['user_id'] == u['user_id']);
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: ZoomTheme.primary.withOpacity(.2),
            child: Text((u['name'] as String? ?? 'U')[0].toUpperCase(),
                style: const TextStyle(color: ZoomTheme.primary)),
          ),
          title: Text(u['name'] as String? ?? '', style: const TextStyle(color: ZoomTheme.text)),
          subtitle: Text(u['mobile'] as String? ?? '', style: ZoomTheme.muted),
          trailing: alreadyAdded
              ? const Icon(Icons.check_circle, color: ZoomTheme.success)
              : null,
          onTap: () {
            if (!alreadyAdded) setState(() => _selected.add(u));
          },
        );
      }).toList())),
    ]),
  );
}
