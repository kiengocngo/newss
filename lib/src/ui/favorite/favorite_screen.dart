import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/sqflite/sqflite_service.dart';
import 'package:news_app/src/components/dialog/custom_dialog.dart';
import 'package:news_app/src/components/favorite_items/favorite_item.dart';
import 'package:news_app/src/models/favorite/categories.dart';
import 'package:news_app/src/ui/favorite/add_cateogry.dart';
import 'package:news_app/theme/news_theme_data.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Categories> _categories = [];

  void _refreshJournals() async {
    final data = await SQLHelper.getAll();
    setState(() {
      _categories = data;
    });
  }

  void _deleteCategory(String category) {
    SQLHelper.deleteItem(category).then((value) => Navigator.pop(context));
    _refreshJournals();
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
        backgroundColor: Colors.white,
        elevation: 0.25,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Danh mục đang theo dõi',
          style: NewsThemeData.fromContext(context).textNewsTitle,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddCategory()));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                CupertinoIcons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _categories.isEmpty
            ? Center(
                child: Text(
                  'Bạn chưa theo dõi loại tin tức nào, \nChọn + để theo dõi thêm danh mục',
                  style: NewsThemeData.fromContext(context).textNewsTitle,
                ),
              )
            : GridView.builder(
                itemCount: _categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return FavoriteItems(
                    category: _categories[index].description,
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialogBox(
                            title: 'Cảnh báo',
                            descriptions:
                                'Bạn có muốn huỷ theo dõi tin tức ${_categories[index].description}',
                            okText: 'Bỏ theo dõi',
                            cancelText: 'Huỷ',
                            okHandle: () {
                              _deleteCategory(_categories[index].description);
                            },
                            img: Image.network(
                                'https://cdn.popsww.com/blog/sites/2/2022/02/Edogawa-Conan-.jpg'))),
                  );
                },
              ),
      ),
    );
  }
}
