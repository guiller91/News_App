// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

import '../services/news_service.dart';

class Tab1Page extends StatefulWidget {
  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: (newsService.headlines.isEmpty)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : NewsList(newsService.headlines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
