import 'package:flutter/material.dart';
import 'package:himatubu_chat/app/home/models/userProfile.dart';

class UserProfileListTile extends StatelessWidget {
  const UserProfileListTile({Key? key, required this.userProfile, this.onTap})
      : super(key: key);
  final UserProfile userProfile;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(userProfile.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
