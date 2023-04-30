import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:himatubu_chat/config/paths.dart';
import 'package:himatubu_chat/models/user_model.dart';

class Post extends Equatable {
  final String id;
  final UserModel author;
  final String imageUrl;
  final String caption;
  final int likes;
  final DateTime date;

  const Post({
    required this.id,
    required this.author,
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.date,
  });

  @override
  List<Object> get props => [
        id,
        author,
        imageUrl,
        caption,
        likes,
        date,
      ];

  Post copyWith({
    String? id,
    UserModel? author,
    String? imageUrl,
    String? caption,
    int? likes,
    DateTime? date,
  }) {
    return Post(
      id: id ?? this.id,
      author: author ?? this.author,
      imageUrl: imageUrl ?? this.imageUrl,
      caption: caption ?? this.caption,
      likes: likes ?? this.likes,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'author':
          FirebaseFirestore.instance.collection(Paths.users).doc(author.id),
      'imageUrl': imageUrl,
      'caption': caption,
      'likes': likes,
      'date': Timestamp.fromDate(date),
    };
  }
}
