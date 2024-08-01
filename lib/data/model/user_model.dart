import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final Address? address;
  final String? id;
  final String? email;
  final String? userName;
  final String? password;
  final int? role;
  final Name? name;
  final String? image;

  const UserModel({
    this.address,
    this.id,
    this.email,
    this.userName,
    this.password,
    this.role,
    this.name,
    this.image,
  });

  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    return UserModel(
      id: id,
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      email: json['email'],
      userName: json['userName'],
      password: json['password'],
      role: json['role'],
      name: json['name'] != null ? Name.fromJson(json['name']) : null,
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address?.toJson(),
      'email': email,
      'userName': userName,
      'password': password,
      'role': role,
      'name': name?.toJson(),
      'image': image,
    };
  }

  @override
  List<Object?> get props => [
        id,
        email,
        userName,
        password,
        role,
        name,
        image,
      ];
}

class Address {
  Geolocation? geolocation;
  String? city;
  String? street;
  int? number;
  String? zipcode;

  Address(
      {this.geolocation, this.city, this.street, this.number, this.zipcode});

  Address.fromJson(Map<String, dynamic> json) {
    geolocation = json['geolocation'] != null
        ? Geolocation.fromJson(json['geolocation'])
        : null;
    city = json['city'];
    street = json['street'];
    number = json['number'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (geolocation != null) {
      data['geolocation'] = geolocation!.toJson();
    }
    data['city'] = city;
    data['street'] = street;
    data['number'] = number;
    data['zipcode'] = zipcode;
    return data;
  }
}

class Geolocation {
  String? lat;
  String? long;

  Geolocation({this.lat, this.long});

  Geolocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}

class Name {
  String? firstname;
  String? lastname;

  Name({this.firstname, this.lastname});

  Name.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}
