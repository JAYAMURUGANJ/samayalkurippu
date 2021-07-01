import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:samayalkurippu/model/categories.dart';
import 'package:samayalkurippu/view/widgets/customAppBar.dart';
import 'package:samayalkurippu/view/widgets/customDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';
import '../widgets/categorieCard.dart';

class CategoryListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryListPageState();
  }
}

class _CategoryListPageState extends State<CategoryListPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<List<String>> _favItemCount;

  Future<void> getFav() async {
    final SharedPreferences prefs = await _prefs;
    final List<String> fcount = (prefs.getStringList('favoriteKey') ?? []);

    setState(() {
      _favItemCount =
          prefs.setStringList("favoriteKey", fcount).then((bool success) {
        return fcount;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getFav();
    _favItemCount = _prefs.then((SharedPreferences prefs) {
      return (prefs.getStringList('favoriteKey') ?? []);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomAppBar(),
        ),
        drawer: CustomDrawer(favItemCount: _favItemCount),
        body: SingleChildScrollView(
          child: LayoutBuilder(builder: (context, constraints) {
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
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: foodCategory.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ccount,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return foodCategory[index].id == "about"
                          ? Card(
                              color: Colors.deepPurple,
                              margin: EdgeInsets.only(
                                  left: 8, right: 8, bottom: 24),
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              child: Container(
                                child: Center(
                                    child: Text("About us",
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              ))
                          : CategorieCard(
                              categories: Categories(
                                  name: foodCategory[index].name,
                                  id: foodCategory[index].id,
                                  image: foodCategory[index].image,
                                  desc: foodCategory[index].desc),
                              randcolor: Color(rnd.nextInt(0xFFCCC91D)),
                            );
                    },
                  )),
            );
          }),
        ),
      ),
    );
  }
}
