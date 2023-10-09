import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/utils/long_string_to_list_utils.dart';
import 'package:ottugi_curry/utils/screen_size_utils.dart';
import 'package:ottugi_curry/utils/user_profile_utils.dart';
import 'package:ottugi_curry/utils/bookmark_snack_bar.dart';

// Recipe List Page, Text Search Page에서 사용함
class ListItemWidget extends StatelessWidget {
  final RecipeResponse menuItem;
  final controller;

  const ListItemWidget({required this.menuItem, this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/recipe_detail', arguments: menuItem.recipeId);
      },
      child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          // card
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: isWidthMobile(context) == true ? 3 : 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: Image.network(
                    '${menuItem.thumbnail}',
                    fit: BoxFit.fill,
                    height: 100,
                    width: 150,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      // 첫 번째 줄 (메뉴 이름, 북마크 아이콘)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 음식 이름
                          Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    '${menuItem.name}',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          // 북마크 아이콘
                          Expanded(
                            flex: 2,
                            child: IconButton(
                              icon: Icon(menuItem.isBookmark!
                                  ? Icons.bookmark_rounded
                                  : Icons.bookmark_border_rounded),
                              iconSize: 30,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              color: lightColorScheme.primary,
                              onPressed: () {
                                // 공통 위젯을 위한 컨트롤러 변수 사용
                                controller.updateBookmark(
                                    getUserId(), menuItem.recipeId);

                                // 북마크 추가/삭제 스낵바 실행
                                bookmarkSnackBar(isBookmark: menuItem.isBookmark!, name: menuItem.name!);
                              },
                            ),
                          )
                        ],
                      ),
                      // 두 번째 줄 (재료 목록)
                      Row(children: [
                        Expanded(
                            child: Text(
                          extractOnlyContent(menuItem.ingredients ?? ''),
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ]),
                      const SizedBox(
                        height: 10,
                      ),
                      // 세 번째 줄 (아이콘 - 시간, 난이도, 구성)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          iconWithText(context, 'time', 30, '${menuItem.time}'),
                          iconWithText(
                              context, 'chef2', 30, '${menuItem.difficulty}'),
                          iconWithText(
                              context, 'meal', 33, '${menuItem.composition}'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

Column iconWithText(
    BuildContext context, String icon, double size, String text) {
  return Column(
    children: [
      // Icon(icon, size: 30),
      ImageIcon(
        AssetImage('assets/icons/$icon.png'),
        size: size,
      ),
      const Padding(padding: EdgeInsets.only(bottom: 2)),
      Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
        overflow: TextOverflow.ellipsis,
      )
    ],
  );
}
