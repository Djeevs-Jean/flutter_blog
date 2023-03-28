import 'package:blog_horizon/article_item.dart';
import 'package:flutter/material.dart';

class ArticleDatailPage extends StatelessWidget {
  final ArticleItem articleItem;
  
  const ArticleDatailPage({Key? key, required this.articleItem}) : super(key: key);
  final String imageUrl = "https://placehold.co/300x400.png";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(articleItem.title)),
        // title: Center(child: Text("Article ${articleItem.id}")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity, height: 400,),
            const SizedBox(height: 16,),
            Text(articleItem.body, style: const TextStyle(fontSize: 22, ),),
          ],
          ), 
      ),
    );
  }
  
}