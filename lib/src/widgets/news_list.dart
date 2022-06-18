import 'package:flutter/material.dart';
import 'package:news_app/src/theme/darktheme.dart';

import '../models/news_models.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;

  const NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (BuildContext context, int index) {
        return _Article(article: news[index], index: index);
      },
    );
  }
}

class _Article extends StatelessWidget {
  final Article article;
  final int index;

  const _Article({required this.article, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBar(
          news: article,
          index: index,
        ),
        _Title(article: article),
        _Image(article: article),
        _Description(article: article),
        _BottomBar(),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: darkTheme.colorScheme.secondary,
            elevation: 5,
            padding: const EdgeInsets.all(5),
            child: const Icon(Icons.star_border),
          ),
          const SizedBox(width: 10),
          RawMaterialButton(
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: Colors.blue,
            elevation: 5,
            padding: const EdgeInsets.all(5),
            child: const Icon(Icons.more),
          ),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final Article article;

  const _Description({required this.article});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        article.description != null ? article.description! : '',
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final Article article;

  const _Image({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            child: article.urlToImage != null
                ? FadeInImage(
                    placeholder: const AssetImage('assets/img/giphy.gif'),
                    image: NetworkImage(article.urlToImage!),
                    fit: BoxFit.cover,
                  )
                : const Image(
                    image: AssetImage('assets/img/no-image.png'),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final Article article;

  const _Title({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        article.title!,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final Article news;
  final int index;

  const _TopBar({required this.news, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: <Widget>[
          Text(
            '${index + 1}. ',
            style: TextStyle(color: darkTheme.colorScheme.secondary),
          ),
          Text('${news.source?.name}')
        ],
      ),
    );
  }
}
