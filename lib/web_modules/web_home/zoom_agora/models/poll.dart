enum PollType { single, multi, shortAnswer }
class PollOption {
  final String id, text; int votes;
  PollOption(this.id,this.text,[this.votes=0]);
  Map<String, dynamic> toJson() => {'id': id, 'text': text, 'votes': votes};
  factory PollOption.fromJson(Map<String, dynamic> j) => PollOption(j['id'] as String, j['text'] as String, j['votes'] as int? ?? 0);
}
class Poll {
  final String id;
  final String question;
  final PollType type;
  final List<PollOption> options;
  bool launched;
  bool closed;
  final Map<int,List<String>> answers; // uid -> optionIds (or [shortAnswerText])
  Poll({required this.id,required this.question,required this.type,required this.options,this.launched=false,this.closed=false,Map<int,List<String>>? answers}) : answers = answers ?? {};

  Map<String, dynamic> toJson() => {
    'id': id, 'question': question, 'type': type.name,
    'options': options.map((o) => o.toJson()).toList(),
    'launched': launched, 'closed': closed,
  };
  factory Poll.fromJson(Map<String, dynamic> j) => Poll(
    id: j['id'] as String,
    question: j['question'] as String,
    type: PollType.values.firstWhere((t) => t.name == j['type'], orElse: () => PollType.single),
    options: (j['options'] as List).map((o) => PollOption.fromJson(o as Map<String, dynamic>)).toList(),
    launched: j['launched'] as bool? ?? true,
    closed: j['closed'] as bool? ?? false,
  );
}
