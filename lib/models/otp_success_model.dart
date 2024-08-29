// To parse this JSON data, do
//
//     final otpSucessModel = otpSucessModelFromJson(jsonString);

import 'dart:convert';

OtpSucessModel otpSucessModelFromJson(String str) => OtpSucessModel.fromJson(json.decode(str));

String otpSucessModelToJson(OtpSucessModel data) => json.encode(data.toJson());

class OtpSucessModel {
    final String id;
    final String firstName;
    final String lastName;
    final String email;
    final String fcm;
    final String password;
    final String pin;
    final dynamic otpExpires;
    final bool verification;
    final String phone;
    final bool phoneVerification;
    final String userType;
    final DateTime updatedAt;
    final int v;
    final String userToken;
    final bool status;
    final String message;

    OtpSucessModel({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.fcm,
        required this.password,
        required this.pin,
        required this.otpExpires,
        required this.verification,
        required this.phone,
        required this.phoneVerification,
        required this.userType,
        required this.updatedAt,
        required this.v,
        required this.userToken,
        required this.status,
        required this.message,
    });

    factory OtpSucessModel.fromJson(Map<String, dynamic> json) => OtpSucessModel(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        fcm: json["fcm"],
        password: json["password"],
        pin: json["pin"],
        otpExpires: json["otpExpires"],
        verification: json["verification"],
        phone: json["phone"],
        phoneVerification: json["phoneVerification"],
        userType: json["userType"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        userToken: json["userToken"],
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "fcm": fcm,
        "password": password,
        "pin": pin,
        "otpExpires": otpExpires,
        "verification": verification,
        "phone": phone,
        "phoneVerification": phoneVerification,
        "userType": userType,
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "userToken": userToken,
        "status": status,
        "message": message,
    };
}
