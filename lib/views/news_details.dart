import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  final Map article;

  const NewsDetailScreen({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            article['urlToImage'] != null
                ? Image.network(article['urlToImage'])
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                      article['description'] ?? 'No description available',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  SelectableText('Source: ${article['source']['name']}'),
                  const SizedBox(height: 8),
                  SelectableText('Published At: ${article['publishedAt']}'),
                  const SizedBox(height: 8),
                  article['content'] != null
                      ? SelectableText(article['content'])
                      : const SizedBox.shrink(),
                  const SizedBox(height: 16),
                  article['url'] != null
                      ? TextButton(
                          child: const Text('Read full article'),
                          onPressed: () async {
                            final url = article['url'];
                            final scaffoldMessenger =
                                ScaffoldMessenger.of(context);

                            if (!await launchUrl(Uri.parse(url),
                                mode: LaunchMode.inAppBrowserView)) {
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text('Could not launch $url'),
                                ),
                              );
                            }
                          },
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
