import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/list_page_button.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  CategoriesWidgetState createState() => CategoriesWidgetState();
}

class CategoriesWidgetState extends State<CategoriesWidget> {
  bool isTimeButtonClicked = false;
  bool tenMin = false;
  bool twentyMin = false;
  bool thirtyMin = false;

  bool isDiffButtonClicked = false;
  bool isCompButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              ListPageButton(
                text: '요리 시간',
                isButtonClicked: isTimeButtonClicked,
                themecolor: const Color(0xffFFD717),
                onPressed: () {
                  setState(() {
                    isTimeButtonClicked = !isTimeButtonClicked;
                    isDiffButtonClicked = false;
                    isCompButtonClicked = false;
                  });
                },
              ),
              const SizedBox(width: 10),
              ListPageButton(
                  text: '난이도',
                  isButtonClicked: isDiffButtonClicked,
                  themecolor: const Color(0xffFFD717),
                  onPressed: () {
                    setState(() {
                      isTimeButtonClicked = false;
                      isDiffButtonClicked = !isDiffButtonClicked;
                      isCompButtonClicked = false;
                    });
                  }),
              const SizedBox(width: 10),
              ListPageButton(
                text: '구성',
                isButtonClicked: isCompButtonClicked,
                themecolor: const Color(0xffFFD717),
                onPressed: () {
                  setState(() {
                    isTimeButtonClicked = false;
                    isDiffButtonClicked = false;
                    isCompButtonClicked = !isCompButtonClicked;
                  });
                },
              )
            ],
          ),
          if (isTimeButtonClicked)
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListPageButton(
                        text: '10분',
                        isButtonClicked: tenMin,
                        themecolor: const Color(0xffFFA517),
                        onPressed: () {
                          // "10분" 버튼 눌렀을 때 동작 구현
                          tenMin = !tenMin;
                          twentyMin = false;
                          thirtyMin = false;
                        },
                      ),
                      const SizedBox(width: 10),
                      ListPageButton(
                        text: '20분',
                        isButtonClicked: twentyMin,
                        themecolor: const Color(0xffFFA517),
                        onPressed: () {
                          // "20분" 버튼 눌렀을 때 동작 구현
                          tenMin = false;
                          twentyMin = !twentyMin;
                          thirtyMin = false;
                        },
                      ),
                      const SizedBox(width: 10),
                      ListPageButton(
                        text: '30분 이상',
                        isButtonClicked: thirtyMin,
                        themecolor: const Color(0xffFFA517),
                        onPressed: () {
                          // "30분 이상" 버튼 눌렀을 때 동작 구현
                          tenMin = false;
                          twentyMin = false;
                          thirtyMin = !thirtyMin;
                        },
                      ),
                    ],
                  ),
                )
              ],
            )
          else if (isDiffButtonClicked)
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListPageButton(
                        text: '왕초보',
                        isButtonClicked: isTimeButtonClicked,
                        themecolor: const Color(0xffFFA517),
                        onPressed: () {
                          // "왕초보" 버튼 눌렀을 때 동작 구현
                        },
                      ),
                      const SizedBox(width: 10),
                      ListPageButton(
                        text: '초급',
                        isButtonClicked: isTimeButtonClicked,
                        themecolor: const Color(0xffFFA517),
                        onPressed: () {
                          // "초급" 버튼 눌렀을 때 동작 구현
                        },
                      ),
                      const SizedBox(width: 10),
                      ListPageButton(
                        text: '중급',
                        isButtonClicked: isTimeButtonClicked,
                        themecolor: const Color(0xffFFA517),
                        onPressed: () {
                          // "중급" 버튼 눌렀을 때 동작 구현
                        },
                      ),
                    ],
                  ),
                )
              ],
            )
          else if (isCompButtonClicked)
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListPageButton(
                        text: '가볍게',
                        isButtonClicked: isTimeButtonClicked,
                        themecolor: const Color(0xffFFA517),
                        onPressed: () {
                          // "가볍게" 버튼 눌렀을 때 동작 구현
                        },
                      ),
                      const SizedBox(width: 10),
                      ListPageButton(
                        text: '든든하게',
                        isButtonClicked: isTimeButtonClicked,
                        themecolor: const Color(0xffFFA517),
                        onPressed: () {
                          // "든든하게" 버튼 눌렀을 때 동작 구현
                        },
                      ),
                    ],
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}
