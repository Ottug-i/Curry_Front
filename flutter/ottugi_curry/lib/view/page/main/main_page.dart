import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final bookTooltip = JustTheController();
  final humanTooltip = JustTheController();
  final ladleTooltip = JustTheController();

  bool isClicked = false;

  void showBookTooltip() {
    bookTooltip.showTooltip();
  }

  void showHumanTooltip() {
    humanTooltip.showTooltip();
  }

  void showLadleTooltip() {
    ladleTooltip.showTooltip();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isClicked ? Colors.grey : Colors.white,
      body: Center(
        child: Stack(
          children: [
            Container(
              alignment: const Alignment(0.0, 0.29),
              child: Image.asset(
                'assets/images/sofaandcarpet.png',
              ),
            ),
            Container(
                alignment: const Alignment(0.0, -1.15),
                child: isClicked
                    ? Image.asset(
                        'assets/images/light_on.png',
                        height: 215,
                      )
                    : Image.asset('assets/images/light.png')),
            Container(
              alignment: const Alignment(-1.0, 0.0),
              child: JustTheTooltip(
                controller: ladleTooltip,
                content: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '레시피 추천 받기',
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        title: Text('레시피'),
                       actions: [
                         ElevatedButton(onPressed: () {
                           Get.toNamed('/recipe');
                         }, child: Text('레시피 추천')),
                         ElevatedButton(onPressed: () {
                           Get.toNamed('/search');
                         }, child: Text('레시피 검색')),
                       ],
                      )
                    );
                    // Get.toNamed('/recipe');
                  },
                  child: Image.asset(
                    'assets/images/ladle.png',
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
            Container(
              alignment: const Alignment(-0.1, 0.0),
              child: JustTheTooltip(
                controller: humanTooltip,
                preferredDirection: AxisDirection.up,
                content: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '마이페이지로 이동',
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/user');
                  },
                  child: Image.asset(
                    'assets/images/human.png',
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
            Container(
              alignment: const Alignment(0.6, 0.1),
              child: JustTheTooltip(
                controller: bookTooltip,
                content: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '레시피 북마크 조회',
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/bookmark');
                  },
                  child: Image.asset(
                    'assets/images/book.png',
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
            Container(
                alignment: const Alignment(0.9, -0.9),
                child: IconButton(
                  iconSize: 50,
                  icon: isClicked
                      ? const Icon(Icons.close_rounded)
                      : const Icon(Icons.info_rounded),
                  color: lightColorScheme.primary,
                  onPressed: () {
                    debugPrint('onpressed 눌림');
                    setState(() {
                      isClicked = !isClicked;
                      if (isClicked == true) {
                        showBookTooltip();
                        showHumanTooltip();
                        showLadleTooltip();
                      }
                    });
                  },
                )),
          ],
        ),
      ),
    );
  }
}

Container textBox(String text, double x, double y) {
  return Container(
    alignment: Alignment(x, y),
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.orange),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    ),
  );
}
