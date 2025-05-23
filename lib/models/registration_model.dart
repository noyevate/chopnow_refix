// To parse this JSON data, do
//
//     final registrationModel = registrationModelFromJson(jsonString);

import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) => RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) => json.encode(data.toJson());

class RegistrationModel {
    final String firstName;
    final String lastName;
    final String phone;
    final String email;

    RegistrationModel({
        required this.firstName,
        required this.lastName,
        required this.phone,
        required this.email,
    });

    factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
    };
}
