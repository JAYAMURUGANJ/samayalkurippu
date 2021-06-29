import 'package:flutter/material.dart';
import 'package:samayalkurippu/model/categories.dart';
import 'package:samayalkurippu/view/screens/dishPage.dart';

class CategorieCard extends StatelessWidget {
  final Color randcolor;
  final Categories categories;

  CategorieCard({this.categories, this.randcolor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        color: randcolor,
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                "assets/images/category.png",
                //height: MediaQuery.of(context).size.height / 8,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(categories.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
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
        int cid = int.parse(categories.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => new DishPage(
              categoryId: cid,
            ),
          ),
        );
      },
    );
  }
}
