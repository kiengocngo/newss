import 'package:flutter/material.dart';
import 'package:news_app/theme/news_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        crossFadeState = CrossFadeState.showSecond;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: AnimatedCrossFade(
        duration: const Duration(seconds: 2),
        crossFadeState: crossFadeState,
        firstChild: const Center(
          child: Icon(
            Icons.ac_unit,
            color: Colors.red,
            size: 50,
          ),
        ),
        secondChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: NewsColor.bgTextForm,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
              ),
            ],
          ),
        ),
        firstCurve: Curves.bounceIn,
        secondCurve: Curves.easeInBack,
      ),
    );
  }
}
