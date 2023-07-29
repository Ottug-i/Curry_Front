import 'package:flutter/material.dart';
//import 'package:badges/badges.dart';

class RecipeListAppBar extends StatelessWidget {
  const RecipeListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF5F5F5),
      padding: const EdgeInsets.all(20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back_rounded,
              size: 20,
              color: Colors.black,
            ),
            Text(
              "추천 레시피",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  letterSpacing: -1,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(),
          ]),
    );
  }
}
