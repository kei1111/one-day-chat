import 'package:flutter/cupertino.dart';
import 'package:himatubu_chat/app/home/user_profile_entries/user_profile_entries_page.dart';
import 'package:himatubu_chat/app/home/models/userProfile.dart';

class CupertinoTabViewRoutes {
  static const userProfileEntriesPage = '/user-profile-entries-page';
}

class CupertinoTabViewRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CupertinoTabViewRoutes.userProfileEntriesPage:
        final userProfile = settings.arguments as UserProfile;
        return CupertinoPageRoute(
          builder: (_) => UserProfileEntriesPage(userProfile: userProfile),
          settings: settings,
          fullscreenDialog: false,
        );
    }
    return null;
  }
}
