abstract class AuthRemoteDataSource {
  Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> signInWithPhoneNumber(String smsCode);
  Future<void> signOut();
}