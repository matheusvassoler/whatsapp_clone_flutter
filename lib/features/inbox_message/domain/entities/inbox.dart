import 'package:flutter/cupertino.dart';

class Inbox {
  final String receiptName;
  final String receiptProfilePicture;
  final String lastMessage;
  final String messageDate;

  Inbox({
    @required this.receiptName,
    @required this.receiptProfilePicture,
    @required this.lastMessage,
    @required this.messageDate
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Inbox &&
          runtimeType == other.runtimeType &&
          receiptName == other.receiptName &&
          receiptProfilePicture == other.receiptProfilePicture &&
          lastMessage == other.lastMessage &&
          messageDate == other.messageDate;

  @override
  int get hashCode =>
      receiptName.hashCode ^
      receiptProfilePicture.hashCode ^
      lastMessage.hashCode ^
      messageDate.hashCode;
}