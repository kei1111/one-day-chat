import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:himatubu_chat/common_widgets/errors/exceptions.dart';
import 'package:himatubu_chat/common_widgets/errors/failures.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data, SetOptions(merge: merge));
  }

  Future<T> setDataBuilder<T>({
    required String path,
    required Map<String, dynamic> data,
    required T Function(dynamic data) builder,
    bool merge = false,
  }) async {
    try {
      final reference = FirebaseFirestore.instance.doc(path);
      await reference.set(data, SetOptions(merge: merge));
      return builder(true);
    } catch (e) {
      final failure = ServerFailure(
        message: Exceptions.errorMessage(e),
        statusCode: Exceptions.statusCode(e),
      );
      return builder(failure);
    }
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
    Query<Map<String, dynamic>>? Function(Query<Map<String, dynamic>> query)?
        queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
        query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
  }) {
    final DocumentReference<Map<String, dynamic>> reference =
        FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots =
        reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Future<String> uploadImage<T>({
    required String path,
    required File file,
  }) async {
    try {
      UploadTask uploadTask = _firebaseStorage.ref().child(path).putFile(file);
      final downloadURL = await (await uploadTask).ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      ServerFailure(
        message: Exceptions.errorMessage(e),
        statusCode: Exceptions.statusCode(e),
      );
      return Exceptions.errorMessage(e);
    }
  }
}
