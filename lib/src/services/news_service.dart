// ignore_for_file: prefer_const_declarations, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/category_model.dart';
import '../models/news_models.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.basketball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  final _urlNews = 'newsapi.org';
  final _apiKey = 'a79f0232d2914835a70fa5bede50c076';
  final _country = 'us';
  String _category = 'business';

  NewsService() {
    getTopHeadlines();

    for (var item in categories) {
      categoryArticles[item.name] = [];
    }
  }

  get category => _category;

  set category(value) {
    _category = value;
    getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article>? get selectedArticles => categoryArticles[_category];

  getTopHeadlines() async {
    final url = Uri.https(_urlNews, '/v2/top-headlines', {
      'country': _country,
      'apiKey': _apiKey,
    });

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }

    final url = Uri.https(_urlNews, '/v2/top-headlines', {
      'country': _country,
      'apiKey': _apiKey,
      'category': category,
    });

    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    categoryArticles[category]?.addAll(newsResponse.articles);
    notifyListeners();
  }
}
