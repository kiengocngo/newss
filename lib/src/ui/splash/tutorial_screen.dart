import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/src/components/button/custom_button.dart';
import 'package:news_app/src/models/tutorial/tutorial_model.dart';
import 'package:news_app/theme/icon.dart';
import 'package:news_app/theme/news_theme_data.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animtionNextScreen;
  int currentPage = 0;
  late Timer timer;
  PageController pageController = PageController(
    initialPage: 0,
  );
  final List<Tutorial> listBoarding = [
    Tutorial(
        img: NewsIcon.icSports, title: 'Tin tuc the thao noi bat trong ngay'),
    Tutorial(img: NewsIcon.icEntertainment, title: 'Tin tuc giai tri nong hoi'),
    Tutorial(img: NewsIcon.icEnvironment, title: 'Tinh hinh moi truong'),
  ];
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer1) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: listBoarding.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(listBoarding[index].img),
                                  fit: BoxFit.fill),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 10, 16, 10),
                                  child: Text(
                                    listBoarding[index].title,
                                    style: NewsThemeData.fromContext(context)
                                        .textTutorial,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: CustomButton(
                            title: 'Next',
                            onTap: () {
                              Navigator.pushNamed(context, '/log_in');
                            }),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
