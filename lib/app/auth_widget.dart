import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/app/home/user_profile/empty_content.dart';
import 'package:himatubu_chat/app/top_level_providers.dart';
import 'package:himatubu_chat/repository/user_repository.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget({
    Key? key,
    required this.signedInBuilder,
    required this.nonSignedInBuilder,
  }) : super(key: key);
  final WidgetBuilder nonSignedInBuilder;
  final WidgetBuilder signedInBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateChangesProvider);
    return authStateChanges.when(
      data: (user) => _data(context, user, ref),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const Scaffold(
        body: EmptyContent(
          title: 'Something went wrong',
          message: 'Can\'t load data right now.',
        ),
      ),
    );
  }

  Future checkAuth(WidgetRef ref, user) async {
    bool hasValidAuth =
        await ref.watch(userRepositoryProvider).checkValidAuth();
    return hasValidAuth;
  }

  _data(BuildContext context, User? user, WidgetRef ref) {
    checkAuth(ref, user);

    if (user != null) {
      return signedInBuilder(context);
    } else {
      return nonSignedInBuilder(context);
    }
  }
}
