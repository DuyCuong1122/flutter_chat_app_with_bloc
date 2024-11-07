import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  Timestamp? dateOfBirth;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  List<String>? listFriends;
  String? fcmtoken;

  User({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.createdAt,
    this.updatedAt,
    this.listFriends,
    this.fcmtoken,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      dateOfBirth: data['dateOfBirth'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      listFriends: List<String>.from(
        data['listFriends'] ?? [],
      ),
      fcmtoken: data['fcmtoken'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null || name != '') 'name': name,
      if (email != null || email != '') 'email': email,
      if (phoneNumber != null || phoneNumber != '') 'phoneNumber': phoneNumber,
      if (dateOfBirth != null) 'dateOfBirth': dateOfBirth,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
      if (listFriends != null) 'listFriends': listFriends,
      if (fcmtoken != null) 'fcmtoken': fcmtoken,
    };
  }

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      dateOfBirth: data['dateOfBirth'],
      listFriends: data['listFriends'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'listFriends': listFriends,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, createdAt: $createdAt, updatedAt: $updatedAt, listFriends: $listFriends, fcmtoken: $fcmtoken}';
  }
}
