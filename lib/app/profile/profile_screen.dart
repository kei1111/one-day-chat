import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/app/profile/profile_provider.dart';
import 'package:himatubu_chat/app/profile/user_details_component.dart';
import 'package:himatubu_chat/app/top_level_providers.dart';
import 'package:himatubu_chat/common_widgets/loading_indicators.dart';
import 'package:himatubu_chat/common_widgets/popup_page_nested.dart';
import 'package:himatubu_chat/common_widgets/show_alert_dialog.dart';
import 'package:himatubu_chat/common_widgets/show_exception_alert_dialog.dart';
import 'package:himatubu_chat/common_widgets/user_image_component.dart';
import 'package:himatubu_chat/constants/keys.dart';
import 'package:himatubu_chat/constants/strings.dart';
import 'package:himatubu_chat/styles/sizes.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context, FirebaseAuth firebaseAuth) async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: Strings.logoutFailed,
        exception: e,
      ));
    }
  }

  Future<void> _confirmSignOut(
      BuildContext context, FirebaseAuth firebaseAuth) async {
    final bool didRequestSignOut = await showAlertDialog(
          context: context,
          title: Strings.logout,
          content: Strings.logoutAreYouSure,
          cancelActionText: Strings.cancel,
          defaultActionText: Strings.logout,
        ) ??
        false;
    if (didRequestSignOut == true) {
      await _signOut(context, firebaseAuth);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);

    return PopUpPageNested(
      body: Consumer(
        builder: (context, ref, child) {
          final profileIsLoading = ref.watch(
            profileProvider.select((state) =>
                state.maybeWhen(loading: () => true, orElse: () => false)),
          );
          return profileIsLoading
              ? LoadingIndicators.instance.smallLoadingAnimation(context)
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    vertical: Sizes.screenVPaddingDefault(context),
                    horizontal: Sizes.screenHPaddingDefault(context),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        key: const Key(Keys.logout),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: const Text(
                            Strings.logout,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        onPressed: () => _confirmSignOut(context, firebaseAuth),
                      ),
                      const UserImageComponent(),
                      SizedBox(
                        height: Sizes.vMarginComment(context),
                      ),
                      const UserDetailsComponent(),
                      SizedBox(
                        height: Sizes.vMarginHigh(context),
                      ),
                      // const ProfileFormComponent(),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
