import 'package:devera_news_app/page/news_detail/new_detail_page.dart';
import 'package:devera_news_app/provider/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'page/home/home_page.dart';
import 'provider/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    ThemeProvider themeChangeProvider = ThemeProvider();

    //Fetch the current theme
    void getCurrentAppTheme() async {
      themeChangeProvider.setDarkTheme =
      await themeChangeProvider.darkThemePreferences.getTheme();
    }

    @override
    void didChangeDependencies() {
      getCurrentAppTheme();
      super.didChangeDependencies();
    }



    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          //Notify about theme changes
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
        routes: {
          NewsDetailPage.routeName: (context) => const NewsDetailPage(),
        }
      ),
    );
  }
}

