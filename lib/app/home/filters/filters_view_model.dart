import 'package:himatubu_chat/app/home/filters/daily_user_profile_details.dart';
import 'package:himatubu_chat/app/home/models/userProfile.dart';
import 'package:rxdart/rxdart.dart';
import 'package:himatubu_chat/app/home/filters/filters_list_tile.dart';
import 'package:himatubu_chat/app/home/filters/entry_user_profile.dart';
import 'package:himatubu_chat/app/home/models/entry.dart';
import 'package:himatubu_chat/services/firestore_database.dart';

import '../user_profile_entries/format.dart';

class FiltersViewModel {
  FiltersViewModel({required this.database});
  final FirestoreDatabase database;

  Stream<List<EntryUserProfile>> get _allFiltersStream =>
      CombineLatestStream.combine2(
        database.filtersStream(),
        database.userProfileListStream(),
        _filtersUserProfileListCombiner,
      );

  static List<EntryUserProfile> _filtersUserProfileListCombiner(
      List<Entry> filters, List<UserProfile> userProfileList) {
    return filters.map((entry) {
      final userProfile = userProfileList
          .firstWhere((userProfile) => userProfile.id == entry.userProfile);
      return EntryUserProfile(entry, userProfile);
    }).toList();
  }

  Stream<List<FiltersListTileModel>> get filtersTileModelStream =>
      _allFiltersStream.map(_createModels);

  static List<FiltersListTileModel> _createModels(
      List<EntryUserProfile> allFilters) {
    if (allFilters.isEmpty) {
      return [];
    }
    final allDailyUserProfileListDetails =
        DailyUserProfileListDetails.all(allFilters);

    final totalDuration = allDailyUserProfileListDetails
        .map((dateUserProfileListDuration) =>
            dateUserProfileListDuration.duration)
        .reduce((value, element) => value + element);

    final totalPay = allDailyUserProfileListDetails
        .map((dateUserProfileListDuration) => dateUserProfileListDuration.pay)
        .reduce((value, element) => value + element);

    return <FiltersListTileModel>[
      FiltersListTileModel(
        leadingText: 'All Filters',
        middleText: Format.currency(totalPay),
        trailingText: Format.hours(totalDuration),
      ),
      for (DailyUserProfileListDetails dailyUserProfileListDetails
          in allDailyUserProfileListDetails) ...[
        FiltersListTileModel(
          isHeader: true,
          leadingText: Format.date(dailyUserProfileListDetails.date),
          middleText: Format.currency(dailyUserProfileListDetails.pay),
          trailingText: Format.hours(dailyUserProfileListDetails.duration),
        ),
        for (UserProfileListDetails userProfileDuration
            in dailyUserProfileListDetails.userProfileListDetails)
          FiltersListTileModel(
            leadingText: userProfileDuration.name,
            middleText: Format.currency(userProfileDuration.pay),
            trailingText: Format.hours(userProfileDuration.durationInHours),
          ),
      ]
    ];
  }
}
