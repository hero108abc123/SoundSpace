// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soundspace/config/theme/app_pallete.dart';
import 'package:soundspace/core/common/entities/user_profile.dart';
import 'package:soundspace/features/home/presentation/screens/favorite/favorite_screen.dart';
import 'package:soundspace/features/home/presentation/screens/home/home_screen.dart';
import 'package:soundspace/features/home/presentation/screens/discovery/discovery_screen.dart';
import 'package:soundspace/features/home/presentation/screens/user/user_screen.dart';

class Navbar extends StatefulWidget {
  final Profile user;
  const Navbar({super.key, required this.user});

  @override
  _HomeTabWidgetState createState() => _HomeTabWidgetState();
}

class _HomeTabWidgetState extends State<Navbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      const HomeTab(),
      const DiscoveryScreen(),
      const FavoriteScreen(),
      UserScreen(
        tracks: const [],
        user: widget.user,
      ),
    ];

    return Container(
      color: AppPallete.gradient4,
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: AppPallete.gradient4,
          items: [
            _buildBottomNavigationBarItem(
              'assets/images/icon/navbar/home.png',
              'assets/images/icon/navbar/home_activity.png',
              0,
            ),
            _buildBottomNavigationBarItem(
              'assets/images/icon/navbar/discovery.png',
              'assets/images/icon/navbar/discovery_activity.png',
              1,
            ),
            _buildBottomNavigationBarItem(
              'assets/images/icon/navbar/heart.png',
              'assets/images/icon/navbar/heart_activity.png',
              2,
            ),
            _buildBottomNavigationBarItem(
              'assets/images/icon/navbar/person.png',
              'assets/images/icon/navbar/person_activity.png',
              3,
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        tabBuilder: (BuildContext context, int index) {
          return tabs[index];
        },
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      String inactiveAssetPath, String activeAssetPath, int index) {
    Color iconColor =
        _selectedIndex == index ? AppPallete.gradient2 : Colors.white;

    return BottomNavigationBarItem(
      icon: Image(
        image: AssetImage(
          _selectedIndex == index ? activeAssetPath : inactiveAssetPath,
        ),
        width: 28,
        height: 28,
        color: iconColor,
      ),
    );
  }
}
