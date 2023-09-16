import 'dart:convert';
import 'dart:developer';

import 'package:devera_news_app/consts/api_consts.dart';
import 'package:devera_news_app/models/news_model.dart';
import 'package:flutter/cupertino.dart';

import '../models/bookmarks_model.dart';
import 'package:http/http.dart' as http;

class BookmarksProvider with ChangeNotifier {
  List<BookmarksModel> bookmarkList = [];

  Future<void> addToBookMark({required NewsModel news}) async {
    try {
      var uri = Uri.https(BASEURL_FIREBASE, "bookmarks.json");

      var response = await http.post(uri,
          body: json.encode(
            news.toJson(),
          ));
      log("response status: ${response.statusCode}");
      log("response body: ${response.body}");
    } catch (e) {
      rethrow;
    }
  }
}
