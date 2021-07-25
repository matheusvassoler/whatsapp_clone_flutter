import 'package:dio/dio.dart';
import 'package:whatsapp/model/contact.dart';


class ContactRepository {
  Future<List<Contact>> fetchContact() async {
    Response response = await Dio().get('http://192.168.0.10:8080/contact', queryParameters: {"sort": "ASC"});
    return (response.data as List).map((item) => Contact.fromJson(item)).toList();
  }
}