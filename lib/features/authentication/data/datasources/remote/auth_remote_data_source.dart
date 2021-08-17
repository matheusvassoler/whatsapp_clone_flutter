import 'package:whatsapp/features/authentication/data/models/contact_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> signInWithPhoneNumber(String smsCode);
  Future<void> signOut();
  Future<void> storeContact(ContactModel contactModel);
}