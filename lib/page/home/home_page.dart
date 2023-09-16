import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../explore/explore_page.dart';
import '../home_tab/home_tab_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home-page";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final bottomBarIcon = [
    IconlyLight.home,
    IconlyLight.discovery,
    Icons.sunny_snowing,
    Icons.settings,
  ];

  List<String> bottomBarTitle = ["Home", "Trending", "Weather", "Setting"];

  List<Widget> tabsScreen = [];

  @override
  void didChangeDependencies() {
    tabsScreen.addAll([
      const HomeTabPage(),
      const ExplorePage(),
      Container(),
      Container(),
    ]);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: tabsScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index != currentIndex) {
            setState(() {
              currentIndex = index;
            });
          }
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.lightBlue,
        selectedLabelStyle: Theme.of(context).textTheme.caption?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.lightBlue,
            ),
        unselectedLabelStyle: Theme.of(context).textTheme.caption?.copyWith(
              fontWeight: FontWeight.w500,
            ),
        items: List.generate(
          tabsScreen.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(bottomBarIcon[index]),
            label: bottomBarTitle[index],
            activeIcon: Icon(
              bottomBarIcon[index],
              color: Colors.lightBlue,
            ),
          ),
        ),
      ),
    );
  }
}
