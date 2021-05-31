import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samayalkurippu/model/favorites.dart';
import 'package:samayalkurippu/view/screens/CategoryPage.dart';
import 'package:samayalkurippu/view/screens/Favorite.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
    @required Future<List<String>> favItemCount,
  })  : _favItemCount = favItemCount,
        super(key: key);

  final Future<List<String>> _favItemCount;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.deepPurple,
                    child: Image.asset("assets/images/icon.png"),
                  ),
                  Expanded(
                    child: Text(
                      "Sammayal Kurippu",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          letterSpacing: 2,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  )
                ],
              ),
            ),
          ),
          DrawerBtn(
            btIcon: Icons.info_outlined,
            btText: "About Us",
            pageName: CategoryListPage(),
          ),
          DrawerBtn(
            btIcon: Icons.list_alt_outlined,
            btText: "Category",
            pageName: CategoryListPage(),
          ),
          DrawerBtn(
            btIcon: Icons.favorite_border_outlined,
            btText: "Favorite",
            pageName: FavoritesPage(),
            rightWidget: FavCount(favItemCount: _favItemCount),
          ),
          DrawerBtn(
            btIcon: Icons.star_border_outlined,
            btText: "Rate Us",
            pageName: CategoryListPage(),
          ),
          DrawerBtn(
            btIcon: Icons.video_call_outlined,
            btText: "Youtube Channels",
            pageName: CategoryListPage(),
          )
        ],
      ),
    ));
  }
}

class FavCount extends StatelessWidget {
  const FavCount({
    Key key,
    @required Future<List<String>> favItemCount,
  })  : _favItemCount = favItemCount,
        super(key: key);

  final Future<List<String>> _favItemCount;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: FutureBuilder<List<String>>(
          future: _favItemCount,
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            return snapshot.hasData
                ? Container(
                    child: Consumer<Favorites>(builder: (context, food, child) {
                    return Text(
                      food.favoriteItems.length != 0
                          ? food.favoriteItems.length.toString()
                          : snapshot.data.length.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                  }))
                : Text("0");
          }),
      backgroundColor: Colors.red,
    );
  }
}

class DrawerBtn extends StatelessWidget {
  final IconData btIcon;
  final String btText;
  final Widget pageName;
  final Widget rightWidget;
  const DrawerBtn({
    this.btIcon,
    this.btText,
    this.pageName,
    this.rightWidget,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pageName),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(
            btIcon,
            color: Colors.black,
          ),
          trailing: rightWidget,
          title: Text(
            btText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
