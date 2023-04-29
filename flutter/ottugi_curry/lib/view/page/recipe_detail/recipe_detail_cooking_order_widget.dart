import 'package:flutter/material.dart';
import 'package:ottugi_curry/config/color_schemes.dart';

List<String> cookingOrder = ['1. 기름 뺀 참치에 마요네즈 4.5 큰 술, 후춧가루 약간 넣고 잘 비벼주세요.',
  '볼에 계란 4-5개와 소금 한 꼬집을 넣고 잘 섞어줍니다.',
  '약불로 예열한 팬에 식용유를 약간 두른 뒤 계란물을 붓고 스크램블을 만들어요. '
      '* 부드럽고 촉촉한 에그 스크램블을 좋아하신다면 계란이 70% 정도 익었을 때 가스불을 꺼준 뒤 잔열에서 약간만 더 익혀드시면 되고요. '
      '고슬고슬한 에그 스크램블을 좋아하신다면 끝까지 익혀주시면 되겠슴당 :)',
  '그릇에 밥을 적당량 담아주시고요. 그 위에 에그 스크램블을 빙 둘러 올려준 뒤 가운데에 참치마요를 적당량 올려줍니다. '
      '마요네즈도 샤샥 뿌려주고 ~ 마지막으로 쪽파(통깨, 잘게 자른 조미김)를 올려 마무리해요.'

];

class RecipeDetailCookingOrderWidget extends StatefulWidget {
  const RecipeDetailCookingOrderWidget({Key? key}) : super(key: key);

  @override
  State<RecipeDetailCookingOrderWidget> createState() => _RecipeDetailCookingOrderWidgetState();
}

class _RecipeDetailCookingOrderWidgetState extends State<RecipeDetailCookingOrderWidget> with TickerProviderStateMixin {
  late TabController _nestedTabController;

  @override
  void initState() {
    super.initState();

    _nestedTabController = new TabController(length: cookingOrder.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          height: 326,
          child: TabBarView(
            controller: _nestedTabController,
              children: cookingOrder.map((e) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: 326,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('${e}'),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Image.asset('assets/images/tuna.png'),
                      ],
                    ),
                  ),
                );
              }).toList()),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: SizedBox(
            width: cookingOrder.length * 15,
            child: TabBar(
              controller: _nestedTabController,
              labelColor: lightColorScheme.secondary,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                shape: BoxShape.circle,
                color: lightColorScheme.secondary,
              ),
              dividerColor: Colors.transparent,
              tabs: cookingOrder.map((e) => const Tab(icon: Icon(Icons.circle, size: 10,))).toList()
            ),
          ),
        ),
      ],
    );
  }
}
