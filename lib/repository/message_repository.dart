import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:whatsapp/model/message.dart';

class MessageRepository {
  Future<List<Message>> fetchMessagesBetweenTwoContacts(String senderNumber, String receiptNumber) async {
    Response response = await Dio().get('http://192.168.0.10:8080/message', queryParameters: {'senderNumber': senderNumber, 'receiptNumber': receiptNumber});
    return (response.data as List).map((item) => Message.fromJson(item)).toList();
  }

  Future<void> sendMessage(String content, String senderNumber, String receiptNumber) async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["content"] = content;
    data["senderNumber"] = senderNumber;
    data["receiptNumber"] = receiptNumber;
    final String messageJson = jsonEncode(data);
    await Dio().post('http://192.168.0.10:8080/message', data: messageJson);
  }
}