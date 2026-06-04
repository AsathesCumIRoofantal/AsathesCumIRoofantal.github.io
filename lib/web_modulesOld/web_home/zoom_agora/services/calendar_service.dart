import '../models/meeting.dart';
/// Google + Outlook + .ics export
class CalendarService {
  /// Generates an RFC-5545 .ics file body for the meeting.
  String toIcs(Meeting m) {
    final dt = (DateTime d) => d.toUtc().toIso8601String().replaceAll(RegExp(r'[-:]'),'').split('.').first+'Z';
    final end = m.startAt.add(m.duration ?? const Duration(hours:1));
    return '''BEGIN:VCALENDAR
VERSION:2.0
BEGIN:VEVENT
UID:${m.id}@meet.example.com
SUMMARY:${m.title}
DTSTART:${dt(m.startAt)}
DTEND:${dt(end)}
URL:${m.shareLink}
DESCRIPTION:Join: ${m.shareLink}\\nPasscode: ${m.passcode ?? '-'}
END:VEVENT
END:VCALENDAR''';
  }
  // TODO(backend): OAuth flows for Google & Microsoft Graph; createEvent()
  Future<void> pushToGoogle(Meeting m) async {}
  Future<void> pushToOutlook(Meeting m) async {}
}
