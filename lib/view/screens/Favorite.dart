import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:samayalkurippu/model/dishes.dart';
import 'package:samayalkurippu/model/favorites.dart';
import 'package:samayalkurippu/view/widgets/customAppBar.dart';
import 'package:samayalkurippu/view/widgets/favoriteCard.dart';
import '../../constant.dart';

class FavoritesPage extends StatefulWidget {
  static String routeName = '/favorites_page';

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Dishes> dishes = [];
  List<Dishes> output = [];

  @override
  void initState() {
    super.initState();
    output = dishList;
  }

  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<Favorites>(context);
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(),
      ),
      body: FutureBuilder<List<String>>(
        future: Favorites.getfavoritItems(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          return snapshot.hasData
              ? snapshot.data.length != 0
                  ? LayoutBuilder(builder: (context, constraints) {
                      int ccount;
                      if (constraints.maxWidth < 768) {
                        ccount = 2;
                      } else if (constraints.maxWidth >= 768 &&
                          constraints.maxWidth < 1024) {
                        ccount = 4;
                      } else {
                        ccount = 6;
                      }
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              itemCount: snapshot.data.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: ccount,
                              ),
                              itemBuilder: (context, index) {
                                dishes = output
                                    .where((item) =>
                                        item.id == snapshot.data[index])
                                    .toList();
                                return FavoriteCard(
                                    index: index,
                                    snapshot: snapshot.data,
                                    favoritesList: favoritesList,
                                    dishes: dishes,
                                    output: output);
                              }),
                        ),
                      );
                    })
                  : Center(
                      child: Text(
                        "No Favorite Items Found...",
                        style: TextStyle(fontSize: 21),
                      ),
                    )
              : Center(
                  child: Text(
                    "No Favorite Items Found...",
                    style: TextStyle(fontSize: 21),
                  ),
                );
        },
      ),
    );
  }
}
