import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isCliked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isCliked ? Colors.grey : Colors.white,
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
                child: isCliked
                    ? Image.asset(
                        'assets/images/light_on.png',
                        height: 215,
                      )
                    : Image.asset('assets/images/light.png')),
            Container(
              alignment: const Alignment(-1.0, 0.0),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/recipe');
                },
                child: Image.asset(
                  'assets/images/ladle.png',
                  fit: BoxFit.none,
                ),
              ),
            ),
            //textBox('레시피 추천받기', -1.0, 1.0),
            Container(
              alignment: const Alignment(-0.1, 0.0),
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
            Container(
              alignment: const Alignment(0.6, 0.1),
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
            Container(
                alignment: const Alignment(0.9, -0.9),
                child: IconButton(
                  iconSize: 50,
                  icon: isCliked
                      ? const Icon(Icons.close_rounded)
                      : const Icon(Icons.info_rounded),
                  color: lightColorScheme.primary,
                  onPressed: () {
                    debugPrint('onpressed 눌림');
                    setState(() {
                      isCliked = !isCliked;
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
