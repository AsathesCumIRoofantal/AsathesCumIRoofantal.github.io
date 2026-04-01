class QueryModel {
  final String id;
  final String subject;
  final String description;
  final DateTime dateSubmitted;
  final List<String> attachedFiles;
  final String status;

  QueryModel({
    required this.id,
    required this.subject,
    required this.description,
    required this.dateSubmitted,
    this.attachedFiles = const [],
    this.status = 'Pending',
  });
}
