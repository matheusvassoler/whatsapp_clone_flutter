import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp/features/inbox_message/data/models/inbox_model.dart';
import 'package:whatsapp/features/inbox_message/domain/entities/inbox.dart';

import '../../../../mocks/mock_reader.dart';

void main() {
  final inboxModel = [InboxModel(receiptName: "Lucas", receiptProfilePicture: "picture", lastMessage: "Message", messageDate: "10:40")];

  test('SHOULD be a subclass of Inbox entity', () async {
    // THEN
    expect(inboxModel, isA<Inbox>());
  });

  group('fromJson', () {
    test('SHOULD return a valid model when the JSON number is an integer', () async {
      // GIVEN
      final jsonMap = json.decode(mock("inbox.json")) as List;
      final result = jsonMap.map((item) => InboxModel.fromJson(item)).toList();
      //final result = InboxModel.fromJson(jsonMap);
      expect(result, inboxModel);
    });
  });

  group('toJson', () {
    test('SHOULD return a valid model when the JSON number is an integer', () async {
      final result = inboxModel[0].toJson();
      final expectedMap = {
        "lastMessage": "Message",
        "dateOfLastMessage": "10:40",
        "receiptName": "Lucas",
        "pictureInbox": "picture",
      };
      expect(result, expectedMap);
    });
  });
}