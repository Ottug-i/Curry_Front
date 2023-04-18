import 'package:flutter/material.dart';

class TimeFilterWidget extends StatefulWidget {
  const TimeFilterWidget({super.key});

  @override
  _TimeFilterWidgetState createState() => _TimeFilterWidgetState();
}

class _TimeFilterWidgetState extends State<TimeFilterWidget> {
  bool _isTimeButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isTimeButtonClicked = !_isTimeButtonClicked;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Color(0xffFFD717), width: 2),
            ),
          ),
          child: const Text(
            '요리 시간',
            style: TextStyle(
              fontFamily: 'Poppins',
              letterSpacing: -1,
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Color(0xffFFD717),
            ),
          ),
        ),
        if (_isTimeButtonClicked)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // "10분" 버튼 눌렀을 때 동작 구현
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side:
                          const BorderSide(color: Color(0xffFFD717), width: 2),
                    ),
                  ),
                  child: const Text(
                    '10분',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      letterSpacing: -1,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color(0xffFFD717),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // "20분" 버튼 눌렀을 때 동작 구현
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side:
                          const BorderSide(color: Color(0xffFFD717), width: 2),
                    ),
                  ),
                  child: const Text(
                    '20분',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      letterSpacing: -1,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color(0xffFFD717),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // "30분 이상" 버튼 눌렀을 때 동작 구현
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side:
                          const BorderSide(color: Color(0xffFFD717), width: 2),
                    ),
                  ),
                  child: const Text(
                    '30분 이상',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      letterSpacing: -1,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color(0xffFFD717),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
