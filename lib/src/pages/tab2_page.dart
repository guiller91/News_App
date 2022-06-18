import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/theme/darktheme.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

import '../services/news_service.dart';

// ignore: use_key_in_widget_constructors
class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: <Widget>[
          _CategoriesList(),
          Expanded(
            child: NewsList(newsService.selectedArticles!),
          ),
        ],
      ),
    ));
  }
}

class _CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            final cName = categories[index].name;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  _CategoryButton(category: categories[index]),
                  const SizedBox(height: 5),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}'),
                ],
              ),
            );
          }),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton({required this.category});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.category = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
                color: newsService.category == category.name
                    ? darkTheme.colorScheme.secondary
                    : Colors.transparent,
                width: 2)),
        child: Icon(
          category.icon,
          color: (category.name == newsService.category)
              ? darkTheme.colorScheme.secondary
              : Colors.black,
        ),
      ),
    );
  }
}
