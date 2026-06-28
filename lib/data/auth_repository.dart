import 'dart:convert';

import 'package:air_app/data/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'models/user_model.dart';

class AuthRepository {
  final SupabaseClient _client;

  AuthRepository(this._client);

  static const String table = 'user_table';

  Future<AirUser?> getUserById(String userId) async {
    final response = await _client
        .from("user_table")
        .select()
        .eq('auth_user_id', userId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return AirUser.fromJson(response);
  }

  Future<AirUser?> getUserByMobile(String mobile) async {
    final response = await _client
        .from(table)
        .select()
        .eq('mobile', mobile)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return AirUser.fromJson(response);
  }

  Future<AirUser?> getUserByUserID(String userID) async {
    final response = await _client
        .from(table)
        .select()
        .eq('user_id', userID)
        .eq("isMember", 1)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return AirUser.fromJson(response);
  }

  Future<String?> getSignupToken() async {
    final response = await _client
        .from("user_signup_token_for_today")
        .select("title")
        // .eq('date', DateTime.now().toString().split(" ")[0])
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return response['title'];
  }

  Future<List<AirUser>> getUsers({int page = 1, int limit = 20}) async {
    final from = (page - 1) * limit;

    final to = from + limit - 1;

    final response = await _client
        .from(table)
        .select()
        .range(from, to)
        .order('created_at', ascending: false);

    return response.map<AirUser>((e) => AirUser.fromJson(e)).toList();
  }

  Future<List<AirUser>> searchUsers(String keyword) async {
    final response = await _client
        .from(table)
        .select()
        .or('name.ilike.%$keyword%,mobile.ilike.%$keyword%');

    return response.map<AirUser>((e) => AirUser.fromJson(e)).toList();
  }

  Future<bool> createLoginLogsWithFunctionHitByMap(
    Map<String, dynamic> dict,
  ) async {
    try {
      // print("DICT = $dict");
      // print("JSON = ${jsonEncode(dict)}");
      final response = await Supabase.instance.client.functions.invoke(
        'createLoginLogsWithFunctionHitByMapOnLogin-out',
        body: dict, // jsonEncode(dict),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.status);
      print(response.data);

      debugPrint("=============> ${response.data}");
      return true;
    } catch (e) {
      debugPrint("=============> ${e.toString()}");

      // Get.snackbar(
      //   'Error',
      //   '${e.toString()}',
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.redAccent.withValues(alpha: 0.6),
      //   colorText: Colors.white,
      // );

      return false;
    }
  }

  Future<AirUser> createUser(AirUser user) async {
    final response = await _client
        .from(table)
        .insert(user.toJson())
        .select()
        .single();

    return AirUser.fromJson(response);
  }

  Future<AirUser> createUserByMap(Map<String, dynamic> user) async {
    final response = await _client
        .from("user_table")
        .insert(user)
        .select()
        .single();

    return AirUser.fromJson(response);
  }

  Future<AirUser> updateUser(AirUser user) async {
    final response = await _client
        .from(table)
        .update(user.toJson())
        .eq('user_id', user.userId)
        .select()
        .single();

    return AirUser.fromJson(response);
  }

  Future<void> deleteUser(String userId) async {
    await _client.from(table).delete().eq('user_id', userId);
  }

  Future<void> activateUser(String userId) async {
    await _client.from(table).update({'is_active': 1}).eq('user_id', userId);
  }

  Future<void> deactivateUser(String userId) async {
    await _client.from(table).update({'is_active': 0}).eq('user_id', userId);
  }

  Future<void> approveUser(String userId) async {
    await _client.from(table).update({'is_approved': 1}).eq('user_id', userId);
  }

  Future<void> blockUser(String userId) async {
    await _client.from(table).update({'is_blocked': 1}).eq('user_id', userId);
  }

  Future<void> unblockUser(String userId) async {
    await _client.from(table).update({'is_blocked': 0}).eq('user_id', userId);
  }

  Future<void> updateFcmToken({
    required String userId,
    required String token,
  }) async {
    await _client
        .from(table)
        .update({'fcm_token': token})
        .eq('user_id', userId);
  }

  Future<void> updateLocation({
    required String userId,
    required double latitude,
    required double longitude,
  }) async {
    await _client
        .from(table)
        .update({'latitude': latitude, 'longitude': longitude})
        .eq('user_id', userId);
  }

  Future<void> assignUsers({
    required String userId,
    required List<String> assignedIds,
  }) async {
    await _client
        .from(table)
        .update({'assigned_user_ids': assignedIds})
        .eq('user_id', userId);
  }

  Future<void> changeRole({required String userId, required int roleId}) async {
    await _client
        .from(table)
        .update({'user_role': roleId})
        .eq('user_id', userId);
  }
}
