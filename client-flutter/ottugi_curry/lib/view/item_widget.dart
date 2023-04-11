import 'package:flutter/material.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var imageNames = [
      'egg-benedict.jpeg',
      'hangtown-fry.jpeg',
      'sandwich.jpeg',
      'taco.jpeg'
    ];
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (BuildContext context, int i) {
        return Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            // card
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {},
                    child: Image.asset(
                      imageNames.length > i
                          ? "images/${imageNames[i]}"
                          : "images/taco.jpeg",
                      height: 120,
                      width: 120,
                    )),
                Expanded(
                  //flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        // 첫 번째 줄 (메뉴 이름, 북마크 아이콘)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 음식 이름 + 재료 설명
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: const Text(
                                    "Product Title",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // 북마크 아이콘
                            Container(
                              margin: const EdgeInsets.only(left: 8, right: 8),
                              alignment: Alignment.topLeft,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              child: const Icon(
                                Icons.bookmark_border_rounded,
                                size: 30,
                                color: Color(0xffFFD717),
                              ),
                            ),
                          ],
                        ),
                        // 두 번째 줄 (재료 목록)
                        Row(children: const [
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "재료 부분 당근, 간장, 소금, 후추, 계란, 이것, 저것.",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ]),
                        // 세 번째 줄 (아이콘 list)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                Icon(Icons.timer, size: 30),
                                Text("15분",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal))
                              ],
                            ),
                            Column(
                              children: const [
                                Icon(Icons.handshake_outlined, size: 30),
                                Text("초급",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal))
                              ],
                            ),
                            Column(
                              children: const [
                                Icon(Icons.food_bank_rounded, size: 30),
                                Text("든든하게",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal))
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
