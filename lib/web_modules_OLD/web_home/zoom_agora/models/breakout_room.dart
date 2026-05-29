class BreakoutRoom {
  final String id;
  String name;
  final List<int> participants;
  BreakoutRoom({required this.id, required this.name, List<int>? participants}) : participants = participants ?? [];
}
