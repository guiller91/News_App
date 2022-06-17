// ignore_for_file: prefer_const_declarations, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../models/news_models.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  final _urlNews = 'newsapi.org';
  final _apiKey = 'a79f0232d2914835a70fa5bede50c076';
  final _country = 'us';

  NewsService() {
    getTopHeadlines();
  }

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
}
