import 'package:cloud_firestore/cloud_firestore.dart';

import '../config/constants.dart';
import '../models/user_model.dart';

class DatabaseService {
  static void updateUser(UserModel user) {
    usersRef.doc(user.id).update({
      'name': user.username,
      'profileImageUrl': user.profileImageUrl,
      'bio': user.bio,
    });
  }

  static Future<QuerySnapshot> searchUsers(String name) {
    Future<QuerySnapshot> users =
        usersRef.where('name', isGreaterThanOrEqualTo: name).get();
    return users;
  }

  static void followUser({String? currentUserId, String? userId}) {
    followingRef
        .doc(currentUserId)
        .collection('userFollowing')
        .doc(userId)
        .set({});

    followersRef
        .doc(userId)
        .collection('userFollowers')
        .doc(currentUserId)
        .set({});
  }

  static void unfollowUser({String? currentUserId, String? userId}) {
    followingRef
        .doc(currentUserId)
        .collection('userFollowing')
        .doc(userId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    followersRef
        .doc(userId)
        .collection('userFollowers')
        .doc(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  static Future<bool> isFollowingUser(
      {String? currentUserId, String? userId}) async {
    DocumentSnapshot followingDoc = await followersRef
        .doc(userId)
        .collection('userFollowers')
        .doc(currentUserId)
        .get();
    return followingDoc.exists;
  }

  static Future<int> numFollowing(String userId) async {
    QuerySnapshot followingSnapshot =
        await followingRef.doc(userId).collection('userFollowing').get();
    return followingSnapshot.docs.length;
  }

  static Future<int> numFollowers(String userId) async {
    QuerySnapshot followersSnapshot =
        await followersRef.doc(userId).collection('userFollowers').get();
    return followersSnapshot.docs.length;
  }

  static Future<UserModel?> getUserWithId(String userId) async {
    DocumentSnapshot userDocSnapshot = await usersRef.doc(userId).get();
    if (userDocSnapshot.exists) {
      return UserModel.fromMap(
          userDocSnapshot.data() as Map, userDocSnapshot.id);
    }
    return null;
  }
}
