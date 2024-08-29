// To parse this JSON data, do
//
//     final loginResponsModel = loginResponsModelFromJson(jsonString);

import 'dart:convert';

LoginResponsModel loginResponsModelFromJson(String str) => LoginResponsModel.fromJson(json.decode(str));

String loginResponsModelToJson(LoginResponsModel data) => json.encode(data.toJson());

class LoginResponsModel {
    final String id;
    final String firstName;
    final String lastName;
    final String email;
    final String fcm;
    final String pin;
    final dynamic otpExpires;
    final bool verification;
    final String phone;
    final bool phoneVerification;
    final String userType;
    final int v;
    final String token;

    LoginResponsModel({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.fcm,
        required this.pin,
        required this.otpExpires,
        required this.verification,
        required this.phone,
        required this.phoneVerification,
        required this.userType,
        required this.v,
        required this.token,
    });

    factory LoginResponsModel.fromJson(Map<String, dynamic> json) => LoginResponsModel(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        fcm: json["fcm"],
        pin: json["pin"],
        otpExpires: json["otpExpires"],
        verification: json["verification"],
        phone: json["phone"],
        phoneVerification: json["phoneVerification"],
        userType: json["userType"],
        v: json["__v"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "fcm": fcm,
        "pin": pin,
        "otpExpires": otpExpires,
        "verification": verification,
        "phone": phone,
        "phoneVerification": phoneVerification,
        "userType": userType,
        "__v": v,
        "token": token,
    };
}
