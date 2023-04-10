import 'package:flutter/material.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var imageNames = ['egg-benedict.jpeg', 'hangtown-fry.jpeg', 'sandwich.jpeg', 'taco.jpeg'];
    return GridView.count(
      childAspectRatio: 0.68,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        for(int i = 0; i < 8; i++)
          Container(
            padding: const EdgeInsets.only(left:15, right: 15, top: 10),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xffFFD717),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "-50%",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  )
                ],
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.asset(
                    imageNames.length > i ? "images/${imageNames[i]}" : "images/taco.jpeg",
                    height: 120,
                    width: 120
                  )
                )
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Product Title",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  )
                )
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Wirte dexcrption of product",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "\$55",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffFFD717)
                      ),
                    ),
                    Icon(
                      Icons.shopping_cart_checkout,
                      color: Color(0xffFFD717)
                    )
                  ],
                ),
              )
            ],
            )
          )
      ],
    );
  }
}