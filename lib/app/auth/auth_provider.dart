import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/app/auth/auth_state.dart';

import '../../models/user_model.dart';
import '../../repository/auth_repository.dart';
import '../../repository/user_repository.dart';

final authProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this.ref) : super(const AuthState.initializing()) {
    _authRepository = ref.watch(authRepoProvider);
    _userRepository = ref.watch(userRepositoryProvider);
  }

  final Ref ref;
  late AuthRepository _authRepository;
  late UserRepository _userRepository;

  Future registerAccount({
    required String username,
    required String place,
    required int age,
    required String gender,
    required File? profilePageFile,
  }) async {
    state = const AuthState.ready();
    final UserCredential result = await _authRepository.signInAnonymously();
    final imageUrl =
        await _userRepository.uploadImage(profilePageFile, result.user!.uid);
    UserModel userModel = UserModel(
        id: result.user!.uid,
        username: username,
        profileImageUrl: imageUrl,
        place: place,
        age: age,
        gender: gender,
        rejected: 0,
        rejections: 0,
        bio: "",
        createdAt: DateTime.now());
    await _userRepository.setUser(result.user!.uid, userModel);
  }
}
