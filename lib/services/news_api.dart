import 'dart:convert';
import 'dart:developer';

import 'package:devera_news_app/models/bookmarks_model.dart';

import '../consts/api_consts.dart';
import '../consts/http_exceptions.dart';
import '../models/news_model.dart';
import 'package:http/http.dart' as http;


class NewsApiService {
  static Future<List<NewsModel>> getAllNews({required String sortBy}) async {
    try{
      var uri = Uri.https(BASEURL, "v2/everything",{
        "q":"bitcoin",
        "domains":"techcrunch.com",
        "sortBy":sortBy,
      });

      var response = await http.get(uri,headers: {"X-Api-key":API_KEY});
      //log("response data ${response.body}");
      Map data = jsonDecode(response.body);

      List newTempList = [];

      if(data['code'] != null){
        throw HttpException(data['code']);
      }

      for (var v in data["articles"]){
        newTempList.add(v);
      }

      return NewsModel.newsFromSnapshot(newTempList);

    }catch (e){
      throw e.toString();
    }
  }

  static Future<List<NewsModel>> getTopHeadLine() async {
    try{
      var uri = Uri.https(BASEURL,"v2/top-headlines",{'country':'us'});
      
      var response = await http.get(uri,headers: {"X-Api-key":API_KEY});

      log("response status : ${response.statusCode}");

      print(response.body);

      Map data = jsonDecode(response.body);

      List newTempList = [];

      if(data['code'] != null){
        throw HttpException(data['code']);
      }

      for (var v in data["articles"]){
        newTempList.add(v);
      }

      return NewsModel.newsFromSnapshot(newTempList);

    }catch (e){
      throw e.toString();
    }
  }

  static Future<List<BookmarksModel>?> getBookmarks() async {
    try{
      var uri = Uri.https(BASEURL_FIREBASE,"bookmarks.json");
      var response = await http.get(uri);

      Map data = jsonDecode(response.body);
      List allKeys = [];

      if(data['code'] != null){
        throw HttpException(data['code']);
      }

      for(String key in data.keys){
        allKeys.add(key);
      }
      return BookmarksModel.bookmarksFromSnapshot(json: data, allKeys: allKeys);
    }catch (e){

    }
  }


}