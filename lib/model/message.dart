import 'contact.dart';

class Message {
  int id = 0;
  String content = "";
  String sendDate = "";
  Contact sender = Contact();
  Contact receipt = Contact();

  Message({this.id, this.content, this.sendDate, this.sender, this.receipt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    sendDate = json['sendDate'];
    sender =
    json['sender'] != null ? new Contact.fromJson(json['sender']) : null;
    receipt =
    json['receipt'] != null ? new Contact.fromJson(json['receipt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['sendDate'] = this.sendDate;
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    if (this.receipt != null) {
      data['receipt'] = this.receipt.toJson();
    }
    return data;
  }
}