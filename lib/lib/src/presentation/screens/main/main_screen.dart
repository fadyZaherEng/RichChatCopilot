import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/chats/chats_screen.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/globe/globe_screen.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/groups/groups_screen.dart';

class MainScreen extends BaseStatefulWidget {
  const MainScreen({super.key});

  @override
  BaseState<MainScreen> baseCreateState() => _MainScreenState();
}

class _MainScreenState extends BaseState<MainScreen> {
  final List<Widget> _screens = [
    const ChatsScreen(),
    const GroupsScreen(),
    const GlobeScreen(),
  ];
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.chat_bubble_2_fill),
            label: S.of(context).chats,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.group),
            label: S.of(context).groups,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.globe),
            label: S.of(context).globes,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorSchemes.primary,
        selectedIconTheme: const IconThemeData(color: ColorSchemes.primary),
        unselectedItemColor: ColorSchemes.gray,
        backgroundColor: ColorSchemes.white,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: ColorSchemes.iconBackGround),
        selectedLabelStyle: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: ColorSchemes.primary),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
