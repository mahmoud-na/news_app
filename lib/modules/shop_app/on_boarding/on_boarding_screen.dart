import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/styles/colors.dart';

class OnBoardingModel {
  final String image;
  final String screenTitle;
  final String screenBody;

  OnBoardingModel({
    required this.image,
    required this.screenTitle,
    required this.screenBody,
  });
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardingController = PageController();

  List<OnBoardingModel> boardingList = [
    OnBoardingModel(
      image: "assets/images/1.jpg",
      screenTitle: 'OnBoarding Title Screen1',
      screenBody: 'OnBoarding Body Screen1',
    ),
    OnBoardingModel(
      image: "assets/images/2.jpg",
      screenTitle: 'OnBoarding Title Screen2',
      screenBody: 'OnBoarding Body Screen2',
    ),
    OnBoardingModel(
      image: "assets/images/3.jpg",
      screenTitle: 'OnBoarding Title Screen3',
      screenBody: 'OnBoarding Body Screen3',
    ),
  ];
  bool isLastIndex = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            text: 'skip',
            onPressed: () {
              navigateAndReplace(context, ShopLoginScreen());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildBoardingItem(index),
                itemCount: boardingList.length,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == boardingList.length - 1) {
                    setState(() {
                      isLastIndex = true;
                    });
                  } else {
                    setState(() {
                      isLastIndex = false;
                    });
                  }
                },
                controller: boardingController,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10.0,
                    expansionFactor: 4,
                    dotWidth: 10.0,
                    spacing: 5.0,
                  ),
                  count: boardingList.length,
                  onDotClicked: (index) {
                    boardingController.animateToPage(
                      index,
                      duration: const Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.ease,
                    );
                  },
                ),
                const Spacer(),
                FloatingActionButton(
                  child: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    if (isLastIndex) {
                      navigateAndReplace(context, ShopLoginScreen());
                    } else {
                      setState(() {
                        boardingController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      });
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(int index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(boardingList[index].image),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            boardingList[index].screenTitle,
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            boardingList[index].screenBody,
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      );
}
