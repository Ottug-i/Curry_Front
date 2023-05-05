import 'package:flutter/material.dart';

class ListPageButton extends StatelessWidget {
  final String text;
  final bool isButtonClicked;
  final Color themecolor;
  final VoidCallback onPressed;

  const ListPageButton({
    super.key,
    required this.text,
    required this.isButtonClicked,
    required this.themecolor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        backgroundColor: isButtonClicked ? themecolor : Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: themecolor, width: 1)),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Poppins',
            letterSpacing: -1,
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: isButtonClicked ? Colors.white : themecolor),
      ),
    );
  }
}
