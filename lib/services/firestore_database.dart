import 'dart:async';

import 'package:himatubu_chat/app/home/models/entry.dart';
import 'package:himatubu_chat/app/home/models/userProfile.dart';
import 'package:himatubu_chat/models/user_model.dart';
import 'package:himatubu_chat/services/firestore_path.dart';
import 'package:himatubu_chat/services/firestore_service.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _service = FirestoreService.instance;

  Future<void> setUser(UserModel user) => _service.setData(
        path: FirestorePath.user(uid),
        data: user.toMap(),
      );

  Future<void> setUserProfile(UserProfile userProfile) => _service.setData(
        path: FirestorePath.userProfile(uid, userProfile.id),
        data: userProfile.toMap(),
      );

  Future<void> deleteUserProfile(UserProfile userProfile) async {
    final allFilters = await filtersStream(userProfile: userProfile).first;
    for (final entry in allFilters) {
      if (entry.userProfile == userProfile.id) {
        await deleteEntry(entry);
      }
    }
    await _service.deleteData(
        path: FirestorePath.userProfile(uid, userProfile.id));
  }

  Stream<UserProfile> userProfileStream({required String userProfileId}) =>
      _service.documentStream(
        path: FirestorePath.userProfile(uid, userProfileId),
        builder: (data, documentId) => UserProfile.fromMap(data, documentId),
      );

  Stream<List<UserProfile>> userProfileListStream() =>
      _service.collectionStream(
        path: FirestorePath.userProfileList(uid),
        builder: (data, documentId) => UserProfile.fromMap(data, documentId),
      );

  Future<void> setEntry(Entry entry) => _service.setData(
        path: FirestorePath.entry(uid, entry.id),
        data: entry.toMap(),
      );

  Future<void> deleteEntry(Entry entry) =>
      _service.deleteData(path: FirestorePath.entry(uid, entry.id));

  Stream<List<Entry>> filtersStream({UserProfile? userProfile}) =>
      _service.collectionStream<Entry>(
        path: FirestorePath.filters(uid),
        queryBuilder: userProfile != null
            ? (query) => query.where('userProfileId', isEqualTo: userProfile.id)
            : null,
        builder: (data, documentID) => Entry.fromMap(data, documentID),
        sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );
}
