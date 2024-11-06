import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String? id;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  Timestamp? dateOfBirth;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  List<String>? listFriends;

  User({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.createdAt,
    this.updatedAt,
    this.listFriends,
    this.password,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
      dateOfBirth: data['date_of_birth'],
      createdAt: data['created_at'],
      updatedAt: data['updated_at'],
      listFriends: List<String>.from(data['list_friends'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if(name != null || name != '') 'name': name,
      if(email != null || email != '') 'email': email,
      if(phoneNumber != null || phoneNumber != '') 'phone_number': phoneNumber,
      if(dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if(createdAt != null) 'created_at': createdAt,
      if(updatedAt != null) 'updated_at': updatedAt,
      if(listFriends != null) 'list_friends': listFriends,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, createdAt: $createdAt, updatedAt: $updatedAt, listFriends: $listFriends}';
  }
}