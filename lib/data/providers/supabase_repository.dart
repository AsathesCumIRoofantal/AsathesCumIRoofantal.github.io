import 'package:air_app/data/models/api_response.dart';
import 'package:air_app/data/models/query_builder/query_builder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRepository {
  final SupabaseClient client;

  SupabaseRepository(this.client);

  Future<ApiResponse<List<Map<String, dynamic>>>> find({
    required String table,
    QueryBuilder? query,
  }) async {
    try {
      dynamic req = client.from(table).select();

      if (query != null) {
        query.filters.forEach((key, value) {
          req = req.eq(key, value);
        });

        if (query.orderBy != null) {
          req = req.order(query.orderBy!, ascending: query.ascending);
        }

        final from = (query.page - 1) * query.limit;

        final to = from + query.limit - 1;

        req = req.range(from, to);
      }

      final result = await req;

      return ApiResponse.success(List<Map<String, dynamic>>.from(result));
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> insert({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      final result = await client.from(table).insert(data).select().single();

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> upsert({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      final result = await client.from(table).upsert(data).select().single();

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  Future<ApiResponse<void>> update({
    required String table,
    required Map<String, dynamic> match,
    required Map<String, dynamic> data,
  }) async {
    try {
      dynamic req = client.from(table).update(data);

      match.forEach((k, v) {
        req = req.eq(k, v);
      });

      await req;

      return ApiResponse.success(null);
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  Future<ApiResponse<void>> delete({
    required String table,
    required Map<String, dynamic> match,
  }) async {
    try {
      dynamic req = client.from(table).delete();

      match.forEach((k, v) {
        req = req.eq(k, v);
      });

      await req;

      return ApiResponse.success(null);
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  Future<ApiResponse<int>> count({required String table}) async {
    try {
      final result = await client.from(table).select('*');

      return ApiResponse.success(result.length);
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }
}
