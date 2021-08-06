import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/core/error/exceptions.dart';
import 'package:whatsapp/features/inbox_message/data/models/inbox_model.dart';

abstract class InboxLocalDataSource {
  Future<List<InboxModel>> getLastInboxes();
  Future<void> cacheInboxes(List<InboxModel> inboxesToCache);
}

const CACHED_INBOXES = 'CACHED_INBOXES';

class InboxLocalDataSourceImpl implements InboxLocalDataSource {
  final SharedPreferences sharedPreferences;

  InboxLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheInboxes(List<InboxModel> inboxesToCache) {
    return sharedPreferences.setString(CACHED_INBOXES, json.encode(inboxesToCache[0].toJson()));
  }

  @override
  Future<List<InboxModel>> getLastInboxes() {
    final jsonString = sharedPreferences.getString(CACHED_INBOXES);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      return Future.value(jsonMap.map((item) => InboxModel.fromJson(item)).toList());
    } else {
      throw CacheException();
    }
  }

}