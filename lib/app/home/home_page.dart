import 'package:flutter/material.dart';
import 'package:himatubu_chat/app/home/cupertino_home_scaffold.dart';
import 'package:himatubu_chat/app/home/filter_screen.dart';
import 'package:himatubu_chat/app/home/search/search_screen.dart';
import 'package:himatubu_chat/app/home/tab_item.dart';
import 'package:himatubu_chat/app/profile/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.userProfileList;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.userProfileList: GlobalKey<NavigatorState>(),
    TabItem.filters: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.userProfileList: (_) => const SearchScreen(),
      TabItem.filters: (_) => const FilterFilter(),
      TabItem.account: (_) => const ProfileScreen(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem]!.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !(await navigatorKeys[_currentTab]!.currentState?.maybePop() ??
              false),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
