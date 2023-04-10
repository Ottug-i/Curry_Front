import 'package:flutter/material.dart';
//import 'package:badges/badges.dart';

class ListAppBar extends StatelessWidget {
  const ListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: const [
          Icon(
            Icons.arrow_back_rounded,
            size: 20,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "레시피 리스트",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
          ),
          Spacer(),
        ]
      ),
    );
  }
}