import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/core/error/exception.dart';
import 'auth_remote_data_source.dart';

const _invalidPhoneNumber = 'invalid-phone-number';

class AuthRemoteDatSourceImpl implements AuthRemoteDataSource {
  String _verificationId = "";
  final FirebaseAuth _auth;

  AuthRemoteDatSourceImpl(this._auth);

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout:  const Duration(seconds: 0),
        verificationCompleted: (authCredential) =>
            _verificationCompleted(authCredential),
        verificationFailed: (authException) =>
            _verificationFailed(authException),
        codeSent: (verificationId, [code]) => _codeSent(verificationId, code),
        codeAutoRetrievalTimeout: (verificationId) =>
            _codeAutoRetrievalTimeout(verificationId));
  }

  @override
  Future<void> signInWithPhoneNumber(String smsCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsCode);

      await _auth.signInWithCredential(credential);
    } catch (e) {
      throw AuthenticationException();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw SignOutException();
    }
  }

  _verificationCompleted(PhoneAuthCredential credential) {
    // Do nothing
  }

  _verificationFailed(FirebaseAuthException e) {
    if (e.code == _invalidPhoneNumber) {
      throw InvalidPhoneException();
    } else {
      throw ServerException();
    }
  }

  _codeSent(String verificationId, [int forceResendingToken]) {
    _verificationId = verificationId;
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    _verificationId = verificationId;
  }
}
