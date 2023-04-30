import 'package:flutter/material.dart';
import 'package:himatubu_chat/constants/keys.dart';
import 'package:himatubu_chat/constants/strings.dart';

enum TabItem { userProfileList, filters, account }

class TabItemData {
  const TabItemData(
      {required this.key, required this.title, required this.icon});

  final String key;
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.userProfileList: TabItemData(
      key: Keys.userProfileListTab,
      title: Strings.userProfileList,
      icon: Icons.view_list,
    ),
    TabItem.filters: TabItemData(
      key: Keys.entriesTab,
      title: Strings.filters,
      icon: Icons.filter_list,
    ),
    TabItem.account: TabItemData(
      key: Keys.accountTab,
      title: Strings.account,
      icon: Icons.person,
    ),
  };
}
