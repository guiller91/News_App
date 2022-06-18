// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:news_app/src/pages/tab1_page.dart';
import 'package:news_app/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

import '../services/news_service.dart';

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
          icon: Icon(Icons.person_outline),
          label: 'Para ti',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public_rounded),
          label: 'Encabezados',
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
  PageController _pageController = PageController();

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    _pageController.animateToPage(value,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
