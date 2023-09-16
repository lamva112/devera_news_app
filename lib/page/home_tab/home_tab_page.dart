import 'package:devera_news_app/Utility/utils.dart';
import 'package:devera_news_app/consts/vars.dart';
import 'package:devera_news_app/provider/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widget/articles_widget.dart';
import '../../widget/empty_screen.dart';
import '../../widget/loading_widget.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  String sortBy = SortByEnum.publishedAt.name;

  @override
  Widget build(BuildContext context) {
    final newProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "News",
          style: GoogleFonts.lobster(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 30,
              letterSpacing: 0.6,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              IconlyLight.search,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "All news",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.filter,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            FutureBuilder(
              future: newProvider.fetchAllNews(sortBy: sortBy),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingWidget();
                } else if (snapshot.hasError) {
                  return Expanded(
                    child: EmptyNewWidget(
                      text: "an error occured ${snapshot.error}",
                      imagePath: "assets/images/no_news.png",
                    ),
                  );
                } else if (snapshot.data == null) {
                  return const Expanded(
                    child: EmptyNewWidget(
                      text: "No news found",
                      imagePath: "assets/images/no_news.png",
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: snapshot.data?[index],
                          child: ArticlesWidget(),
                        );
                      }),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
