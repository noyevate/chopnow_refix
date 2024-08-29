// To parse this JSON data, do
//
//     final singleRestaurantModel = singleRestaurantModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SingleRestaurantModel singleRestaurantModelFromJson(String str) => SingleRestaurantModel.fromJson(json.decode(str));

String singleRestaurantModelToJson(SingleRestaurantModel data) => json.encode(data.toJson());

class SingleRestaurantModel {
    final Coords coords;
    final String id;
    final String title;
    final String time;
    final String imageUrl;
    final List<String> foods;
    final bool pickup;
    final bool delivery;
    final bool isAvailabe;
    final String owner;
    final String code;
    final String logoUrl;
    final String userId;
    final double rating;
    final String ratingCount;
    final String verification;
    final String verificationMessage;
    final List<RestaurantCategory> restaurantCategories;
    final DateTime createdAt;
    final DateTime updatedAt;

    SingleRestaurantModel({
        required this.coords,
        required this.id,
        required this.title,
        required this.time,
        required this.imageUrl,
        required this.foods,
        required this.pickup,
        required this.delivery,
        required this.isAvailabe,
        required this.owner,
        required this.code,
        required this.logoUrl,
        required this.userId,
        required this.rating,
        required this.ratingCount,
        required this.verification,
        required this.verificationMessage,
        required this.restaurantCategories,
        required this.createdAt,
        required this.updatedAt,
    });

    factory SingleRestaurantModel.fromJson(Map<String, dynamic> json) => SingleRestaurantModel(
        coords: Coords.fromJson(json["coords"]),
        id: json["_id"],
        title: json["title"],
        time: json["time"],
        imageUrl: json["imageUrl"],
        foods: List<String>.from(json["foods"].map((x) => x)),
        pickup: json["pickup"],
        delivery: json["delivery"],
        isAvailabe: json["isAvailabe"],
        owner: json["owner"],
        code: json["code"],
        logoUrl: json["logoUrl"],
        userId: json["userId"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        verification: json["verification"],
        verificationMessage: json["verificationMessage"],
        restaurantCategories: List<RestaurantCategory>.from(json["restaurant_categories"].map((x) => RestaurantCategory.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "coords": coords.toJson(),
        "_id": id,
        "title": title,
        "time": time,
        "imageUrl": imageUrl,
        "foods": List<dynamic>.from(foods.map((x) => x)),
        "pickup": pickup,
        "delivery": delivery,
        "isAvailabe": isAvailabe,
        "owner": owner,
        "code": code,
        "logoUrl": logoUrl,
        "userId": userId,
        "rating": rating,
        "ratingCount": ratingCount,
        "verification": verification,
        "verificationMessage": verificationMessage,
        "restaurant_categories": List<dynamic>.from(restaurantCategories.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Coords {
    final String id;
    final double latitude;
    final double longitude;
    final String address;
    final String title;
    final double latitudeDelta;
    final double longitudeDelta;

    Coords({
        required this.id,
        required this.latitude,
        required this.longitude,
        required this.address,
        required this.title,
        required this.latitudeDelta,
        required this.longitudeDelta,
    });

    factory Coords.fromJson(Map<String, dynamic> json) => Coords(
        id: json["id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        title: json["title"],
        latitudeDelta: json["latitudeDelta"]?.toDouble(),
        longitudeDelta: json["longitudeDelta"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "title": title,
        "latitudeDelta": latitudeDelta,
        "longitudeDelta": longitudeDelta,
    };
}

class RestaurantCategory {
    final String name;
    final List<Additive> additives;
    final String id;

    RestaurantCategory({
        required this.name,
        required this.additives,
        required this.id,
    });

    factory RestaurantCategory.fromJson(Map<String, dynamic> json) => RestaurantCategory(
        name: json["name"],
        additives: List<Additive>.from(json["additives"].map((x) => Additive.fromJson(x))),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "additives": List<dynamic>.from(additives.map((x) => x.toJson())),
        "_id": id,
    };
}

class Additive {
    final int id;
    final String title;
    final List<Option> options;

    Additive({
        required this.id,
        required this.title,
        required this.options,
    });

    factory Additive.fromJson(Map<String, dynamic> json) => Additive(
        id: json["id"],
        title: json["title"],
        options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
    };
}

class Option {
    final String name;
    final String price;

    Option({
        required this.name,
        required this.price,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        name: json["name"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
    };
}
