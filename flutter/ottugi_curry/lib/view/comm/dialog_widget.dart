import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';

class DialogOutLineWidget extends StatelessWidget {
  final String title;
  final Widget body;

  const DialogOutLineWidget({Key? key,
  required this.title,
  required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: Container(
        padding:
        const EdgeInsets.only(bottom: 30, left: 20, right: 20, top: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              color: lightColorScheme.primary,
              width: 5,
            ),
            color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 23,
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.black,
                  onPressed: () {
                    Get.back();
                  },
                ),
                Text(title, style: Theme.of(context).textTheme.bodyLarge,),
                const Padding(padding: EdgeInsets.only(left: 50)),
              ],
            ),
            body,
          ],
        ),
      ),

    );

  }
}
