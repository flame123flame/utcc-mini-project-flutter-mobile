import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ttttt"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Text("test test",
                    style: TextStyle(color: Colors.red, fontSize: 30)),
                Text("test test",
                    style: TextStyle(color: Colors.red, fontSize: 30)),
                Text("test test",
                    style: TextStyle(color: Colors.red, fontSize: 30)),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.add_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.add_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.add_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.add_outlined),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
