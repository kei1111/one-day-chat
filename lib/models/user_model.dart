import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String username;
  final String profileImageUrl;
  final String place;
  final int age;
  final String gender;
  final int rejections;
  final int rejected;
  final String bio;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.username,
    required this.profileImageUrl,
    required this.place,
    required this.age,
    required this.gender,
    required this.rejections,
    required this.rejected,
    required this.bio,
    required this.createdAt,
  });

  static final empty = UserModel(
    id: '',
    username: '',
    profileImageUrl: '',
    place: '',
    age: 0,
    gender: '',
    rejections: 0,
    rejected: 0,
    bio: '',
    createdAt: DateTime.now(),
  );

  @override
  List<Object> get props => [
        id,
        username,
        profileImageUrl,
        place,
        age,
        gender,
        rejections,
        rejected,
        bio,
        createdAt
      ];

  UserModel copyWith({
    String? id,
    String? username,
    String? profileImageUrl,
    String? place,
    int? age,
    String? gender,
    int? rejections,
    int? rejected,
    String? bio,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      place: place ?? this.place,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      rejections: rejections ?? this.rejections,
      rejected: rejected ?? this.rejected,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'profileImageUrl': profileImageUrl,
      'place': place,
      'age': age,
      'gender': gender,
      'rejections': rejections,
      'rejected': rejected,
      'bio': bio,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<dynamic, dynamic>? doc, String id) {
    if (doc == null) {
      throw StateError('missing data for entryId:');
    }

    return UserModel(
      id: id,
      username: doc['username'] as String? ?? '',
      profileImageUrl: doc['profileImageUrl'] ?? '',
      place: doc['place'] ?? '',
      age: (doc['age'] ?? 0).toInt(),
      gender: doc['gender'] as String? ?? '',
      rejections: (doc['rejections'] ?? 0).toInt(),
      rejected: (doc['rejected'] ?? 0).toInt(),
      bio: doc['bio'] ?? '',
      createdAt: (doc['createdAt'] as Timestamp).toDate(),
    );
  }
}
