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
        color: Color(rnd.nextInt(0xffffffff)),
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                child: Image.asset(
                  "assets/images/dish.png",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 5,
                top: 5,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white60,
                  child: IconButton(
                    key: Key('favorites_text_$snapshot.data[index]'),
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
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
            ]),
            Container(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(dishes[0].title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          shadows: [
                            Shadow(
                                // bottomLeft
                                offset: Offset(-1.5, -1.5),
                                color: Colors.white),
                            Shadow(
                                // bottomRight
                                offset: Offset(1.5, -1.5),
                                color: Colors.white),
                            Shadow(
                                // topRight
                                offset: Offset(1.5, 1.5),
                                color: Colors.white),
                            Shadow(
                                // topLeft
                                offset: Offset(-1.5, 1.5),
                                color: Colors.white),
                          ],
                          fontWeight: FontWeight.bold)),
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
