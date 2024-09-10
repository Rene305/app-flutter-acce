// To parse this JSON data, do
//
//     final Foundation = FoundationFromJson(jsonString);

import 'dart:convert';

Foundation foundationFromJson(String str) =>
    Foundation.fromJson(json.decode(str));

String foundationToJson(Foundation data) => json.encode(data.toJson());

class Foundation {
  String name;
  String city;
  String logo;
  SocialNetwork socialNetwork;
  List<String> services;
  Location location;
  String representative;

  Foundation({
    required this.name,
    required this.city,
    required this.logo,
    required this.socialNetwork,
    required this.services,
    required this.location,
    required this.representative,
  });

  factory Foundation.fromJson(Map<String, dynamic> json) => Foundation(
        name: json["name"],
        city: json["city"],
        logo: json["logo"],
        socialNetwork: SocialNetwork.fromJson(json["socialNetwork"]),
        services: List<String>.from(json["services"].map((x) => x)),
        location: Location.fromJson(json["location"]),
        representative: json["representative"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "city": city,
        "logo": logo,
        "socialNetwork": socialNetwork.toJson(),
        "services": List<dynamic>.from(services.map((x) => x)),
        "location": location.toJson(),
        "representative": representative,
      };
}

class Location {
  String description;
  String longitude;
  String latitude;

  Location({
    required this.description,
    required this.longitude,
    required this.latitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        description: json["description"],
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "longitude": longitude,
        "latitude": latitude,
      };
}

class SocialNetwork {
  String? facebook;
  String? twitter;
  String? instagram;
  String? mail;

  SocialNetwork({
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.mail,
  });

  factory SocialNetwork.fromJson(Map<String, dynamic> json) => SocialNetwork(
        facebook: json["facebook"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        mail: json["mail"],
      );

  Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
        "mail": mail,
      };
}
