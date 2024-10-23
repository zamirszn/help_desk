// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? email;
  final String? fullName;
  final String? userRole;
  UserModel({
    required this.email,
    required this.fullName,
    required this.userRole,
  });

  UserModel copyWith({
    String? email,
    String? fullName,
    String? userRole,
  }) {
    return UserModel(
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      userRole: userRole ?? this.userRole,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'fullName': fullName,
      'userRole': userRole,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      userRole: map['userRole'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

// store fakeUser obj here

UserModel? userModel;
