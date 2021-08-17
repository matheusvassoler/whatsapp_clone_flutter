import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:whatsapp/core/error/exception.dart';
import 'package:whatsapp/features/authentication/data/models/contact_model.dart';
import '../uri_requests.dart';
import 'auth_remote_data_source.dart';

const _invalidPhoneNumber = 'invalid-phone-number';
const _created = 201;
const _updated = 200;

class AuthRemoteDatSourceImpl implements AuthRemoteDataSource {
  String _verificationId = "";
  final FirebaseAuth auth;
  final Dio client;

  AuthRemoteDatSourceImpl({@required this.auth, @required this.client});

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await auth.verifyPhoneNumber(
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

      await auth.signInWithCredential(credential);
    } catch (e) {
      throw AuthenticationException();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw SignOutException();
    }
  }

  @override
  Future<void> storeContact(ContactModel contactModel) async {
    final contactJson = jsonEncode(contactModel);
    final response = await client.post(UriRequests.contact, data: contactJson);
    if(response.statusCode != _created && response.statusCode != _updated) {
      throw ServerException();
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
