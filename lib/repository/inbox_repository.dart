import 'package:dio/dio.dart';
import 'package:whatsapp/model/inbox.dart';

class InboxRepository {
  Future<List<Inbox>> fetchInbox(String contactId) async {
    Response response = await Dio().get('http://192.168.15.93:8080/inbox', queryParameters: {"contactId": contactId});
    return (response.data as List).map((item) => Inbox.fromJson(item)).toList();
  }
}