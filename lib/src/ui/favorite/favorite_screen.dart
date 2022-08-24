import 'package:flutter/material.dart';
import 'package:news_app/src/components/dialog/custom_dialog.dart';
import 'package:news_app/src/components/favorite_items/favorite_item.dart';
import 'package:news_app/src/models/favorite/categories.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Categories> categories = [
    Categories(id: 1, description: 'Sports'),
    Categories(id: 2, description: 'Entertainment'),
    Categories(id: 3, description: 'Environment'),
    Categories(id: 4, description: 'Technology'),
    Categories(id: 5, description: 'Top'),
    Categories(id: 6, description: 'Anime'),
    Categories(id: 7, description: 'Esports'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => FavoriteItems(
          category: categories[index].description,
          onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialogBox(
                  title: 'Canh bao',
                  descriptions:
                      'Ban co muon huy theo doi ${categories[index].description}',
                  okText: 'Ok',
                  cancelText: 'Cancel',
                  okHandle: () {},
                  img: Image.network(
                      'https://cdn.popsww.com/blog/sites/2/2022/02/Edogawa-Conan-.jpg'))),
        ),
      ),
    ));
  }
}
