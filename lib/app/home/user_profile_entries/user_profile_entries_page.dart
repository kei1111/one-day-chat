import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/app/home/user_profile/edit_user_profile_page.dart';
import 'package:himatubu_chat/app/home/user_profile_entries/entry_list_item.dart';
import 'package:himatubu_chat/app/home/user_profile_entries/entry_page.dart';
import 'package:himatubu_chat/app/home/user_profile/list_items_builder.dart';
import 'package:himatubu_chat/app/home/models/entry.dart';
import 'package:himatubu_chat/app/home/models/userProfile.dart';
import 'package:himatubu_chat/app/top_level_providers.dart';
import 'package:himatubu_chat/routing/cupertino_tab_view_router.dart';

import '../../../common_widgets/show_exception_alert_dialog.dart';

class UserProfileEntriesPage extends StatelessWidget {
  const UserProfileEntriesPage({super.key, required this.userProfile});
  final UserProfile userProfile;

  static Future<void> show(
      BuildContext context, UserProfile userProfile) async {
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.userProfileEntriesPage,
      arguments: userProfile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: UserProfileEntriesAppBarTitle(userProfile: userProfile),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () => EditUserProfilePage.show(
              context,
              userProfile: userProfile,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => EntryPage.show(
              context: context,
              userProfile: userProfile,
            ),
          ),
        ],
      ),
      body: UserProfileEntriesContents(userProfile: userProfile),
    );
  }
}

final userProfileStreamProvider = StreamProvider.autoDispose
    .family<UserProfile, String>((ref, userProfileId) {
  final database = ref.watch(databaseProvider)!;
  return database.userProfileStream(userProfileId: userProfileId);
});

class UserProfileEntriesAppBarTitle extends ConsumerWidget {
  const UserProfileEntriesAppBarTitle({super.key, required this.userProfile});
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsyncValue =
        ref.watch(userProfileStreamProvider(userProfile.id));
    return userProfileAsyncValue.when(
      data: (userProfile) => Text(userProfile.name),
      loading: () => Container(),
      error: (_, __) => Container(),
    );
  }
}

final userProfileEntriesStreamProvider = StreamProvider.autoDispose
    .family<List<Entry>, UserProfile>((ref, userProfile) {
  final database = ref.watch(databaseProvider)!;
  return database.filtersStream(userProfile: userProfile);
});

class UserProfileEntriesContents extends ConsumerWidget {
  final UserProfile userProfile;

  const UserProfileEntriesContents({super.key, required this.userProfile});

  Future<void> _deleteEntry(
      BuildContext context, WidgetRef ref, Entry entry) async {
    try {
      final database = ref.read(databaseProvider)!;
      await database.deleteEntry(entry);
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
    final entriesStream =
        ref.watch(userProfileEntriesStreamProvider(userProfile));
    return ListItemsBuilder<Entry>(
      data: entriesStream,
      itemBuilder: (context, entry) {
        return DismissibleEntryListItem(
          dismissibleKey: Key('entry-${entry.id}'),
          entry: entry,
          userProfile: userProfile,
          onDismissed: () => _deleteEntry(context, ref, entry),
          onTap: () => EntryPage.show(
            context: context,
            userProfile: userProfile,
            entry: entry,
          ),
        );
      },
    );
  }
}
