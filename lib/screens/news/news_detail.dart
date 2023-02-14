import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../model_components/article.dart';
import '../../utils/size_config.dart';
import 'news_tile.dart';

class NewsDetail extends StatefulWidget {
  final Article item;
  const NewsDetail({Key? key, required this.item}) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(widget.item.articleUrl.toString(),
                        fit: BoxFit.cover),
                    SizedBox(
                      height: 12.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        widget.item.title.toString(),
                        style: TextStyle(
                            height: 1.3,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        widget.item.content.toString(),
                        style: TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.w100),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        widget.item.description.toString(),
                        style: TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.w100),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: 35, left: 0),
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                elevation: 10.0,
                fillColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20.0,
                  ),
                ),
                padding: EdgeInsets.all(2.0),
                shape: CircleBorder(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
