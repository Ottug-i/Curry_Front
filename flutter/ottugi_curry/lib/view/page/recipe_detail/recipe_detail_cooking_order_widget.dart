import 'package:flutter/material.dart';
import 'package:ottugi_curry/config/color_schemes.dart';

List<String> cookingOrder = ['1. 당근과 애호박은 잘게 다지듯 썰어줍니다. 참고로 애호박은 초록부분만 돌려깍기해서 사용했어요. 그리고 피자치즈도 넉넉히 준비해주세요.',
  '2. 볼이 넓은 그릇에 계란 4개와 당근, 애호박, 그리고 피자치즈를 넣은 후 다진마늘과 소금 그리고 설탕을 넣어 거품기로 마구 저어주세요. 이 때 너무 오래 저어주면 거품이 생기는 데 거품이 생기기 전에 멈춰주세요.',
  '3. 약불로 예열한 팬에 식용유를 약간 두른 뒤 계란물을 붓고 스크램블을 만들어요.',
  '4. 팬에 기름을 두른 후 키친타올로 살짝 닦아내 주세요. 기름이 골고루 묻어나도록 말이죠. 그리고 약 2/3가량의 계란물을 넣어준 후 중약불에서 서서히 익혀주세요.',
  '5. 약 80% 가량 익혀준 후 돌돌 말아주시고 조금 남겨두었던 나머지 계란물을 한켠에 부어 다시한번 돌돌 말아줍니다.',
  '6. 중약불에서 익혀낸 치즈야채계란말이랍니다. 계란말이는 한 김 충분히 식혀준 후 알맞은 크기로 썰어주세요.',
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

    _nestedTabController = TabController(length: cookingOrder.length, vsync: this);
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
          height: 285,
          child: TabBarView(
            controller: _nestedTabController,
              children: cookingOrder.map((e) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(e),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Image.asset('assets/images/cookingOrder${cookingOrder.indexOf(e)+1}.png'),
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
