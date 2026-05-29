import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/meeting.dart';
import '../services/calendar_service.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});
  @override State<ScheduleView> createState()=>_S();
}
class _S extends State<ScheduleView>{
  final title=TextEditingController(text:'New Meeting');
  DateTime when=DateTime.now().add(const Duration(hours:1));
  Duration duration=const Duration(hours:1);
  bool waiting=true, muteOnEntry=true, record=false, webinar=false;
  final pass=TextEditingController();
  @override Widget build(BuildContext c)=>Scaffold(
    backgroundColor: const Color(0xFF1C1C1E),
    appBar: AppBar(title: const Text('Schedule')),
    body: ListView(padding: const EdgeInsets.all(16), children:[
      TextField(controller:title, decoration: const InputDecoration(labelText:'Topic')),
      ListTile(title: const Text('Start'), subtitle: Text(when.toString()),
        trailing: const Icon(Icons.edit_calendar), onTap: () async {
          final d = await showDatePicker(context:c, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days:365)), initialDate: when);
          if (d==null) return;
          final t = await showTimePicker(context:c, initialTime: TimeOfDay.fromDateTime(when));
          if (t==null) return;
          setState(()=>when = DateTime(d.year,d.month,d.day,t.hour,t.minute));
        }),
      DropdownButtonFormField<Duration>(value: duration,
        items: const [Duration(minutes:30),Duration(hours:1),Duration(hours:2)]
          .map((d)=>DropdownMenuItem(value:d, child: Text('${d.inMinutes} min'))).toList(),
        onChanged:(v)=>setState(()=>duration=v!), decoration: const InputDecoration(labelText:'Duration')),
      TextField(controller:pass, decoration: const InputDecoration(labelText:'Passcode')),
      SwitchListTile(title: const Text('Waiting room'),  value:waiting, onChanged:(v)=>setState(()=>waiting=v)),
      SwitchListTile(title: const Text('Mute on entry'), value:muteOnEntry, onChanged:(v)=>setState(()=>muteOnEntry=v)),
      SwitchListTile(title: const Text('Record automatically'), value:record, onChanged:(v)=>setState(()=>record=v)),
      SwitchListTile(title: const Text('Webinar mode'),  value:webinar, onChanged:(v)=>setState(()=>webinar=v)),
      const SizedBox(height:16),
      FilledButton(onPressed: () {
        final m = Meeting(id: DateTime.now().millisecondsSinceEpoch.toString().substring(0,11),
          title: title.text, hostUid: 'me', startAt: when, duration: duration,
          passcode: pass.text.isEmpty?null:pass.text, waitingRoom: waiting,
          muteOnEntry: muteOnEntry, recordOnStart: record, isWebinar: webinar);
        final ics = CalendarService().toIcs(m);
        Get.dialog(AlertDialog(
          title: const Text('Scheduled'),
          content: SelectableText('Share: ${m.shareLink}\n\n.ics:\n$ics'),
          actions:[TextButton(onPressed: Get.back, child: const Text('OK'))]));
      }, child: const Text('Save & Generate Invite')),
    ]),
  );
}
