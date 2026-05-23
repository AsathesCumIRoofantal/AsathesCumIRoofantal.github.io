// REWRITE — Rich, animated category-tree explorer (showcase variant).
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_rich_widgets.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';

class CategoryTree extends StatefulWidget {
  const CategoryTree({super.key});
  static const String routeName = '/setup-aone/category-tree';
  @override
  State<CategoryTree> createState() => _CategoryTreeState();
}

class _CategoryTreeState extends State<CategoryTree> {
  final Set<String> _open = {'AIR', 'AIR > People'};
  String _selected = 'AIR > People > Operators';

  static const _tree = <_Node>[
    _Node('AIR', Icons.workspaces_outline, [
      _Node('People', Icons.groups_rounded, [
        _Node('Operators', Icons.engineering_rounded, []),
        _Node('Designers', Icons.brush_rounded, []),
        _Node('Reviewers', Icons.rate_review_rounded, []),
      ]),
      _Node('Process', Icons.account_tree_rounded, [
        _Node('Intake', Icons.input_rounded, []),
        _Node('Triage', Icons.merge_type_rounded, []),
        _Node('Delivery', Icons.local_shipping_rounded, []),
      ]),
      _Node('Knowledge', Icons.library_books_rounded, [
        _Node('Playbooks', Icons.menu_book_rounded, []),
        _Node('Datasets', Icons.dataset_rounded, []),
      ]),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF0B1020) : const Color(0xFFF7F8FC);
    final ink = isDark ? Colors.white : const Color(0xFF0F172A);
    const accent = Color(0xFF4F46E5);

    return WebShell(
      currentRoute: CategoryTree.routeName,
      child: Scaffold(
        backgroundColor: bg,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            pinned: true, expandedHeight: 240, backgroundColor: bg,
            flexibleSpace: FlexibleSpaceBar(
              background: GlowBackground(
                colors: const [accent, Color(0xFF7C3AED), Color(0xFF0B1020)],
                child: WMaxWidth(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Reveal(child: Text('CATEGORY TREE',
                          style: TextStyle(color: Colors.white.withValues(alpha: .85), letterSpacing: 3, fontWeight: FontWeight.w700))),
                      const SizedBox(height: 8),
                      Reveal(delayMs: 100, child: Text('A taxonomy that breathes with your org.',
                          style: TextStyle(color: Colors.white, fontSize: WBreak.isMobile(context) ? 26 : 40, fontWeight: FontWeight.w800))),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: WMaxWidth(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 80),
              child: LayoutBuilder(builder: (_, c) {
                final mobile = c.maxWidth < 760;
                final left = Reveal(child: _TreePanel(
                  tree: _tree, open: _open, selected: _selected,
                  onToggle: (k) => setState(() => _open.contains(k) ? _open.remove(k) : _open.add(k)),
                  onSelect: (k) => setState(() => _selected = k),
                  accent: accent, isDark: isDark, ink: ink,
                ));
                final right = Reveal(delayMs: 150, child: _DetailPanel(path: _selected, accent: accent, isDark: isDark, ink: ink));
                if (mobile) return Column(children: [left, const SizedBox(height: 20), right]);
                return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(flex: 4, child: left),
                  const SizedBox(width: 20),
                  Expanded(flex: 6, child: right),
                ]);
              }),
            ),
          ),
        ]),
      ),
    );
  }
}

class _Node {
  final String label;
  final IconData icon;
  final List<_Node> children;
  const _Node(this.label, this.icon, this.children);
}

class _TreePanel extends StatelessWidget {
  final List<_Node> tree;
  final Set<String> open;
  final String selected;
  final void Function(String) onToggle, onSelect;
  final Color accent, ink;
  final bool isDark;
  const _TreePanel({required this.tree, required this.open, required this.selected, required this.onToggle, required this.onSelect, required this.accent, required this.isDark, required this.ink});

  Iterable<Widget> _build(_Node n, String parentPath, int depth) sync* {
    final path = parentPath.isEmpty ? n.label : '$parentPath > ${n.label}';
    final isOpen = open.contains(path);
    final isSel = selected == path;
    yield Padding(
      padding: EdgeInsets.only(left: depth * 18.0, bottom: 4),
      child: HoverLift(
        radius: const BorderRadius.all(Radius.circular(12)),
        lift: 1,
        child: Material(
          color: isSel ? accent.withValues(alpha: .12) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () { onSelect(path); if (n.children.isNotEmpty) onToggle(path); },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(children: [
                if (n.children.isNotEmpty)
                  AnimatedRotation(
                    turns: isOpen ? 0.25 : 0,
                    duration: const Duration(milliseconds: 220),
                    child: Icon(Icons.chevron_right_rounded, color: accent),
                  )
                else
                  const SizedBox(width: 24),
                const SizedBox(width: 4),
                Icon(n.icon, color: isSel ? accent : ink.withValues(alpha: .7), size: 18),
                const SizedBox(width: 10),
                Text(n.label, style: TextStyle(color: isSel ? accent : ink, fontWeight: isSel ? FontWeight.w800 : FontWeight.w600)),
              ]),
            ),
          ),
        ),
      ),
    );
    if (isOpen) for (final c in n.children) yield* _build(c, path, depth + 1);
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF131A35) : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: accent.withValues(alpha: .15)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.account_tree_rounded, color: accent),
            const SizedBox(width: 8),
            Text('Taxonomy', style: TextStyle(color: ink, fontWeight: FontWeight.w800)),
          ]),
          const SizedBox(height: 12),
          for (final n in tree) ..._build(n, '', 0),
        ]),
      );
}

class _DetailPanel extends StatelessWidget {
  final String path;
  final Color accent, ink;
  final bool isDark;
  const _DetailPanel({required this.path, required this.accent, required this.isDark, required this.ink});
  @override
  Widget build(BuildContext context) {
    final parts = path.split(' > ');
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [accent.withValues(alpha: .12), accent.withValues(alpha: .02)]),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: accent.withValues(alpha: .25)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(spacing: 6, runSpacing: 6, children: [
          for (var i = 0; i < parts.length; i++) ...[
            Text(parts[i], style: TextStyle(color: i == parts.length - 1 ? accent : ink.withValues(alpha: .6), fontWeight: FontWeight.w800)),
            if (i < parts.length - 1) Text('›', style: TextStyle(color: ink.withValues(alpha: .4))),
          ],
        ]),
        const SizedBox(height: 14),
        Text(parts.last, style: TextStyle(color: ink, fontSize: 28, fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        Text('A live preview of the selected node. In production this panel can render counts, owners, policies, child nodes, and quick edit actions.',
            style: TextStyle(color: ink.withValues(alpha: .75), height: 1.5)),
        const SizedBox(height: 20),
        Wrap(spacing: 10, runSpacing: 10, children: [
          for (final m in const [['Items', '128'], ['Owners', '6'], ['Policies', '3'], ['Updated', 'today']])
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(color: isDark ? const Color(0xFF131A35) : Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(m[1], style: TextStyle(color: accent, fontWeight: FontWeight.w900)),
                const SizedBox(width: 6),
                Text(m[0], style: TextStyle(color: ink.withValues(alpha: .7))),
              ]),
            ),
        ]),
        const SizedBox(height: 22),
        Row(children: [
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: accent),
            onPressed: () {}, icon: const Icon(Icons.edit_rounded), label: const Text('Edit node'),
          ),
          const SizedBox(width: 10),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(side: BorderSide(color: accent)),
            onPressed: () {}, icon: Icon(Icons.add_rounded, color: accent), label: Text('Add child', style: TextStyle(color: accent)),
          ),
        ]),
      ]),
    );
  }
}
