import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/config/paths.dart';
import 'package:himatubu_chat/repository/auth_repository.dart';
import 'package:himatubu_chat/services/firestore_path.dart';

import '../app/home/models/failure_model.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepository(ref));

class UserRepository {
  UserRepository(this.ref) {
    _authRepoProvider = ref.watch(authRepoProvider);
    _initializeUserModel();
  }

  final _firebaseFirestore = FirebaseFirestore.instance;
  final _service = FirestoreService.instance;
  late AuthRepository _authRepoProvider;
  UserModel? userModel;
  String? uid;

  final Ref ref;

  Future<void> _initializeUserModel() async {
    final userId = getCurrentUserAuthUid();
    if (userId != null) {
      final userModelResult = await getUserWithId(userId: userId);
      userModel = userModelResult;
    }
  }

  Future<void> setUser(String uid, UserModel user) async {
    final result = await getUserWithId(userId: uid);

    if (result == UserModel.empty) {
      await _service.setData(
        path: FirestorePath.user(uid),
        data: user.toMap(),
      );
      userModel = user;
    } else {
      userModel = user;
    }
  }

  String? getCurrentUserAuthUid() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  Future<bool> checkValidAuth() async {
    final uid = getCurrentUserAuthUid();
    if (uid != null) {
      return await validateAuth(uid);
    } else {
      return false;
    }
  }

  Future<bool> validateAuth(String uid) async {
    final result = await getUserData(userId: uid);
    return result.fold(
      (failure) {
        return false;
      },
      (userModel) {
        if (userModel != null) {
          return true;
        } else {
          return false;
        }
      },
    );
  }

  Future<Either<Failure, UserModel?>> getUserData(
      {required String userId}) async {
    final doc =
        await _firebaseFirestore.collection(Paths.users).doc(userId).get();

    if (doc.exists) {
      userModel = UserModel.fromMap(doc.data(), doc.id);
      return Right(UserModel.fromMap(doc.data(), doc.id));
    } else {
      return const Left(Failure(code: "500"));
    }
  }

  Future<UserModel?> getUserWithId({required String userId}) async {
    final doc =
        await _firebaseFirestore.collection(Paths.users).doc(userId).get();
    userModel =
        doc.exists ? UserModel.fromMap(doc.data(), doc.id) : UserModel.empty;

    return userModel;
  }

  Future clearUserLocalData() async {
    uid = null;
    userModel = null;
  }

  @override
  Future<void> updateUser({required UserModel user}) async {
    await _firebaseFirestore
        .collection(Paths.users)
        .doc(user.id)
        .update(user.toMap());
  }

  @override
  Future<List<UserModel>> searchUsers({required String query}) async {
    final userSnap = await _firebaseFirestore
        .collection(Paths.users)
        .where('username', isGreaterThanOrEqualTo: query)
        .get();

    return userSnap.docs
        .map((doc) => UserModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<List<UserModel>> getUsers() async {
    final userSnap = await _firebaseFirestore.collection(Paths.users).get();

    return userSnap.docs
        .map((doc) => UserModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<String> uploadImage(File? imageUrl, String uid) async {
    final uploadedImage = await _service.uploadImage(
        file: imageUrl!, path: FirestorePath.profilesImagesPath(uid));

    return uploadedImage;
  }
}
