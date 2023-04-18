import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  CategoriesWidgetState createState() => CategoriesWidgetState();
}

class CategoriesWidgetState extends State<CategoriesWidget> {
  bool _isTimeButtonClicked = false;
  bool _isDiffButtonClicked = false;
  bool _isCompButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isTimeButtonClicked = !_isTimeButtonClicked;
                    _isDiffButtonClicked = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  backgroundColor: _isTimeButtonClicked
                      ? const Color(0xffFFD717)
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side:
                          const BorderSide(color: Color(0xffFFD717), width: 1)),
                ),
                child: Text(
                  "요리 시간",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      letterSpacing: -1,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: _isTimeButtonClicked
                          ? Colors.white
                          : const Color(0xffFFD717)),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isTimeButtonClicked = false;
                    _isDiffButtonClicked = !_isDiffButtonClicked;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  backgroundColor: _isDiffButtonClicked
                      ? const Color(0xffFFD717)
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side:
                          const BorderSide(color: Color(0xffFFD717), width: 1)),
                ),
                child: Text(
                  "난이도",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    letterSpacing: -1,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: _isDiffButtonClicked
                        ? Colors.white
                        : const Color(0xffFFD717),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isTimeButtonClicked = false;
                    _isDiffButtonClicked = false;
                    _isCompButtonClicked = !_isCompButtonClicked;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  backgroundColor: _isCompButtonClicked
                      ? const Color(0xffFFD717)
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side:
                          const BorderSide(color: Color(0xffFFD717), width: 1)),
                ),
                child: Text(
                  "구성",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    letterSpacing: -1,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: _isCompButtonClicked
                        ? Colors.white
                        : const Color(0xffFFD717),
                  ),
                ),
              ),
            ],
          ),
          if (_isTimeButtonClicked)
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // "10분" 버튼 눌렀을 때 동작 구현
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                                color: Color(0xffFFA517), width: 1),
                          ),
                        ),
                        child: const Text(
                          '10분',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            letterSpacing: -1,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xffFFA517),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // "20분" 버튼 눌렀을 때 동작 구현
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                                color: Color(0xffFFA517), width: 1),
                          ),
                        ),
                        child: const Text(
                          '20분',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            letterSpacing: -1,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xffFFA517),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // "30분 이상" 버튼 눌렀을 때 동작 구현
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                                color: Color(0xffFFA517), width: 1),
                          ),
                        ),
                        child: const Text(
                          '30분 이상',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            letterSpacing: -1,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xffFFA517),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          else if (_isDiffButtonClicked)
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // "왕초보" 버튼 눌렀을 때 동작 구현
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                                color: Color(0xffFFA517), width: 1),
                          ),
                        ),
                        child: const Text(
                          '왕초보',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            letterSpacing: -1,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xffFFA517),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // "초급" 버튼 눌렀을 때 동작 구현
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                                color: Color(0xffFFA517), width: 1),
                          ),
                        ),
                        child: const Text(
                          '초급',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            letterSpacing: -1,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xffFFA517),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // "중급" 버튼 눌렀을 때 동작 구현
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                                color: Color(0xffFFA517), width: 1),
                          ),
                        ),
                        child: const Text(
                          '중급',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            letterSpacing: -1,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xffFFA517),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          else if (_isCompButtonClicked)
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // "가볍게" 버튼 눌렀을 때 동작 구현
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                                color: Color(0xffFFA517), width: 1),
                          ),
                        ),
                        child: const Text(
                          '가볍게',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            letterSpacing: -1,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xffFFA517),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // "든든하게" 버튼 눌렀을 때 동작 구현
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                                color: Color(0xffFFA517), width: 1),
                          ),
                        ),
                        child: const Text(
                          '든든하게',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            letterSpacing: -1,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xffFFA517),
                          ),
                        ),
                      )
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
