import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/app/home/search/search_controller.dart';
import 'package:himatubu_chat/app/home/search/search_event.dart';
import 'package:himatubu_chat/app/profile/card_item_component.dart';
import 'package:himatubu_chat/repository/user_repository.dart';
import 'package:himatubu_chat/styles/sizes.dart';

final searchProvider =
    StateNotifierProvider.autoDispose<SearchController, SearchState>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return SearchController(userRepository: userRepository);
});

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState {
  String query = '';
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref
        .read(searchProvider.notifier)
        .initLoadedAllUser(const SearchEvent.searchAllUsers());
  }

  @override
  Widget build(BuildContext context) {
    const styleActive = TextStyle(color: Colors.black);
    const styleHint = TextStyle(color: Colors.black54);
    final style = query.isEmpty ? styleHint : styleActive;
    final searchStates = ref.watch(searchProvider);
    final searchEvents = ref.watch(searchProvider.notifier);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 30,
          title: Container(
            height: 35,
            margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: style.color),
                suffixIcon: query.isNotEmpty
                    ? GestureDetector(
                        child: Icon(Icons.close, color: style.color),
                        onTap: () {
                          controller.clear();
                          searchEvents.mapEventsToStates(
                              SearchEvent.searchUsers(query: query));
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      )
                    : null,
                hintText: 'Search users',
                hintStyle: style,
                contentPadding: const EdgeInsets.only(bottom: 14),
                border: InputBorder.none,
              ),
              style: style,
              onChanged: (value) {
                setState(() {
                  query = value;
                });
                searchEvents
                    .mapEventsToStates(SearchEvent.searchUsers(query: query));
              },
            ),
          ),
        ),
        body: Builder(
          builder: (context) {
            switch (searchStates.status) {
              case SearchStatus.error:
                return Text(searchStates.failure.message);
              case SearchStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case SearchStatus.loaded:
                return searchStates.users.isNotEmpty
                    ? ListView.separated(
                        padding: EdgeInsets.symmetric(
                          vertical: Sizes.screenVPaddingDefault(context),
                          horizontal: Sizes.screenHPaddingMedium(context),
                        ),
                        itemCount: searchStates.users.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: Sizes.vMarginHigh(context),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return CardItemComponent(
                            userModel: searchStates.users[index],
                          );
                        },
                      )
                    : const Text('No users found');
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
