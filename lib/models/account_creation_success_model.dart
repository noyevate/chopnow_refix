// To parse this JSON data, do
//
//     final accountCreationSuccessModel = accountCreationSuccessModelFromJson(jsonString);

import 'dart:convert';

AccountCreationSuccessModel accountCreationSuccessModelFromJson(String str) => AccountCreationSuccessModel.fromJson(json.decode(str));

String accountCreationSuccessModelToJson(AccountCreationSuccessModel data) => json.encode(data.toJson());

class AccountCreationSuccessModel {
    final bool status;
    final String message;
    final User user;

    AccountCreationSuccessModel({
        required this.status,
        required this.message,
        required this.user,
    });

    factory AccountCreationSuccessModel.fromJson(Map<String, dynamic> json) => AccountCreationSuccessModel(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
    };
}

class User {
    final String id;
    final String firstName;
    final String lastName;
    final String phone;
    final String email;

    User({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.phone,
        required this.email,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
    };
}
