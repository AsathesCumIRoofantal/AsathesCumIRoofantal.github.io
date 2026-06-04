enum PollType { single, multi, shortAnswer }
class PollOption { final String id, text; int votes; PollOption(this.id,this.text,[this.votes=0]); }
class Poll {
  final String id;
  final String question;
  final PollType type;
  final List<PollOption> options;
  bool launched;
  bool closed;
  final Map<int,List<String>> answers; // uid -> optionIds (or [shortAnswerText])
  Poll({required this.id,required this.question,required this.type,required this.options,this.launched=false,this.closed=false,Map<int,List<String>>? answers}) : answers = answers ?? {};
}
