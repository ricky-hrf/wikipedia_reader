import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:material_ui/material_ui.dart';

import 'summary.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ArticleViewModel(ArticleModel());

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Wikipedia Flutter')),
        body: const Center(child: Text('Check console for article data...')),
      ),
    );
  }
}

class ArticleModel {
    Future<Summary> getRandomArticleSummary() async {
        final uri = Uri.https(
            'en.wikipedia.org',
            '/api/rest_v1/page/random/summary',
        );

        final response = await get(uri);

        if(response.statusCode !=200){
            throw const HttpException('Failed to update resource');
        }

        return Summary.fromJson(jsonDecode(response.body) as Map<String, Object?>);
    }
}

class ArticleViewModel extends ChangeNotifier{
  final ArticleModel model;
  Summary? summary;
  Exception? error;
  bool isLoading = false;

  ArticleViewModel(this.model){
    fetchArticle();
  }

  Future<void> fetchArticle() async {
    isLoading = true;
    notifyListeners();
    try{
      summary =await model.getRandomArticleSummary();
      print('Article loaded: ${summary!.title}');
      error = null;
    } on HttpException catch (e){
      print('Error loading article: ${e.message}');
      error = e;
      summary = null;
    }

    isLoading = false;
    notifyListeners();
  }
}