import 'package:card_swiper/card_swiper.dart';
import 'package:devera_news_app/models/news_model.dart';
import 'package:devera_news_app/provider/news_provider.dart';
import 'package:devera_news_app/widget/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Utility/utils.dart';
import '../../widget/top_trending_widget.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Trending",
          style: GoogleFonts.lobster(
            color: color,
            fontSize: 20,
            letterSpacing: 0.6,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<NewsModel>>(
              future: newsProvider.fetchTopHeadline(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Expanded(
                    child: EmptyNewWidget(
                      text: "an error occured ${snapshot.error}",
                      imagePath: "assets/images/no_news.png",
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Expanded(
                    child: EmptyNewWidget(
                      text: "No news found",
                      imagePath: "assets/images/no_news.png",
                    ),
                  );
                }
                return Center(
                  child: SizedBox(
                    height: size.height * 0.7,
                    child: Swiper(
                      layout: SwiperLayout.STACK,
                      autoplayDelay: 7000,
                      autoplay: true,
                      itemWidth: size.width * 0.9,
                      viewportFraction: 0.9,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: snapshot.data?[index],
                          child: const TopTrendingWidget(),
                        );
                      },
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
