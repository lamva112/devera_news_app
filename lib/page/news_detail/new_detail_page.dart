import 'package:devera_news_app/consts/styles.dart';
import 'package:devera_news_app/models/news_model.dart';
import 'package:devera_news_app/provider/bookmarks_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../Utility/utils.dart';
import '../../services/global_methods.dart';

class NewsDetailPage extends StatefulWidget {
  static const routeName = "/NewsDetailScreen";

  const NewsDetailPage({super.key});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late NewsModel newsModel;
  @override
  void didChangeDependencies() {
    try{
      newsModel = ModalRoute.of(context)!.settings.arguments as NewsModel;
    }catch (e){
      print("get news error ${e}");
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final color = Utils(context).getColor;
    final bookmarksProvider = Provider.of<BookmarksProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(IconlyLight.arrowLeft2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "By ${newsModel.authorName}",
          textAlign: TextAlign.center,
          style: TextStyle(color: color),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newsModel.title,
                  textAlign: TextAlign.justify,
                  style: titleTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          newsModel.dateToShow,
                          style: smallTextStyle,
                        ),
                      ),
                      Text(
                        newsModel.readingTimeText,
                        style: smallTextStyle,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Image.network(
                  newsModel.urlToImage,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        try {
                          await Share.share(newsModel.url);
                        }catch (e){
                          GlobalMethods.errorDialog(errorMessage: e.toString(), context: context);
                        }
                      },
                      child: Card(
                        elevation: 10,
                        shape: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            IconlyLight.send,
                            size: 28,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        bookmarksProvider.addToBookMark(news: newsModel);
                      },
                      child: Card(
                        elevation: 10,
                        shape: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            IconlyLight.bookmark,
                            size: 28,
                            color: color,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 10),
                  child: SelectableText(
                    "Description",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SelectableText(
                  newsModel.description,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.justify,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 10),
                  child: SelectableText(
                    "Content",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SelectableText(
                  newsModel.content,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
