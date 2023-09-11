import 'package:devera_news_app/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utility/utils.dart';

class NewsDetailPage extends StatefulWidget {
  static const routeName = "/NewsDetailScreen";

  const NewsDetailPage({super.key});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    final color = Utils(context).getColor;
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
          "By Bùi Khắc Lam",
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
                  "Chủ biệt thự dát vàng Thiện 'Soi' bị tuyên phạt 15 năm 6 tháng tù",
                  textAlign: TextAlign.justify,
                  style: titleTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "23/10/2024",
                          style: smallTextStyle,
                        ),
                      ),
                      Text(
                        "less than a minutes",
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
                  "https://static-images.vnncdn.net/files/publish/2023/9/11/w-tuyen-an-thien-soi-1-1261.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: Row(
                  children: [
                    Card(
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
                    Card(
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
                  "Hội đồng xét xử nhận định bị cáo Thiện “Soi” và con trai không bị oan, mặc dù biết hành vi cho vay lãi nặng là vi phạm pháp luật nhưng vì hám lợi, muốn kiếm tiền nhanh chóng nên vẫn cố ý thực hiện.",
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
                  "Cụ thể, toà tuyên phạt bị cáo Thiện “Soi” 2 năm 6 tháng tù về tội Cho vay lãi nặng trong giao dịch dân sự và 13 năm tù về tội Rửa tiền. Tổng hợp hình phạt chung là 15 năm 6 tháng tù.",
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
