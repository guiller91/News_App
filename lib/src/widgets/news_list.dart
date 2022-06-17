import 'package:flutter/material.dart';

import '../models/news_models.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;

  const NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(news[index].title!);
      },
    );
  }
}
