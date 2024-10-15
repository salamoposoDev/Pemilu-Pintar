import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String nik;
  String name;
  String gender;
  String dateOfBirth;
  String age;
  String province;
  String city;
  String subDistrict;
  String postalCode;
  bool isAdmin;
  bool isTimSaksi;
  Timestamp createdOn;
  Timestamp updatedOn;
  String inputBy;

  User({
    required this.nik,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.age,
    required this.province,
    required this.city,
    required this.subDistrict,
    required this.postalCode,
    required this.isTimSaksi,
    required this.isAdmin,
    required this.createdOn,
    required this.updatedOn,
    required this.inputBy,
  });

  User.fromJson(Map<String, Object?> json)
      : this(
          nik: json['nik']! as String,
          name: json['name']! as String,
          gender: json['gender']! as String,
          dateOfBirth: json['dateOfBirth']! as String,
          age: json['age']! as String,
          province: json['province']! as String,
          city: json['city']! as String,
          subDistrict: json['subDistrict']! as String,
          postalCode: json['postalCode']! as String,
          isTimSaksi: json['isTimSaksi']! as bool,
          isAdmin: json['isAdmin']! as bool,
          createdOn: json['createdOn']! as Timestamp,
          updatedOn: json['updatedOn']! as Timestamp,
          inputBy: json['inputBy']! as String,
        );

  User copyWith({
    String? nik,
    String? name,
    String? gender,
    String? dateOfBirth,
    String? age,
    String? province,
    String? city,
    String? subDistrict,
    String? postalCode,
    bool? isAdmin,
    bool? isTimSaksi,
    Timestamp? createdOn,
    Timestamp? updatedOn,
    String? inputBy,
  }) {
    return User(
      nik: nik ?? this.nik,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      age: age ?? this.age,
      province: province ?? this.province,
      city: city ?? this.city,
      subDistrict: subDistrict ?? this.subDistrict,
      postalCode: postalCode ?? this.postalCode,
      isTimSaksi: isTimSaksi ?? this.isTimSaksi,
      isAdmin: isAdmin ?? this.isAdmin,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      inputBy: inputBy ?? this.inputBy,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'nik': nik,
      'name': name,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'age': age,
      'province': province,
      'city': city,
      'subDistrict': subDistrict,
      'postalCode': postalCode,
      'isTimSaksi': isTimSaksi,
      'isAdmin': isAdmin,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'inputBy': inputBy,
    };
  }
}
