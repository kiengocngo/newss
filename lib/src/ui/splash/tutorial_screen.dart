import 'package:flutter/material.dart';
import 'package:news_app/src/components/button/custom_button.dart';
import 'package:news_app/src/ui/home/home_screen.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animtionNextScreen;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(title: 'Next', onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
                })
              ],
            ),
          ),
        ));
  }
}
