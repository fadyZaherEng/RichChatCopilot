import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/generated/l10n.dart';
import 'package:rich_chat_copilot/lib/src/config/theme/color_schemes.dart';
import 'package:rich_chat_copilot/lib/src/core/base/widget/base_stateful_widget.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/home/home_screen.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/settings/settings_screen.dart';

class MainScreen extends BaseStatefulWidget {
  const MainScreen({super.key});

  @override
  BaseState<MainScreen> baseCreateState() => _MainScreenState();
}

class _MainScreenState extends BaseState<MainScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const SettingsScreen(),
  ];
  int _selectedIndex = 0;

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: S.of(context).settings,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:ColorSchemes.primary,
        selectedIconTheme:  IconThemeData(color: ColorSchemes.primary),
        unselectedItemColor: ColorSchemes.gray,
        backgroundColor: ColorSchemes.white,
        onTap: _onItemTapped,
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
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
