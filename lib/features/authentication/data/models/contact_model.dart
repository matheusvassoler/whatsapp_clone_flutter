import 'package:hive/hive.dart';
import 'package:whatsapp/features/authentication/domain/entities/contact.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 1)
class ContactModel extends Contact {
  @HiveField(0)
  final String phoneNumber;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String picture;

  @HiveField(3)
  final String deviceId;

  ContactModel({this.phoneNumber, this.name, this.picture, this.deviceId})
      : super(
          phoneNumber: phoneNumber,
          name: name,
          picture: picture,
          deviceId: deviceId,
        );

  static ContactModel fromJson(Map<String, dynamic> json) {
    return ContactModel(
        phoneNumber: json['phoneNumber'],
        name: json['name'],
        picture: json['picture'],
        deviceId: json['deviceId']);
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
