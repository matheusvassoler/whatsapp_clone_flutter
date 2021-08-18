import 'package:whatsapp/features/authentication/data/models/contact_model.dart';

abstract class AuthLocalDataSource {
  Future<void> storeContact(ContactModel contactModel);
}