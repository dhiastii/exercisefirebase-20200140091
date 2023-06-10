import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  String? id;
  final String name;
  final String phone;
  final String email;
  final String address;
  ContactModel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static fromDocumentSnapshot(DocumentSnapshot<Object?> data) {}
}
