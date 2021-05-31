import 'package:flutter/material.dart';
import 'package:flutter_html_textview_render/html_text_view.dart';
import 'package:samayalkurippu/model/categories.dart';
import 'package:samayalkurippu/model/dishes.dart';
import '../../constant.dart';

class DishDetailsPage extends StatefulWidget {
  final Dishes dish;
  DishDetailsPage({this.dish});

  @override
  _DishDetailsPageState createState() => _DishDetailsPageState();
}

class _DishDetailsPageState extends State<DishDetailsPage> {
  List<Categories> output = [];
  List<Categories> category = [];

  @override
  void initState() {
    super.initState();
    output = foodCategory;
    category = output
        .where((item) => item.id == widget.dish.categoryId.toString())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  stretchModes: <StretchMode>[
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                  title: Text(
                    category.first.name,
                    style: TextStyle(
                      color: Colors.orange[80],
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  background: Image.asset(
                    "assets/images/dish.png",
                    height: MediaQuery.of(context).size.height / 8,
                    fit: BoxFit.cover,
                  ),
                ),
                actions: [
                  CircleAvatar(
                    backgroundColor: appmainthemecolor,
                    child: IconButton(
                      icon: Icon(
                        Icons.share_outlined,
                        color: Colors.white,
                      ),
                      iconSize: 25,
                      onPressed: () {
                        print("share");
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ]),
          ];
        },
        body: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  tileColor: appmainthemecolor,
                  leading: Icon(Icons.list_sharp, color: Colors.white),
                  title: Text(
                    widget.dish.title,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.9, color: Colors.grey),
                  ),
                  child: Column(children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text("Workflow", style: TextStyle(fontSize: 30)),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: HtmlTextView(
                          data: widget.dish.message,
                          // anchorColor: Color(0xFFFF0000),
                        )))
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
