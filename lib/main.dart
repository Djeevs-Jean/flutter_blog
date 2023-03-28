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
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Blog Flutter')
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late List<ArticleItem> _articles;
  bool _isLoading = true; 

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
        _isLoading = false;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.deepPurple, ),
              child: Column(
                children: [
                  Center(
                    child: Text("Application Blog Flutter", 
                    style: AppTheme.titleTextStyle.copyWith(color: Colors.white),)
                  ),
                  const SizedBox(height: 23,),
                  const Icon(Icons.verified_user_rounded, size: 65,)
                ],
            )),
            ListTile(title: const Text("Account",), onTap: () {},),
            ListTile(title: const Text("FAQ",), onTap: () {},),
          ],
        ),
      ),
      appBar: AppBar(
        title: Center(child:Text(widget.title)),
      ),
      body: _isLoading // check if articles are being fetched
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: _articles.length,

        itemBuilder: (BuildContext context, int index) {  
          final article = _articles[index];
          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                const SizedBox(height: 8.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(article.title, style: AppTheme.titleTextStyle,),
                ),
                
                const SizedBox(height: 8.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10), 
                  child: Text(
                    CasterBodyText(article.body).subtitleString(), 
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
  static const Color textColor = Colors.black;
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 16, 
    fontWeight: FontWeight.bold, 
    color: textColor
  );
  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 12,
    color: textColor
  );  
  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: textColor
  );
}

class CasterBodyText {
  final String value;

  CasterBodyText(this.value);

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

