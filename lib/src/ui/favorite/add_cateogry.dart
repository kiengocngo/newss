import 'package:flutter/material.dart';
import 'package:news_app/sqflite/sqflite_service.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  List<String> categoires = [
    'Sprots',
    'Entertainment',
    'Environment',
    'Food',
    'Health',
  ];
  late List<Map<String, dynamic>> listCateogry = [];
  void getCategory() async {
    final data = await SQLHelper.getItem('Sports');
    setState(() {
      listCateogry = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () {
              listCateogry.isNotEmpty
                  ? Navigator.pop(context)
                  : SQLHelper.createItem('Sports');
            },
            child: Card(
              child: Container(
                  height: 50,
                  color: listCateogry.isNotEmpty ? Colors.red : Colors.green,
                  child: const Center(child: Text('Sports'))),
            ),
          ),
        ),
      ),
      // Expanded(
      //   child: ListView.separated(
      //       separatorBuilder: (context, index) => const SizedBox(
      //             height: 6,
      //           ),
      //       itemCount: categoires.length,
      //       itemBuilder: (context, index) {
      //         return Text(categoires[index]);
      //       }),
      // ),
    );
  }
}
