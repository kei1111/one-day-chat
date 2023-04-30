import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:himatubu_chat/app/home/user_profile/edit_user_profile_page.dart';
import 'package:himatubu_chat/app/home/user_profile_entries/entry_page.dart';
import 'package:himatubu_chat/app/home/models/entry.dart';
import 'package:himatubu_chat/app/home/models/userProfile.dart';

import '../app/sign_in/email_password_sign_in_page.dart';

class AppRoutes {
  static const emailPasswordSignInPage = '/email-password-sign-in-page';
  static const editUserProfilePage = '/edit-user-profile-page';
  static const entryPage = '/entry-page';
}

class AppRouter {
  static Route<dynamic>? onGenerateRoute(
      RouteSettings settings, FirebaseAuth firebaseAuth) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.emailPasswordSignInPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => EmailPasswordSignInPage.withFirebaseAuth(firebaseAuth,
              onSignedIn: args as void Function()),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.editUserProfilePage:
        return MaterialPageRoute<dynamic>(
          builder: (_) =>
              EditUserProfilePage(userProfile: args as UserProfile?),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.entryPage:
        final mapArgs = args as Map<String, dynamic>;
        final userProfile = mapArgs['userProfile'] as UserProfile;
        final entry = mapArgs['entry'] as Entry?;
        return MaterialPageRoute<dynamic>(
          builder: (_) => EntryPage(userProfile: userProfile, entry: entry),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        return null;
    }
  }
}
