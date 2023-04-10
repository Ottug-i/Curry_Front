
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for(int i = 1; i < 8; i++)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xffFFD717))
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1.png, 2.png 처럼 파일명을 지정하고 $i 변수를 이용해 사진 바꾸기
                  Image.asset("images/egg-benedict.jpeg", width: 40, height: 40),
                  const Text(
                    "Egg Benedict", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color(0xffFFD717)
                    )
                  ),
                ],
              )
            )
        ],
      ),
    );
  }
}