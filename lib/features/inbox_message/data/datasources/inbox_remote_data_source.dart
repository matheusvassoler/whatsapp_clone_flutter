import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:whatsapp/core/error/exceptions.dart';
import 'package:whatsapp/features/inbox_message/data/models/inbox_model.dart';

abstract class InboxRemoteDataSource {
  Future<List<InboxModel>> getInboxes(String inboxOwnerNumber);
}

class InboxRemoteDataSourceImpl implements InboxRemoteDataSource {
  final Dio client;

  InboxRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<InboxModel>> getInboxes(String inboxOwnerNumber) async {
    final response = await client.get("http://192.168.0.10:8080/inbox", queryParameters: {"contactId": inboxOwnerNumber});

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.data) as List;
      return jsonMap.map((item) => InboxModel.fromJson(item)).toList();
    } else {
      throw ServerException();
    }
  }

}