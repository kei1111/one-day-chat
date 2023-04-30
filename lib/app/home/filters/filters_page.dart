import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/app/home/filters/filters_view_model.dart';
import 'package:himatubu_chat/app/home/filters/filters_list_tile.dart';
import 'package:himatubu_chat/app/home/user_profile/list_items_builder.dart';
import 'package:himatubu_chat/app/top_level_providers.dart';
import 'package:himatubu_chat/constants/strings.dart';

final filtersTileModelStreamProvider =
    StreamProvider.autoDispose<List<FiltersListTileModel>>(
  (ref) {
    final database = ref.watch(databaseProvider)!;
    final vm = FiltersViewModel(database: database);
    return vm.filtersTileModelStream;
  },
);

class FiltersPage extends ConsumerWidget {
  const FiltersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtersTileModelStream = ref.watch(filtersTileModelStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.filters),
        elevation: 2.0,
      ),
      body: ListItemsBuilder<FiltersListTileModel>(
        data: filtersTileModelStream,
        itemBuilder: (context, model) => FiltersListTile(model: model),
      ),
    );
  }
}
