import 'package:flutter/material.dart';
//import 'package:badges/badges.dart';

class ListAppBar extends StatelessWidget {
  const ListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(children: const [
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
