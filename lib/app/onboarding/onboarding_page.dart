import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/app/onboarding/onboarding_view_model.dart';

import '../../common_widgets/custom_button.dart';

class OnboardingPage extends ConsumerWidget {
  Future<void> onGetStarted(BuildContext context, WidgetRef ref) async {
    final onboardingViewModel = ref.read(onboardingViewModelProvider.notifier);
    await onboardingViewModel.completeOnboarding();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomRaisedButton(
              onPressed: () => onGetStarted(context, ref),
              color: Colors.blueGrey,
              borderRadius: 30,
              child: Text(
                'Get Started',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
