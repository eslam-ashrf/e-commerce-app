import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/components/component.dart';
import '../../shared/network/remote/cash_helper.dart';
import '../../shared/styles/colors.dart';
import '../login/login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
      image: "assets/images/onboard.png",
      title: "onBoarding 1 title",
      body: "screen 1 body",
    ),
    BoardingModel(
      image: "assets/images/onboard.png",
      title: "onBoarding 2 title",
      body: "screen 2 body",
    ),
    BoardingModel(
      image: "assets/images/onboard.png",
      title: "onBoarding 3 title",
      body: "screen 3 body",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: (){
                submit();              },
              child: Text("SKIP")

          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => pageViewItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SmoothPageIndicator(
              controller: boardController,
              count: boarding.length,
              effect: ExpandingDotsEffect(
                activeDotColor:defaultColor(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: Duration(seconds: 3),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  void submit(){
    CashHelper.saveData(key: "onBoarding", value: true).then((value){
      navigatAndFinish(context, LoginScreen());
    });
  }
  Widget pageViewItem(BoardingModel model) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            Expanded(
              child: Image(
                image: AssetImage(model.image),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              model.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              model.body,
            ),
          ],
        ),
      );
}
