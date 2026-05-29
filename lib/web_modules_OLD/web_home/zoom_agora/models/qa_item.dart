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
}
