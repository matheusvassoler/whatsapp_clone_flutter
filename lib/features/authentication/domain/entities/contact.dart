import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Contact extends Equatable {
  final String phoneNumber;
  final String name;
  final String picture;
  final String deviceId;

  Contact({
    @required this.phoneNumber,
    @required this.name,
    @required this.picture,
    @required this.deviceId
  });

  @override
  List<Object> get props => [phoneNumber];
}