import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/sqflite/sqflite_service.dart';
import 'package:news_app/src/models/favorite/categories.dart';
import 'package:news_app/src/ui/favorite/favorite_screen.dart';
import 'package:news_app/theme/news_colors.dart';
import 'package:news_app/theme/news_theme_data.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  List<Categories> categoires = [
    Categories(description: 'sports'),
    Categories(description: 'entertainment'),
    Categories(description: 'environment'),
    Categories(description: 'food'),
    Categories(description: 'health'),
    Categories(description: 'top'),
    Categories(description: 'world'),
    Categories(description: 'business'),
    Categories(description: 'science'),
    Categories(description: 'technology'),
    Categories(description: 'politics'),
  ];
  late List<Categories> sports = [];
  String capitalizeFirstLetter(String str) =>
      str[0].toUpperCase() + str.substring(1);
  void _creatCategory(Categories category) {
    SQLHelper.createItem(category);
    _refreshJournals();
  }

  List<Categories> category = [];

  void _refreshJournals() async {
    final data = await SQLHelper.getAll();
    setState(() {
      category = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Danh mục tin tức',
          style: NewsThemeData.fromContext(context).textNewsTitle,
        ),
        backgroundColor: Colors.white,
        elevation: 0.25,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const FavoriteScreen()));
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  crossAxisCount: 2,
                ),
                itemCount: categoires.length,
                itemBuilder: (context, index) {
                  var contains = category.where(
                      (e) => e.description == categoires[index].description);
                  return GestureDetector(
                    onTap: () {
                      contains.isNotEmpty
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const FavoriteScreen()))
                          : _creatCategory(Categories(
                              description: categoires[index].description));
                    },
                    child: Stack(
                      children: [
                        Card(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: NewsColor.kGradient,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                                child: Text(capitalizeFirstLetter(
                                    categoires[index].description))),
                          ),
                        ),
                        Positioned(
                            top: 12,
                            right: 12,
                            child: contains.isEmpty
                                ? Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: NewsColor.button1,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Theo dõi',
                                      style: NewsThemeData.fromContext(context)
                                          .textHotNews,
                                    ))
                                : Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: NewsColor.button1,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Đã theo dõi',
                                      style: NewsThemeData.fromContext(context)
                                          .textHotNews,
                                    ))),
                      ],
                    ),
                  );
                })),
      ),
    );
  }
}
