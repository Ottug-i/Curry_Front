import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/controller/recipe_detail/recipe_detail_controller.dart';

class RecipeDetailGalleryViewWidget extends StatefulWidget {
  const RecipeDetailGalleryViewWidget({Key? key}) : super(key: key);

  @override
  State<RecipeDetailGalleryViewWidget> createState() => _RecipeDetailGalleryViewWidgetState();
}

class _RecipeDetailGalleryViewWidgetState extends State<RecipeDetailGalleryViewWidget> with TickerProviderStateMixin {
  late TabController _nestedTabController;

  @override
  void initState() {
    super.initState();
    Get.put(RecipeDetailController);

    _nestedTabController = TabController(length: Get.find<RecipeDetailController>().orders.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RecipeDetailController);
    final recipeDetailController = Get.find<RecipeDetailController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          height: 300,
          child: TabBarView(
            controller: _nestedTabController,
              children: recipeDetailController.orders.map((e) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network('${recipeDetailController.photo[recipeDetailController.orders.indexOf(e)]}'),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Text('${e}'),
                      ],
                    ),
                  ),
                );
              }).toList()),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: SizedBox(
            width: recipeDetailController.orders.length * 15,
            child: TabBar(
              controller: _nestedTabController,
              labelColor: lightColorScheme.secondary,
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                shape: BoxShape.circle,
                color: lightColorScheme.secondary,
              ),
              dividerColor: Colors.transparent,
              tabs: recipeDetailController.orders.map((e) => const Tab(icon: Icon(Icons.circle, size: 10,))).toList()
            ),
          ),
        ),
      ],
    );
  }
}
