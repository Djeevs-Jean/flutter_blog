import 'dart:convert';

import 'package:flutter/material.dart';
import 'article_item.dart';
import 'article_detail.dart';
import 'package:http/http.dart' as http;



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Blog Horizon')
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late List<ArticleItem> _articles;
  // static List<ArticleItem> articles = ArticleData.articles;

  Future<List<ArticleItem>> _getArticles() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if(response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ArticleItem> articles = body.map((item) => ArticleItem.fromJSON(item)).toList();
      return articles;
    } else {
      throw Exception('Failed to fetch articles');
    }
  }

  void navigateToArticleDetailPage(ArticleItem article) {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => ArticleDatailPage(articleItem: article))
    );
  }

  @override
  void initState() {
    super.initState();
    _getArticles().then((value){
      setState(() {
        _articles = value;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // Récupère les dimensions de l'écran

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppTheme.primaryColor, ),
              child: Column(
                children: [
                  Center(
                    child: Text("Application Blog Horizon", 
                    style: AppTheme.titleTextStyle.copyWith(color: Colors.white),)
                  ),
                  const SizedBox(height: 23,),
                  const Icon(Icons.supervised_user_circle, size: 65,)
                ],
            )),
            ListTile(title: const Text("Account",), onTap: () {},),
            ListTile(title: const Text("Login",), onTap: () {},),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // ignore: unnecessary_null_comparison
      body:ListView.builder(
        padding: const EdgeInsets.all(10),
        // itemCount: _articles.length, 
        itemCount: _articles.length,

        itemBuilder: (BuildContext context, int index) {  
          final article = _articles[index];
          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                const SizedBox(height: 16.0,),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   // child: Image.network(article.imageUrl, fit: BoxFit.cover, width: double.infinity, height: 200, ),
                // ),
                // Image.network(article.imageUrl, fit: BoxFit.cover, width: size.width /1, height: size.height /4,),

                const SizedBox(height: 8.0,),
                Text(article.title, style: AppTheme.titleTextStyle,),
                // const SizedBox(height: 8.0,),
                // Text(article.date),
                const SizedBox(height: 8.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10), 
                  child: Text(
                    SubtitleSplit(article.body).subtitleString(), 
                    style: AppTheme.subtitleTextStyle,),
                ),
                const SizedBox(height: 8.0,),
                ElevatedButton(
                  onPressed: () { 
                    navigateToArticleDetailPage(article);
                  }, 
                  style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(100, 40))
                  ), child: const Text('Read more',),),
                const SizedBox(height: 8.0,),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AppTheme {
  static const Color primaryColor = Colors.pink;
  static const Color textColor = Colors.black;
  static const Color buttonColor = Colors.pink;
  static const Color backgroundColor = Colors.white;
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 22, 
    fontWeight: FontWeight.bold, 
    color: textColor
  );
  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 16,
    color: textColor
  );  
  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: textColor
  );
}

class SubtitleSplit {
  final String value;

  SubtitleSplit(this.value);

  String subtitleString() {
    int N = 200;
    int countString = value.length;
    if (countString > N) {
      return "${value.substring(0, N)}...";
    } else {
      return value;
    }
  }

}

// class ArticleData {
//     static List<ArticleItem> articles = [
//     ArticleItem(title: 'Article 1', date: '21 mars 2023', summary:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', imageUrl: 'https://picsum.photos/seed/picsum/200/300', ),
//     ArticleItem(title: 'Article 2', date: '21 mars 2023', summary:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', imageUrl: 'https://picsum.photos/seed/picsum/200/300', ),
//     ArticleItem(title: 'Article 3', date: '21 mars 2023', summary:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', imageUrl: 'https://picsum.photos/seed/picsum/200/300', ),
//     ArticleItem(title: 'Article 4', date: '21 mars 2023', summary:'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', imageUrl: 'https://picsum.photos/seed/picsum/200/300', ),
//   ];
// }

