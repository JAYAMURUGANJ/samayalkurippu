import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:samayalkurippu/model/dishes.dart';
import 'package:samayalkurippu/view/widgets/customAppBar.dart';
import 'package:samayalkurippu/view/widgets/dishCard.dart';
import '../../constant.dart';
import 'Favorite.dart';

class DishPage extends StatefulWidget {
  final int categoryId;

  DishPage({this.categoryId});
  @override
  State<StatefulWidget> createState() {
    return _DishPageState();
  }
}

class _DishPageState extends State<DishPage> {
  List<Dishes> output;
  bool moreData;
  int current;
  static const int max = 1;
  List<Dishes> dishes = [];

  @override
  void initState() {
    super.initState();
    current = 0;
    output = [];
    output =
        dishList.where((item) => item.categoryId == widget.categoryId).toList();

    print(output.length);
    if (output.length > 0) {
      print(output.length);
      dishes.addAll(output.sublist(current, max));
    } else {
      dishes = null;
    }

    setState(() {});

    moreData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(),
        actions: [
          IconButton(
              icon: Icon(Icons.favorite_border_sharp),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesPage(),
                  )))
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        int ccount;
        if (constraints.maxWidth < 768) {
          ccount = 2;
        } else if (constraints.maxWidth >= 768 && constraints.maxWidth < 1024) {
          ccount = 4;
        } else {
          ccount = 6;
        }
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: dishes != null
                ? SingleChildScrollView(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: moreData ? dishes.length + 1 : dishes.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ccount,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (dishes.length == index) {
                          return InkWell(
                            child: Card(
                                color: Colors.deepPurple,
                                margin: EdgeInsets.only(
                                    left: 8, right: 8, bottom: 24),
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32)),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.refresh, color: Colors.white),
                                      Text(
                                        "Load More",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            onTap: () {
                              setState(() {
                                current = current + max;
                                if (current + max >= output.length) {
                                  moreData = false;
                                  dishes.addAll(
                                      output.sublist(current, output.length));
                                } else {
                                  dishes.addAll(
                                      output.sublist(current, max + current));
                                  moreData = true;
                                }
                              });
                            },
                          );
                        } else {
                          return DishCard(
                              randcolor: Color(rnd.nextInt(0xFFCCC91D)),
                              dish: Dishes(
                                id: dishes[index].id,
                                image: dishes[index].image,
                                title: dishes[index].title,
                                categoryId: dishes[index].categoryId,
                                youtubeVideoId: dishes[index].youtubeVideoId,
                                message: dishes[index].message,
                              ));
                        }
                      },
                    ),
                  )
                : Container(
                    child: Center(
                        child: Text(
                      'No Dishes Found',
                      style: TextStyle(fontSize: 21),
                    )),
                  ));
      }),
    );
  }
}
