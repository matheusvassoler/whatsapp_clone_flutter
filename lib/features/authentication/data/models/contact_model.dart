class ContactModel {
  String phoneNumber;
  String name;
  String picture;
  String deviceId;

  ContactModel({this.phoneNumber, this.name, this.picture, this.deviceId});

  ContactModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    name = json['name'];
    picture = json['picture'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['name'] = this.name;
    data['picture'] = this.picture;
    data['deviceId'] = this.deviceId;
    return data;
  }
}