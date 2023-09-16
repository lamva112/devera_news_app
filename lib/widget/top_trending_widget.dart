import 'package:devera_news_app/Utility/utils.dart';
import 'package:devera_news_app/models/news_model.dart';
import 'package:devera_news_app/page/news_web_view/news_web_view_page.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../page/news_detail/new_detail_page.dart';

class TopTrendingWidget extends StatelessWidget {
  const TopTrendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final newsModelProvider = Provider.of<NewsModel>(context);
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, NewsDetailPage.routeName, arguments: newsModelProvider);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Hero(
                tag: newsModelProvider.publishedAt,
                child: FancyShimmerImage(
                  imageUrl: newsModelProvider.urlToImage,
                  boxFit: BoxFit.fill,
                  height: size.height * 0.33,
                  width: double.infinity,
                  errorWidget: Image.asset("assets/images/empty_image.png"),
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                newsModelProvider.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: NewsWebViewPage(
                          url:newsModelProvider.url
                        ),
                        inheritTheme: true,
                        ctx: context,
                      ),
                    );
                  },
                  icon: const Icon(Icons.link),
                ),
                const Spacer(),
                SelectableText(
                  newsModelProvider.dateToShow,
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
