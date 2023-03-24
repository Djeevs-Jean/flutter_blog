import 'package:blog_horizon/article_item.dart';
import 'package:flutter/material.dart';

class ArticleDatailPage extends StatelessWidget {
  final ArticleItem articleItem;
  const ArticleDatailPage({Key? key, required this.articleItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(articleItem.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(articleItem.imageUrl, fit: BoxFit.cover, width: double.infinity, height: 400,),
            const SizedBox(height: 16,),
            Text(articleItem.summary, style: TextStyle(fontSize: 22, ),),
          ],
          ), 
      ),
    );
  }
  
}