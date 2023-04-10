import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xffFFD717))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text("요리 시간",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: -1,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Color(0xffFFD717))),
                ],
              )),
          const SizedBox(width: 10),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xffFFD717))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text("난이도",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: -1,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Color(0xffFFD717))),
                ],
              )),
          const SizedBox(width: 10),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xffFFD717))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text("구성",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: -1,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Color(0xffFFD717))),
                ],
              ))
        ],
      ),
    );
  }
}
