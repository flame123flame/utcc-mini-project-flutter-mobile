import 'dart:math';

import 'package:flutter/material.dart';

import '../../model_components/article.dart';
import 'news_detail.dart';

class NewsTile extends StatelessWidget {
  final String? imgUrl, title, desc, content, posturl;
  final Article item;
  NewsTile(
      {this.imgUrl,
      this.desc,
      this.title,
      this.content,
      required this.item,
      @required this.posturl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetail(
                      item: item,
                    )));
        print(item.articleUrl);
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        imgUrl!,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    title!,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.black87,
                        height: 1.3,
                        fontSize: 17,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    desc!,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
