import 'package:flutter/material.dart';
import 'package:news_app/sqflite/sqflite_service.dart';
import 'package:news_app/src/components/dialog/custom_dialog.dart';
import 'package:news_app/src/components/favorite_items/favorite_item.dart';
import 'package:news_app/src/ui/favorite/add_cateogry.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, dynamic>> _categories = [];

  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _categories = data;
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
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddCategory()));
              },
              child: const Text('+'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            itemCount: _categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) => FavoriteItems(
              category: _categories[index]['description'],
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomDialogBox(
                      title: 'Canh bao',
                      descriptions: _categories[index]['description'],
                      okText: 'Ok',
                      cancelText: 'Cancel',
                      okHandle: () async {
                        SQLHelper.deleteItem(_categories[index]['description'])
                            .then((value) => Navigator.pop(context));
                      },
                      img: Image.network(
                          'https://cdn.popsww.com/blog/sites/2/2022/02/Edogawa-Conan-.jpg'))),
            ),
          ),
        ));
  }
}
