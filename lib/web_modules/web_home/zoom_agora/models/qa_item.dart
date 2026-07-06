class QAItem {
  final String id;
  final int fromUid;
  final String fromName;
  final String question;
  String? answerText;
  int? answeredByUid;
  bool answeredLive;
  bool dismissed;
  Set<int> upvotes;
  QAItem({required this.id,required this.fromUid,required this.fromName,required this.question,this.answerText,this.answeredByUid,this.answeredLive=false,this.dismissed=false,Set<int>? upvotes}) : upvotes = upvotes ?? {};

  Map<String, dynamic> toJson() => {
    'id': id, 'fromUid': fromUid, 'fromName': fromName, 'question': question,
    'answerText': answerText, 'answeredByUid': answeredByUid,
    'answeredLive': answeredLive, 'dismissed': dismissed,
  };
  factory QAItem.fromJson(Map<String, dynamic> j) => QAItem(
    id: j['id'] as String,
    fromUid: j['fromUid'] as int,
    fromName: j['fromName'] as String,
    question: j['question'] as String,
    answerText: j['answerText'] as String?,
    answeredByUid: j['answeredByUid'] as int?,
    answeredLive: j['answeredLive'] as bool? ?? false,
    dismissed: j['dismissed'] as bool? ?? false,
  );
}
