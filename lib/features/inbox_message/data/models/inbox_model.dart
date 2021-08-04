import 'package:flutter/cupertino.dart';
import 'package:whatsapp/features/inbox_message/domain/entities/inbox.dart';

class InboxModel extends Inbox {
  InboxModel({
    @required String receiptName,
    @required String receiptProfilePicture,
    @required String lastMessage,
    @required String messageDate
  }) : super(receiptName: receiptName, receiptProfilePicture: receiptProfilePicture, lastMessage: lastMessage, messageDate: messageDate);

  static InboxModel fromJson(Map<String, dynamic> json) {
    return InboxModel(
      receiptName: json['receiptName'],
      receiptProfilePicture: json['pictureInbox'],
      lastMessage: json['lastMessage'],
      messageDate: json['dateOfLastMessage']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lastMessage": lastMessage,
      "dateOfLastMessage": messageDate,
      "receiptName": receiptName,
      "pictureInbox": receiptProfilePicture,
    };
  }
}