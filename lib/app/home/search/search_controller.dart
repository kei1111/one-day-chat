import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/models/failure_model.dart';
import 'package:himatubu_chat/models/user_model.dart';
import 'package:himatubu_chat/repository/user_repository.dart';
import 'search_event.dart';
part 'search_state.dart';

class SearchController extends StateNotifier<SearchState> {
  final UserRepository _userRepository;

  SearchController({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SearchState.initial());

  Future initLoadedAllUser(SearchEvent event) async {
    return event.map(searchAllUsers: (value) async {
      state = state.copyWith(status: SearchStatus.loading);
      try {
        List<UserModel>? users;

        users = await _userRepository.getUsers();
        state = state.copyWith(users: users, status: SearchStatus.loaded);
      } catch (err) {
        state.copyWith(
          status: SearchStatus.error,
          failure:
              const Failure(message: 'Something went wrong. Please try again.'),
        );
      }
      return null;
    }, clearSearch: (value) async {
      state =
          state.copyWith(users: [], status: SearchStatus.initial, query: '');
      return null;
    }, searchUsers: (SearchUsers value) {
      return null;
    });
  }

  Future mapEventsToStates(SearchEvent event) async {
    return event.map(searchUsers: (value) async {
      state = state.copyWith(status: SearchStatus.loading);
      try {
        List<UserModel>? users;
        (value.query != '')
            ? users = await _userRepository.searchUsers(query: value.query)
            : users = await _userRepository.getUsers();

        state = state.copyWith(users: users, status: SearchStatus.loaded);
      } catch (err) {
        state.copyWith(
          status: SearchStatus.error,
          failure:
              const Failure(message: 'Something went wrong. Please try again.'),
        );
      }
      return null;
    }, clearSearch: (value) async {
      state =
          state.copyWith(users: [], status: SearchStatus.initial, query: '');
      return null;
    }, searchAllUsers: (SearchAllUsers value) {
      return null;
    });
  }
}
