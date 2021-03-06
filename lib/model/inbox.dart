class Inbox {
  int id;
  String lastMessage;
  String hashCodeId;
  String dateOfLastMessage;
  String receiptName;
  String picture;
  String receiptNumber;

  Inbox(
      {this.id,
        this.lastMessage,
        this.hashCodeId,
        this.dateOfLastMessage,
        this.receiptName,
        this.picture,
        this.receiptNumber});

  Inbox.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastMessage = json['lastMessage'];
    hashCodeId = json['hashCode'];
    dateOfLastMessage = json['dateOfLastMessage'];
    receiptName = json['receiptName'];
    picture = json["pictureInbox"];
    receiptNumber = json["receiptNumber"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lastMessage'] = this.lastMessage;
    data['hashCode'] = this.hashCode;
    data['dateOfLastMessage'] = this.dateOfLastMessage;
    data['receiptName'] = this.receiptName;
    data['pictureInbox'] = this.picture;
    data['receiptNumber'] = this.receiptNumber;
    return data;
  }
}