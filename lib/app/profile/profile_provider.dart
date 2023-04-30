import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/app/profile/profile_state.dart';
import 'package:himatubu_chat/repository/user_repository.dart';

final profileProvider =
    StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(ref);
});

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(this.ref) : super(const ProfileState.available()) {
    _userRepo = ref.read(userRepositoryProvider);
  }

  final Ref ref;
  late UserRepository _userRepo;

  Future updateProfile(
    BuildContext context, {
    required String name,
    required String mobile,
  }) async {
    state = const ProfileState.loading();
  }

  Future updateProfileImage(
    BuildContext context, {
    required bool fromCamera,
  }) async {}

  updateFirebaseImage(BuildContext context, File? image) async {
    state = const ProfileState.loading();
  }
}
