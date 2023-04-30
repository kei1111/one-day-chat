import 'package:himatubu_chat/app/home/filters/entry_user_profile.dart';

class UserProfileListDetails {
  UserProfileListDetails({
    required this.name,
    required this.durationInHours,
    required this.pay,
  });
  final String name;
  double durationInHours;
  double pay;
}

class DailyUserProfileListDetails {
  DailyUserProfileListDetails(
      {required this.date, required this.userProfileListDetails});
  final DateTime date;
  final List<UserProfileListDetails> userProfileListDetails;

  double get pay => userProfileListDetails
      .map((userProfileDuration) => userProfileDuration.pay)
      .reduce((value, element) => value + element);

  double get duration => userProfileListDetails
      .map((userProfileDuration) => userProfileDuration.durationInHours)
      .reduce((value, element) => value + element);

  static Map<DateTime, List<EntryUserProfile>> _filtersByDate(
      List<EntryUserProfile> filters) {
    final Map<DateTime, List<EntryUserProfile>> map = {};
    for (final entryUserProfile in filters) {
      final entryDayStart = DateTime(entryUserProfile.entry.start.year,
          entryUserProfile.entry.start.month, entryUserProfile.entry.start.day);
      if (map[entryDayStart] == null) {
        map[entryDayStart] = [entryUserProfile];
      } else {
        map[entryDayStart]!.add(entryUserProfile);
      }
    }
    return map;
  }

  static List<DailyUserProfileListDetails> all(List<EntryUserProfile> filters) {
    final byDate = _filtersByDate(filters);
    final List<DailyUserProfileListDetails> list = [];
    for (final pair in byDate.entries) {
      final date = pair.key;
      final filtersByDate = pair.value;
      final byUserProfile = _userProfileListDetails(filtersByDate);
      list.add(DailyUserProfileListDetails(
          date: date, userProfileListDetails: byUserProfile));
    }
    return list.toList();
  }

  static List<UserProfileListDetails> _userProfileListDetails(
      List<EntryUserProfile> filters) {
    final Map<String, UserProfileListDetails> userProfileDuration = {};
    for (final entryUserProfile in filters) {
      final entry = entryUserProfile.entry;
      final pay =
          entry.durationInHours * entryUserProfile.userProfile.ratePerHour;
      if (userProfileDuration[entry.userProfile] == null) {
        userProfileDuration[entry.userProfile] = UserProfileListDetails(
          name: entryUserProfile.userProfile.name,
          durationInHours: entry.durationInHours,
          pay: pay,
        );
      } else {
        userProfileDuration[entry.userProfile]!.pay += pay;
        userProfileDuration[entry.userProfile]!.durationInHours +=
            entry.durationInHours;
      }
    }
    return userProfileDuration.values.toList();
  }
}
