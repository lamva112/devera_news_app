import 'package:devera_news_app/services/news_api.dart';
import 'package:flutter/cupertino.dart';

import '../models/news_model.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> _newsList = [];
  List<NewsModel> _trendingList = [];

  List<NewsModel> get getNewsList {
    return _newsList;
  }

  Future<List<NewsModel>> fetchAllNews({required String sortBy}) async {
    _newsList = await NewsApiService.getAllNews(sortBy: sortBy);
    return _newsList;
  }

  Future<List<NewsModel>> fetchTopHeadline() async {
    _trendingList = await NewsApiService.getTopHeadLine();
    return _trendingList;
  }
}