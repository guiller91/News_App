// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/pages/tab1_page.dart';
import 'package:news_app/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _NavigationBar(),
      ),
    );
  }
}

class _NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegationModel = Provider.of<_NavegationModel>(context);

    return BottomNavigationBar(
      currentIndex: navegationModel.currentPage,
      onTap: (index) {
        navegationModel.currentPage = index;
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.globe),
          label: 'General',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.icons),
          label: 'Categories',
        ),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegationModel = Provider.of<_NavegationModel>(context);

    return PageView(
      controller: navegationModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavegationModel with ChangeNotifier {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    _pageController.animateToPage(value,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
