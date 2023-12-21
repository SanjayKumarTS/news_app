import 'package:flutter/material.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/views/news_details.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  final String? category;
  const NewsScreen({super.key, this.category});

  @override
  NewsScreenListState createState() => NewsScreenListState();
}

class NewsScreenListState extends State<NewsScreen> {
  late NewsService _newsService;
  List _news = [];

  @override
  void initState() {
    super.initState();
    _newsService = Provider.of<NewsService>(context, listen: false);
    loadNews(widget.category);
  }

  Future<void> loadNews([String? category]) async {
    var newsData = await _newsService.getNews(category: category);
    setState(() {
      _news = newsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_news.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.separated(
        itemCount: _news.length,
        itemBuilder: (context, index) {
          var article = _news[index];
          return ListTile(
            leading: article['urlToImage'] != null
                ? SizedBox(
                    width: 150, // specify the width
                    height: 150, // specify the height
                    child: Image.network(
                      article['urlToImage'],
                      fit: BoxFit.cover,
                    ),
                  )
                : null,
            title: Text(article['title'] ?? 'No Title'),
            subtitle: Text(
              article['description'] ?? 'No Description',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(article: article),
                ),
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 1),
      );
    }
  }
}
