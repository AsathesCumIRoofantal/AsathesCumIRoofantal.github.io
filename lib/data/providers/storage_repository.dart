import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class StorageRepository {
  final SupabaseClient client;

  StorageRepository(this.client);

  Future<String> uploadFile({
    required String bucket,
    required String path,
    required File file,
  }) async {
    await client.storage
        .from(bucket)
        .upload(path, file, fileOptions: const FileOptions(upsert: true));

    return client.storage.from(bucket).getPublicUrl(path);
  }

  Future<List<String>> uploadFiles({
    required String bucket,
    required Map<String, File> files,
  }) async {
    final urls = <String>[];

    for (final item in files.entries) {
      final path = item.key;

      await client.storage
          .from(bucket)
          .upload(
            path,
            item.value,
            fileOptions: const FileOptions(upsert: true),
          );

      urls.add(client.storage.from(bucket).getPublicUrl(path));
    }

    return urls;
  }

  Future<void> delete({required String bucket, required String path}) async {
    await client.storage.from(bucket).remove([path]);
  }

  String publicUrl({required String bucket, required String path}) {
    return client.storage.from(bucket).getPublicUrl(path);
  }

  Future<String> signedUrl({
    required String bucket,
    required String path,
    int expiresIn = 3600,
  }) {
    return client.storage.from(bucket).createSignedUrl(path, expiresIn);
  }
}
