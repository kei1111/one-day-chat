import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/app/home/user_profile/edit_user_profile_page.dart';
import 'package:himatubu_chat/app/home/user_profile_entries/user_profile_entries_page.dart';
import 'package:himatubu_chat/app/home/user_profile/user_profile_list_tile.dart';
import 'package:himatubu_chat/app/home/user_profile/list_items_builder.dart';
import 'package:himatubu_chat/app/home/models/userProfile.dart';
import 'package:himatubu_chat/app/top_level_providers.dart';
import 'package:himatubu_chat/constants/strings.dart';
import 'package:pedantic/pedantic.dart';
import 'package:himatubu_chat/services/firestore_database.dart';

import '../../../common_widgets/show_exception_alert_dialog.dart';

final userProfileListStreamProvider =
    StreamProvider.autoDispose<List<UserProfile>>((ref) {
  final database = ref.watch(databaseProvider)!;
  return database.userProfileListStream();
});

class UserProfileListPage extends ConsumerWidget {
  const UserProfileListPage({super.key});

  Future<void> _delete(
      BuildContext context, WidgetRef ref, UserProfile userProfile) async {
    try {
      final database = ref.read<FirestoreDatabase?>(databaseProvider)!;
      await database.deleteUserProfile(userProfile);
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: 'Operation failed',
        exception: e,
      ));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.userProfileList),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => EditUserProfilePage.show(context),
          ),
        ],
      ),
      body: _buildContents(context, ref),
    );
  }

  Widget _buildContents(BuildContext context, WidgetRef ref) {
    final userProfileAsyncValue = ref.watch(userProfileListStreamProvider);
    return ListItemsBuilder<UserProfile>(
      data: userProfileAsyncValue,
      itemBuilder: (context, userProfile) => Dismissible(
        key: Key('userProfile-${userProfile.id}'),
        background: Container(color: Colors.red),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => _delete(context, ref, userProfile),
        child: UserProfileListTile(
          userProfile: userProfile,
          onTap: () => UserProfileEntriesPage.show(context, userProfile),
        ),
      ),
    );
  }
}
