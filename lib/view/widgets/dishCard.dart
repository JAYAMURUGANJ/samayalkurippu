import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samayalkurippu/model/dishes.dart';
import 'package:samayalkurippu/model/favorites.dart';
import 'package:samayalkurippu/view/screens/DishDetailPage.dart';

class DishCard extends StatelessWidget {
  final Dishes dish;
  final Color randcolor;
  DishCard({this.dish, this.randcolor});

  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<Favorites>(context);

    return InkWell(
      child: Card(
        color: randcolor,
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  child: Image.asset(
                    "assets/images/dish.png",
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  child: FutureBuilder<List<String>>(
                      future: Favorites.getfavoritItems(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<String>> snapshot) {
                        return snapshot.hasData
                            ? ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    key: Key('icon_$dish.id'),
                                    icon: snapshot.data.contains(dish.id)
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.pink,
                                          )
                                        : Icon(Icons.favorite_border),
                                    onPressed: () {
                                      favoritesList.favoriteItems =
                                          snapshot.data;
                                      !snapshot.data.contains(dish.id)
                                          ? favoritesList.add(dish.id)
                                          : favoritesList.remove(dish.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              snapshot.data.contains(dish.id)
                                                  ? 'Added to favorites.'
                                                  : 'Removed from favorites.'),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Container();
                      }),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.center,
                          child: Text(dish.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => new DishDetailsPage(
              dish: Dishes(
                id: dish.id,
                image: dish.image,
                title: dish.title,
                categoryId: dish.categoryId,
                youtubeVideoId: dish.youtubeVideoId,
                message: dish.message,
              ),
            ),
          ),
        );
      },
    );
  }
}
