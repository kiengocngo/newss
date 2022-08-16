import 'package:flutter/material.dart';
import 'package:news_app/src/ui/splash/tutorial_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation containerRadiusAnimtaion,
      containerSizeAnimation,
      containerColorAnimation;
  late AnimationController containerAnimationController;
  @override
  void initState() {
    super.initState();
    containerAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    containerRadiusAnimtaion = BorderRadiusTween(
            begin: BorderRadius.circular(0), end: BorderRadius.circular(20))
        .animate(CurvedAnimation(
            parent: containerAnimationController, curve: Curves.ease));
    containerColorAnimation = ColorTween(begin: Colors.grey, end: Colors.red)
        .animate(CurvedAnimation(
            parent: containerAnimationController, curve: Curves.ease));
    containerSizeAnimation = Tween(begin: 20, end: 25).animate(CurvedAnimation(
        parent: containerAnimationController, curve: Curves.ease));

    containerAnimationController.forward();

    Future.delayed(const Duration(seconds: 6), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const TutorialScreen()));
    });
  }

  @override
  void dispose() {
    containerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: containerAnimationController,
        builder: (context, child) => Container(
          decoration: BoxDecoration(
            borderRadius: containerRadiusAnimtaion.value,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.ac_unit,
                  color: containerColorAnimation.value,
                  size: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'NEWS',
                  style: TextStyle(
                      fontSize: 30,
                      color: containerColorAnimation.value,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
