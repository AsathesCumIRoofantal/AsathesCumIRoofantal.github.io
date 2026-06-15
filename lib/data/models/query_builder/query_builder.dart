class QueryBuilder {
  final Map<String, dynamic> filters = {};

  int page = 1;
  int limit = 20;

  String? orderBy;
  bool ascending = true;

  QueryBuilder where(String key, dynamic value) {
    filters[key] = value;
    return this;
  }

  QueryBuilder paginate({required int page, required int limit}) {
    this.page = page;
    this.limit = limit;
    return this;
  }

  QueryBuilder order(String field, {bool ascending = true}) {
    orderBy = field;
    this.ascending = ascending;
    return this;
  }
}
