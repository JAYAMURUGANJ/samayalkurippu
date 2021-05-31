import 'package:flutter/material.dart';
import 'package:samayalkurippu/model/dishes.dart';
import 'package:samayalkurippu/model/favorites.dart';
import 'package:samayalkurippu/view/screens/DishDetailPage.dart';
import '../../constant.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard(
      {Key key,
      @required this.favoritesList,
      @required this.dishes,
      @required this.output,
      this.index,
      this.snapshot})
      : super(key: key);

  final Favorites favoritesList;
  final List<Dishes> dishes;
  final List<Dishes> output;
  final List<String> snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        color: Color(rnd.nextInt(0xFFCCC91D)),
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                child: Image.asset(
                  "assets/images/dish.png",
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      key: Key('favorites_text_$snapshot.data[index]'),
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        favoritesList.favoriteItems = snapshot;
                        favoritesList.remove(snapshot[index]);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Removed from favorites.'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ]),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.center,
                          child: Text(dishes[0].title,
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
        var fav = output.where((item) => item.id == snapshot[index]);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => new DishDetailsPage(
              dish: Dishes(
                id: fav.first.id,
                image: fav.first.image,
                title: fav.first.title,
                categoryId: fav.first.categoryId,
                youtubeVideoId: fav.first.youtubeVideoId,
                message: fav.first.message,
              ),
            ),
          ),
        );
      },
    );
  }
}
