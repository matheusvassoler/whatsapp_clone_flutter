import 'package:hive_flutter/hive_flutter.dart';
import 'package:whatsapp/features/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:whatsapp/features/authentication/data/models/contact_model.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveInterface hive;

  AuthLocalDataSourceImpl(this.hive);

  @override
  Future<void> storeContact(ContactModel contactModel) async {
    final contactBox = await hive.openBox('contact');
    contactBox.put(contactModel.phoneNumber, contactModel);
  }
}