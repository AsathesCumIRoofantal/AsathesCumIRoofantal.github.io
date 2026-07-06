import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'zoom_meeting_controller.dart';

class BreakoutPanel extends GetView<ZoomMeetingController> {
  const BreakoutPanel({super.key});

  @override
  Widget build(BuildContext c) {
    final broadcastInput = TextEditingController();
    return Container(width:360, color: const Color(0xFF2C2C2E), child: Column(children:[
      const ListTile(title: Text('Breakout Rooms', style: TextStyle(color: Colors.white))),
      ButtonBar(children:[
        TextButton(onPressed: ()=>controller.createBreakouts(3, auto:true),  child: const Text('Create 3 (auto)')),
        TextButton(onPressed: ()=>controller.createBreakouts(2, auto:false), child: const Text('Create 2 (manual)')),
      ]),
      Expanded(child: Obx(() {
        if (controller.breakouts.isEmpty) {
          return const Center(child: Padding(
            padding: EdgeInsets.all(24),
            child: Text('No breakout rooms yet.', style: TextStyle(color: Colors.white38)),
          ));
        }
        final assignedUids = controller.breakouts.expand((r) => r.participants).toSet();
        final unassigned = controller.participants.keys.where((u) => !assignedUids.contains(u)).toList();
        return ListView(children: [
          ...controller.breakouts.map((r) => ExpansionTile(
            collapsedTextColor: Colors.white, textColor: Colors.white,
            initiallyExpanded: true,
            title: Text('${r.name} (${r.participants.length})'),
            children: r.participants.map((uid) => ListTile(
              dense: true,
              title: Text(controller.participants[uid]?.name ?? 'uid $uid', style: const TextStyle(color: Colors.white70)),
              trailing: IconButton(
                icon: const Icon(Icons.close, size: 16, color: Colors.white38),
                onPressed: () { r.participants.remove(uid); controller.breakouts.refresh(); },
              ),
            )).toList(),
          )),
          if (unassigned.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text('Not yet assigned', style: TextStyle(color: Colors.white38, fontSize: 12)),
            ),
            ...unassigned.map((uid) => ListTile(
              dense: true,
              title: Text(controller.participants[uid]?.name ?? 'uid $uid', style: const TextStyle(color: Colors.white)),
              trailing: PopupMenuButton<String>(
                icon: const Icon(Icons.add_circle_outline, color: Colors.white70),
                itemBuilder: (_) => controller.breakouts
                    .map((r) => PopupMenuItem(value: r.id, child: Text(r.name)))
                    .toList(),
                onSelected: (roomId) {
                  controller.breakouts.firstWhere((r) => r.id == roomId).participants.add(uid);
                  controller.breakouts.refresh();
                },
              ),
            )),
          ],
        ]);
      })),
      Padding(
        padding: const EdgeInsets.all(8),
        child: FilledButton.icon(
          icon: const Icon(Icons.meeting_room_outlined),
          label: const Text('Open rooms — move everyone now'),
          onPressed: controller.dispatchBreakoutAssignments,
        ),
      ),
      Padding(padding: const EdgeInsets.fromLTRB(8, 0, 8, 8), child: Row(children:[
        Expanded(child: TextField(
          controller: broadcastInput,
          decoration: const InputDecoration(hintText:'Broadcast message…', hintStyle: TextStyle(color: Colors.white38)),
          style: const TextStyle(color: Colors.white),
          onSubmitted: (text) {
            if (text.trim().isEmpty) return;
            controller.broadcastToBreakouts(text);
            Get.snackbar('Not available yet',
              "Broadcasting into every breakout room at once isn't wired up "
              "yet — see broadcastToBreakouts() in the controller.");
            broadcastInput.clear();
          },
        )),
        IconButton(onPressed: ()=>controller.closeBreakouts(), icon: const Icon(Icons.close, color: Colors.white)),
      ])),
    ]));
  }
}
