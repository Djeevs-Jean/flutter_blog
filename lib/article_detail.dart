import 'package:blog_horizon/article_item.dart';
import 'package:flutter/material.dart';

class ArticleDatailPage extends StatelessWidget {
  final ArticleItem articleItem;
  
  const ArticleDatailPage({Key? key, required this.articleItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(articleItem.title)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16,),
            Text(articleItem.body, style: const TextStyle(fontSize: 22, ),),
          ],
          ), 
      ),
    );
  }
  
}