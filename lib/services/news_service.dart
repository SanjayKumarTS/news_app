import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static final String _apiKey = dotenv.get('NEWS_API_KEY');
  static final String _baseUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKey';
  final Map<String, List> _cachedNews = {};
  final Map<String, DateTime> _lastFetchTimes = {};

  Future<List> getNews({String? category}) async {
    final cacheKey = category ?? 'top';
    final currentTime = DateTime.now();

    if (_lastFetchTimes.containsKey(cacheKey) &&
        currentTime.difference(_lastFetchTimes[cacheKey]!).inMinutes < 30) {
      return _cachedNews[cacheKey]!;
    }

    var url = category == null ? _baseUrl : '$_baseUrl&category=$category';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("Data not in cache");
      }
      var data = json.decode(response.body);
      var articlesWithImages = [];

      for (var article in data['articles']) {
        if (article['urlToImage'] != null &&
            article['urlToImage'].toString().isNotEmpty) {
          articlesWithImages.add(article);
        }
      }
      _cachedNews[cacheKey] = articlesWithImages;
      _lastFetchTimes[cacheKey] = currentTime;
    } else {
      // Handle error
    }
    return _cachedNews[cacheKey] ?? [];
  }
}
